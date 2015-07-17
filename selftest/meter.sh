#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

# input
#ovs-ofctl add-flow br0 in_port=48,actions=output:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46
ovs-ofctl add-flow br0 in_port=48,actions=output:1
#ovs-ofctl add-flow br0 in_port=47,actions=output:46
# output
#ovs-ofctl add-flow br0 in_port=46,actions=output:47
#ovs-ofctl add-flow br0 in_port=1,actions=output:48

for i in `seq 1 46` ; do
	ovs-ofctl add-meter br0 meter=$i,kbps,band=type=drop,rate=300000
	#ovs-ofctl add-flow br0 in_port=$i,actions=meter:$i,output:47
	ovs-ofctl add-flow br0 in_port=$i,actions=output:47
done

