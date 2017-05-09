#!/bin/bash

source /etc/openvpn/easy-rsa/vars
/etc/openvpn/easy-rsa/clean-all
source /etc/openvpn/easy-rsa/vars
/etc/openvpn/easy-rsa/build-ca < /etc/openvpn/easy-rsa/input_ca.txt
/etc/openvpn/easy-rsa/build-key-server server < /etc/openvpn/easy-rsa/input_ser.txt
/etc/openvpn/easy-rsa/build-dh
