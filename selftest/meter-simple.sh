#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

ovs-ofctl add-meter br0 meter=1,kbps,band=type=drop,rate=$(($1 * 1000))
ovs-ofctl add-flow br0 in_port=48,actions=meter:1,output:47
#ovs-ofctl add-flow br0 in_port=48,actions=output:47

