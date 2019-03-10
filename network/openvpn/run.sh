#! /bin/sh

cd /etc/openvpn.d

for config in *.config; do
  openvpn --daemon --config $config
done

tail -f /dev/null
