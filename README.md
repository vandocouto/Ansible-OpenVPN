### Playbook - Ansible OpenVPN for Ubuntu 16.04

Step 1 - Clone project 

<pre>
# git clone https://github.com/vandocouto/Ansible-OpenVPN.git
</pre>

Step 2 - Set as variables

<pre>
# vim hosts
</pre>

###### Configure according to your environment

Example: 

54.152.178.130 - Server OpenVPN

ansible_ssh_private_key_file=chave/Blog-Estudo.pem


<pre>
[openvpn]
54.152.178.130

[all:vars]
COUNTRY=BR
PROVINCE=SaoPaulo
CITY=SaoPaulo
EMAIL=vandocouto@gmail.com
OU=TGL
KEY_ORG=tutoriaisgnulinux
KEY_NAME=ServerOpenVPN
INTERFACE=eth0
NETWORK=10.10.10.0/24
SUBNET=10.10.10.0
NETMASK=255.255.255.0
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=chave/Blog-Estudo.pem
</pre>

Step 3 - Run playbook
<pre>
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts ./tasks/main.yml
</pre>

##### Go to the instance and follow the steps below

<pre>
# cd /etc/openvpn/easy-rsa
</pre>

Step 4 - Creating the first certificate for the first client

<pre>
# source ./vars
# ./build-key client
</pre>

If you want to set a passphrase for the private key of client's private key, you can use the following command.

<pre>
# ./build-key-pass client
</pre>
<pre>
# cd keys/
</pre>

<pre>
# ls -ltr
total 80
-rw------- 1 root root 1704 May  8 19:54 ca.key
-rw-r--r-- 1 root root 1724 May  8 19:54 ca.crt
-rw------- 1 root root 1704 May  8 19:54 server.key
-rw-r--r-- 1 root root 1082 May  8 19:54 server.csr
-rw-r--r-- 1 root root 5587 May  8 19:54 server.crt
-rw-r--r-- 1 root root    3 May  8 19:54 serial.old
-rw-r--r-- 1 root root  135 May  8 19:54 index.txt.old
-rw-r--r-- 1 root root   21 May  8 19:54 index.txt.attr.old
-rw-r--r-- 1 root root 5587 May  8 19:54 01.pem
-rw-r--r-- 1 root root  424 May  8 19:55 dh2048.pem
-rw-r--r-- 1 root root 1082 May  8 19:57 client.csr
-rw-r--r-- 1 root root    3 May  8 19:57 serial
-rw-r--r-- 1 root root   21 May  8 19:57 index.txt.attr
-rw-r--r-- 1 root root  270 May  8 19:57 index.txt
-rw-r--r-- 1 root root 5465 May  8 19:57 client.crt
-rw-r--r-- 1 root root 5465 May  8 19:57 02.pem
-rw------- 1 root root    0 May  8 19:57 client.key
</pre>

##### Install openvpn client

Step 5 - For Ubuntu/Debian run the following commands.


<pre>
# apt-get install openvpn
</pre>

Step 6 - Now copy the client certificates and keys along with CA certificate on your client machine using SCP or FTP. Move the files into /etc/openvpn/easy-rsa directory. Now create a new file using your favorite text editor.


<pre>
# vim /etc/openvpn/client.ovpn
</pre>

Step 7 - Create file configuration 
<pre>
client
dev tun
proto udp
remote IP-SERVER-VPN 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
ca ca.crt
cert client.crt
key client.key
</pre>
##### Start VPN

<pre>
# openvpn --config client.ovpn
</pre>
