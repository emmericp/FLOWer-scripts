while true ; do date +%s.%N ; ovs-appctl pica/dump-flows | tail -n 1 ; sleep 0.05  ; done | tee insertion-time.txt
