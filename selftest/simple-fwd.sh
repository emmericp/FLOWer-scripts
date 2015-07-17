#!/bin/bash
ovs-ofctl del-flows br0

ovs-ofctl add-flow br0 in_port=48,actions=output:47
ovs-ofctl add-flow br0 in_port=47,actions=output:48
