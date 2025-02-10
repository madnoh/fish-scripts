function whatismyip
    echo -n "local IP: "
    ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{ print $2 }' | cut -d'/' -f1
    echo -n "IPv4: "
    curl -4 ip.network
    echo -n "IPv6: "
    ip addr show | grep 'inet6 ' | awk '{ print $2 }' | cut -d'/' -f1 | sed -n '2p'
    #curl -6 ip.network
end
