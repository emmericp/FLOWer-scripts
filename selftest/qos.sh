#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

#DO_QOS=1

ovs-vsctl clear port te-1/1/47 qos
ovs-vsctl --all destroy qos
ovs-vsctl --all destroy queue

ovs-vsctl -- set port te-1/1/47 qos=@newqos -- --id=@newqos create qos type=PRONTO_STRICT queues:0=@newqueue queues:7=@newqueue1 -- --id=@newqueue create queue other-config:min-rate=10000000000 other-config:max-rate=10000000000 -- --id=@newqueue1 create queue other-config:min-rate=10000000000 other-config:max-rate=10000000000

# input
if [[ $DO_QOS ]]
then
	ovs-ofctl add-flow br0 in_port=48,udp,tp_dst=42,actions=set_queue:7,output:47
else
	ovs-ofctl add-flow br0 in_port=48,udp,tp_dst=42,actions=output:47
fi
ovs-ofctl add-flow br0 in_port=48,udp,tp_dst=43,actions=output:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46

for i in `seq 1 46` ; do
if [[ $DO_QOS ]]
then
	ovs-ofctl add-flow br0 in_port=$i,actions=set_queue:0,output:47
else
	ovs-ofctl add-flow br0 in_port=$i,actions=output:47
fi
done

