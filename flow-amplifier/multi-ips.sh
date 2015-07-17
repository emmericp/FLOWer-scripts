#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0
ovs-ofctl del-groups br0

# send traffic
ovs-ofctl add-group br0 group_id=1,type=all,bucket=mod_nw_dst:10.0.0.1,output:1,bucket=mod_nw_dst:10.0.0.2,output:2,bucket=mod_nw_dst:10.0.0.3,output:3,bucket=mod_nw_dst:10.0.0.4,output:4,bucket=mod_nw_dst:10.0.0.5,output:5,bucket=mod_nw_dst:10.0.0.6,output:6,bucket=mod_nw_dst:10.0.0.7,output:7,bucket=mod_nw_dst:10.0.0.8,output:8,bucket=mod_nw_dst:10.0.0.9,output:9,bucket=mod_nw_dst:10.0.0.10,output:10,bucket=mod_nw_dst:10.0.0.11,output:11,bucket=mod_nw_dst:10.0.0.12,output:12,bucket=mod_nw_dst:10.0.0.13,output:13,bucket=mod_nw_dst:10.0.0.14,output:14,bucket=mod_nw_dst:10.0.0.15,output:15,bucket=mod_nw_dst:10.0.0.16,output:16,bucket=mod_nw_dst:10.0.0.17,output:17,bucket=mod_nw_dst:10.0.0.18,output:18,bucket=mod_nw_dst:10.0.0.19,output:19,bucket=mod_nw_dst:10.0.0.20,output:20,bucket=mod_nw_dst:10.0.0.21,output:21,bucket=mod_nw_dst:10.0.0.22,output:22,bucket=mod_nw_dst:10.0.0.23,output:23,bucket=mod_nw_dst:10.0.0.24,output:24,bucket=mod_nw_dst:10.0.0.25,output:25,bucket=mod_nw_dst:10.0.0.26,output:26,bucket=mod_nw_dst:10.0.0.27,output:27,bucket=mod_nw_dst:10.0.0.28,output:28,bucket=mod_nw_dst:10.0.0.29,output:29,bucket=mod_nw_dst:10.0.0.30,output:30,bucket=mod_nw_dst:10.0.0.31,output:31,bucket=mod_nw_dst:10.0.0.32,output:32
ovs-ofctl add-flow br0 in_port=48,ip,actions=group:1

# count traffic via explicit 'drop' flows
# forward timestamped traffic (different ttl) to the packet generator
for i in `seq 1 32` ; do
	# unfortunately not supported by our switch, but works with a software OvS or other switches
	ovs-ofctl add-flow br0 in_port=$i,ip,nw_ttl=64,actions=drop
	ovs-ofctl add-flow br0 in_port=$i,ip,nw_ttl=63,actions=output:48
done

