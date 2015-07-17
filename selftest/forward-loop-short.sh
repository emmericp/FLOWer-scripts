#!/bin/bash
ovs-ofctl del-flows br0

echo $1

# input
ovs-ofctl add-flow br0 in_port=48,actions=output:$((47 - $1 * 2))
# output
ovs-ofctl add-flow br0 in_port=46,actions=output:47

for i in `seq 2 2 44` ; do
	ovs-ofctl add-flow br0 in_port=$i,actions=output:$(($i+1))
done

