#!/usr/bin/env bash
set -e
if [ "$1" == "--help" ]; then
	echo "Example entrypoint, use --start to run it" > /dev/stderr
	exit 0
fi

# Demonstration of volumes
if [ -n "$VOL_FILE" ]; then
	cat "$VOL_FILE" > /dev/stderr
fi

if [ "$1" == "--start" ]; then
	echo "[$(date --iso-8601=s)] Starting router with arguments \"$@\"" > /dev/stderr

	# Demonstration of routes creation at runtime 
	if [[ -n "$ROUTE6_GW" && -n "$ROUTE6_NET" ]]; then
		ip -6 route add "$ROUTE6_NET" via "$ROUTE6_GW" proto static
	fi
	if [[ -n "$ROUTE4_GW" && -n "$ROUTE4_NET" ]]; then
		ip -4 route add "$ROUTE4_NET" via "$ROUTE4_GW" proto static
	fi

	# Remove default route
	ip -6 route delete default
	ip -4 route delete default

	# Display IP Addresses
	ip address list > /dev/stderr

	# Keep the container up 
	exec sleep infinity
fi
exit 1
