#! /bin/bash

cd /etc/openvpn

function stop {
  for pid in /var/openvpn/pid/*.pid; do
    kill -s SIGTERM `cat $pid`
  done
  exit 0
}

for config in *.ovpn; do
  openvpn --daemon --writepid /var/openvpn/pid/$config.pid --config $config
done

trap stop SIGTERM

while true; do :; done
