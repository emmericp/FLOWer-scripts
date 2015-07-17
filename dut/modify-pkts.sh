#!/bin/bash
ovs-ofctl del-flows br0
ovs-ofctl del-meters br0

#action=mod_nw_dst=1.2.3.4
action=mod_dl_src=11:22:33:44:55:66,mod_dl_dst=77:88:99:AA:BB:CC,mod_nw_dst=1.2.3.4,mod_nw_src=3.4.5.6,mod_tp_src=123,mod_tp_dst=456


for i in `seq 1 31` ; do
	ovs-ofctl add-flow br0 in_port=$i,ip,udp,actions=$action,output:$(($i + 1))
done
ovs-ofctl add-flow br0 in_port=32,ip,udp,actions=$action,output:1
