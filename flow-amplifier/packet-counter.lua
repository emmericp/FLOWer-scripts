#!/usr/bin/env lua


local function run(cmd, ...)
	local f = io.popen(cmd:format(...))
	local r = f:read("*a")
	f:close()
	return r
end

local function getTime()
	return tonumber(run("date +%%s.%%N"))
end


local stats, lastStats = {}, {}

local time, lastTime = 0, 0

while true do
	local flows = run("ovs-ofctl dump-flows br0") 
	lastTime = time
	time = getTime()
	for flow in flows:gmatch("(.-)\n") do
		local bytes, port = flow:match("n_bytes=(%d+), in_port=(%d+)")
		if bytes and port then
			bytes, port = tonumber(bytes), tonumber(port)
			lastStats[port] = stats[port]
			stats[port] = bytes
		end
	end
	print("Elapsed time: " .. (time - lastTime))
	for i = 1, 48 do
		if stats[i] and lastStats[i] then
			print(("Port %02d, %d MBit/s"):format(i, (stats[i] - lastStats[i]) / (time - lastTime) * 8 / 1000000 ))
		end
	end
	print()
	run("sleep 1")
end

