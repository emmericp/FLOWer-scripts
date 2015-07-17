#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

# flows per port
FLOWS=40

PRIO=10000

for i in `seq 1 31` ; do
	for flow in `seq 1 $FLOWS` ; do
		#ovs-ofctl add-flow br0 in_port=$i,ip,udp,tp_dst=$flow,actions=output:$(($i + 1))
		ovs-ofctl add-flow br0 priority=$PRIO,in_port=$i,ip,udp,tp_dst=$flow,actions=output:$(($i + 1))
		PRIO=$(($PRIO + 1))
	done
done

for flow in `seq 1 $FLOWS` ; do
#	ovs-ofctl add-flow br0 in_port=32,ip,udp,tp_dst=$flow,actions=output:1
	ovs-ofctl add-flow br0 in_port=32,priority=$PRIO,ip,udp,tp_dst=$flow,actions=output:1
	PRIO=$(($PRIO + 1))
done

