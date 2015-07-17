#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

for i in `seq 1 31` ; do
	ovs-ofctl add-flow br0 in_port=$i,actions=$(($i + 1))
done
ovs-ofctl add-flow br0 in_port=32,actions=1
