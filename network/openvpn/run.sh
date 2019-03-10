#! /bin/sh

cd /etc/openvpn.d

for config in *.ovpn; do
  openvpn --daemon --config $config
done

tail -f /dev/null
