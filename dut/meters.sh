#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

for i in `seq 1 100` ; do
	ovs-ofctl add-meter br0 meter=$i,kbps,band=type=drop,rate=600000
done

for i in `seq 1 10` ; do
	for flow in `seq 1 100` ; do
		ovs-ofctl add-flow br0 in_port=$i,ip,nw_src=10.0.0.$flow,actions=meter:$flow,output:$(($i + 1))
	done
done
#for flow in `seq 1 100` ; do
#	ovs-ofctl add-flow br0 in_port=32,ip,nw_src=10.0.0.$flow,actions=meter:$flow,output:1
#done
