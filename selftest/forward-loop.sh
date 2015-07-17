#!/bin/bash
ovs-ofctl del-flows br0

# input
ovs-ofctl add-flow br0 in_port=48,actions=output:1
ovs-ofctl add-flow br0 in_port=47,actions=output:46
# output
ovs-ofctl add-flow br0 in_port=46,actions=output:47
ovs-ofctl add-flow br0 in_port=1,actions=output:48

for i in `seq 2 2 44` ; do
	ovs-ofctl add-flow br0 in_port=$i,actions=output:$(($i+1))
	ovs-ofctl add-flow br0 in_port=$(($i+1)),actions=output:$i
done

