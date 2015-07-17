#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

# flows per port
FLOWS=100

PRIO=10000

ovs-vsctl set-match-mode ip=10-50000

for i in `seq 1 31` ; do
	for flow in `seq 1 $FLOWS` ; do
		ovs-ofctl add-flow br0 priority=$PRIO,in_port=$i,ip,nw_proto=17,nw_src=1.2.3.4,nw_dst=10.0.0.$flow,dl_type=0x0800,actions=output:$(($i + 1))
		PRIO=$(($PRIO - 1))
	done
done

for flow in `seq 1 $FLOWS` ; do
	ovs-ofctl add-flow br0 priority=$PRIO,in_port=32,ip,nw_proto=17,nw_src=1.2.3.4,nw_dst=10.0.0.$flow,dl_type=0x0800,actions=output:1
	PRIO=$(($PRIO - 1))
done

