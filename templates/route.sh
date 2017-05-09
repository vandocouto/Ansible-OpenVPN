#!/bin/bash

    sleep 30
    # Masquerade traffic from VPN to "the world" -- done in the nat table
    iptables -t nat -I POSTROUTING -o {{ INTERFACE }} -s {{ NETWORK }} -j MASQUERADE
