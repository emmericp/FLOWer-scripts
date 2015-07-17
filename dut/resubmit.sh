#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0


for i in `seq 1 32` ; do
	ovs-ofctl add-flow br0 in_port=$i,ip,udp,actions=mod_nw_dst=1.2.3.$i,resubmit\(33,\)
done


for i in `seq 1 32` ; do
	ovs-ofctl add-flow br0 in_port=33,ip,udp,nw_dst=1.2.3.$i,actions=output:$(($i + 1))
done
