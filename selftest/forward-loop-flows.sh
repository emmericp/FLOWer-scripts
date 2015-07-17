#!/bin/bash
ovs-ofctl del-flows br0

ovs-ofctl add-flow br0 in_port=2,actions=output:47

# input
for j in 0 1 2 3 4 5 6 7 8; do
for i in `seq 1 255` ; do
	ovs-ofctl add-flow br0 in_port=48,ip,nw_src=10.0.$j.$i,actions=output:1
done
done

# output
#ovs-ofctl add-flow br0 in_port=1,actions=output:48

#for i in `seq 2 2 44` ; do
#	ovs-ofctl add-flow br0 in_port=$i,actions=output:$(($i+1))
#	ovs-ofctl add-flow br0 in_port=$(($i+1)),actions=output:$i
#done

