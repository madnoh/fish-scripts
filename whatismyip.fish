function whatismyip

    # Get the start time in nano seconds
    set start_time (date +%s%N)

    echo -n "local IP: "
    ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{ print $2 }' | cut -d'/' -f1
    
    echo -n "IPv4: "
    echo "$(curl -s -4 ip.network)"
    
    echo -n "IPv6: "
    ip addr show | grep 'inet6 ' | awk '{ print $2 }' | cut -d'/' -f1 | sed -n '2p'

    # Get end time in nanoseconds
    set end_time (date +%s%N)

    # Calculate elapsed time converted to miliseconds
    set elapsed_time (math "($end_time - $start_time) / 1000000")

    # Output the time taken
    echo "Time taken: $elapsed_time ms"
end
