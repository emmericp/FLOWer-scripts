#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

# send traffic
ovs-ofctl add-flow br0 in_port=48,actions=output:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32

# count traffic via explicit 'drop' flows

for i in `seq 1 32` ; do
	ovs-ofctl add-flow br0 in_port=$i,actions=drop
done

