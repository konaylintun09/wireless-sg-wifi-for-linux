# wireless-sg-wifi-for-linux

This Repository for Wireless@SG public Wi-Fi configuration

Naungsai : Registers for a new Wireless@SG account to use the public wi-fi
==========================================================================

## Dependencies
python3 -m pip install -r require.txt

Note: Requires a version of pycryptodome supports AES in CCM mode.

# Basic steps
You may need to create an account, that account should be valid mobile number ( cause of, will send the OTP SMS to your phone number) and need to use your dob (Date of Birth).
A mobile numer / dob will pair or will be uniquely identify a user account.

# Use the python3 command and follow to the command format: 

#<command script (phone number) dob>

python3 naungsai.py (phone number) (dob)

the below is sample command used in my system.
```
$ python3 naungsai.py 658XXXXXXX 03062021
OTP will be sent to mobile phone number 658XXXXXXX
Enter OTP to continue: XXXXXX
Credentials:
 userid = 'XXXX'
 password = 'XXXX'
 ```
# If you already created an account with same phone number, you can use the retrieve mode.
```
$ python3 naungsai.py -r 658XXXXXXX 03062021
OTP will be sent to mobile phone number 658XXXXXXX
Enter OTP to continue: XXXXXX
Credentials:
 userid = 'XXXX'
 password = 'XXXX'
```

### Docker
After successful of the Basic steps, the next step will has to do a Docker configuration.
You just follow command format. I already used that below format.
```
# Build the docker
$ docker build -t naungsai .

# New a Register mode
$ docker run -it --rm naungsai 658XXXXXXX 03062021

# Retrieve mode
$ docker run -it --rm naungsai -r 658XXXXXXX 03062021
```
### Configuration Steps
Has to configure WPA Supplicant and Network configuration after finished of the Docker config.

### WPA config
you will have to create the naungsai.conf file.

```
$ vim naungsai.conf
network={
        ssid="Wireless@SGx"
        key_mgmt=WPA-EAP
        eap=PEAP
        identity="<userid>"
        password="<password>"
}
```
### Config to NetworkManager or Network interface

You may need to change the UUID number, userid for identify and password. userid and password can take from  basic steps. UUID is depend on your system hardware.

```
$ vim /etc/NetworkManager/system-connections/Wireless@SGx.nmconnection

[wifi-security]
key-mgmt=wpa-eap

[connection]
id=Wireless@SGx
uuid=<valid UUID>
type=wifi

[wifi]
mode=infrastructure
ssid=Wireless@SGx
security=802-11-wireless-security

[802-1x]
eap=peap
phase2-auth=mschapv2
identity=<userid>
password=<password>

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto

[proxy]
```
