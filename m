From: DIXLOR <dixlor@gmail.com>
Subject: SMP even/odd cores latency
Date: Wed, 3 Feb 2016 22:06:13 +0300
Message-ID: <56B24FA5.8020706@gmail.com>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000903020308000200070005"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36366 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965676AbcBCTGS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Feb 2016 14:06:18 -0500
Received: by mail-lb0-f174.google.com with SMTP id dx2so17816947lbd.3
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Feb 2016 11:06:16 -0800 (PST)
Received: from [192.168.1.2] (ppp83-237-163-223.pppoe.mtu-net.ru. [83.237.163.223])
        by smtp.googlemail.com with ESMTPSA id h187sm1064280lfg.18.2016.02.03.11.06.14
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 11:06:15 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms000903020308000200070005
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

# ./cyclictest -sm -n -p99 --policy=3Dfifo -S -D60
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 2.89 1.37 0.64 1/506 15232

T: 0 (15179) P:99 I:1000 C:  59999 Min:     14 Act:   56 Avg:   51 Max:  =
    99
T: 1 (15180) P:99 I:1500 C:  39999 Min:      3 Act:   13 Avg:   29 Max:  =
   100
T: 2 (15181) P:99 I:2000 C:  29999 Min:     12 Act:   50 Avg:   48 Max:  =
   101
T: 3 (15182) P:99 I:2500 C:  23999 Min:      4 Act:   13 Avg:   29 Max:  =
   101
T: 4 (15183) P:99 I:3000 C:  19999 Min:     16 Act:   60 Avg:   51 Max:  =
   104
T: 5 (15184) P:99 I:3500 C:  17142 Min:      4 Act:   60 Avg:   30 Max:  =
   102
T: 6 (15185) P:99 I:4000 C:  14999 Min:     14 Act:   29 Avg:   51 Max:  =
   106
T: 7 (15186) P:99 I:4500 C:  13333 Min:      4 Act:   11 Avg:   32 Max:  =
   106
T: 8 (15187) P:99 I:5000 C:  11999 Min:     17 Act:   42 Avg:   47 Max:  =
    90
T: 9 (15188) P:99 I:5500 C:  10908 Min:      5 Act:   40 Avg:   29 Max:  =
    89
T:10 (15189) P:99 I:6000 C:   9999 Min:     18 Act:   43 Avg:   49 Max:  =
    99
T:11 (15190) P:99 I:6500 C:   9230 Min:      5 Act:   28 Avg:   29 Max:  =
    99
T:12 (15191) P:99 I:7000 C:   8571 Min:     14 Act:   56 Avg:   47 Max:  =
    98
T:13 (15192) P:99 I:7500 C:   7999 Min:      5 Act:   11 Avg:   31 Max:  =
    97
T:14 (15193) P:99 I:8000 C:   7499 Min:     16 Act:   64 Avg:   49 Max:  =
   100
T:15 (15194) P:99 I:8500 C:   7058 Min:      5 Act:   42 Avg:   30 Max:  =
    96



Minimum latency on even cores is approximately equal to 15, on the odd - =
5=20
=D0=90verage latency on the even - 50, on the odd cores - 30 :)

- Linux 4.4.1-rt4+ x86_64
- gcc version 4.9.2 (Debian 4.9.2-10)
- 2 x AMD Opteron(tm) Processor 4386
- Mb: TYAN S8225



--------------ms000903020308000200070005
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Криптографическая подпись S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Ck8wggSxMIIDmaADAgECAhBbLvAL7CpbaYZ7xtCHUmdkMA0GCSqGSIb3DQEBCwUAMFYxCzAJ
BgNVBAYTAkNOMRowGAYDVQQKExFXb1NpZ24gQ0EgTGltaXRlZDErMCkGA1UEAwwiQ0Eg5rKD
6YCaIEVtYWlsIOWuouaIt+err+ivgeS5piBHMjAeFw0xNTA4MTMxMDEzMDRaFw0xODA4MTMx
MDEzMDRaMDwxGTAXBgNVBAMMEGRpeGxvckBnbWFpbC5jb20xHzAdBgkqhkiG9w0BCQEWEGRp
eGxvckBnbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDJoN4sNreJ
MuGn56VM4fPCJsuHZx+ZXjbr4O325Zq0fTfZ0/SubgjzytYRdgbvCKE+cYX/rrQWYvCD++Xu
2ZAGLnOLyp0wiwX3jRi4zxH1k1V8H6g87GmuinA+Izid6EVsv96iTvGsXLXNsqfItM7YHA6p
l5apjHNQj0jY8ofWatyGa/CHN/0mED/P7vPoA4Mvi5U/1++xEQHRir7GtRlAi/Iu+KXT8bpL
gvnuAdMQbIp7XZB5AYfHDEo/1j0JI70jVcjxoRMELVKXIMxH+SLZR/b1poWv8iJPTLhsdOzx
F7fw4y9QQLc7+2O8mn46YgpN6QXVvTT+FjgiSluNMAcJAgMBAAGjggGTMIIBjzALBgNVHQ8E
BAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0O
BBYEFFMSojiy9brHblax+Yry/i2jCuf0MB8GA1UdIwQYMBaAFAi9toUMvYZZjUTFCjFrO2r4
1wh+MHUGCCsGAQUFBwEBBGkwZzAwBggrBgEFBQcwAYYkaHR0cDovL29jc3AyLndvc2lnbi5j
bi9jYTJnMi9jbGllbnQxMDMGCCsGAQUFBzAChidodHRwOi8vYWlhMi53b3NpZ24uY24vY2Ey
ZzIuY2xpZW50MS5jZXIwOQYDVR0fBDIwMDAuoCygKoYoaHR0cDovL2NybHMyLndvc2lnbi5j
bi9jYTJnMi1jbGllbnQxLmNybDAbBgNVHREEFDASgRBkaXhsb3JAZ21haWwuY29tMEcGA1Ud
IARAMD4wPAYNKwYBBAGCm1EGAQEBAjArMCkGCCsGAQUFBwIBFh1odHRwOi8vd3d3Lndvc2ln
bi5jb20vcG9saWN5LzANBgkqhkiG9w0BAQsFAAOCAQEAwfGPem37jTnVHPzIXPLF9DkvkdhN
hlUW871NimCYCkbF2E+0esITV/n0v7kRmOsWmhgpe6wT+al2eSR8vdtOjvEt7+aBr/yPek6R
JR5OAsJs6j08ZO4cI/ljEPTKyEKGjOI31vvTMLN6t0cRkjCOvl/3b05ureW2kDXMAV/gFTkz
I332ndbbhueX7OoUlMjGGCFUY2OXM15BtD7tJw3y8nv6O0WAQyhQgB2/LbVt4Q+Wd5ugz57P
1XQsi0oWNquvMrgbo3rQIaKHPtXq4GQQCDhd4vpsWnF+rD8JPMsJmlye+tMM7srDuPpNqKXq
oD9NUyQXKeiuZNxHLHMhDzcyNTCCBZYwggN+oAMCAQICEFbouwvJz66+9T45KqtmBgQwDQYJ
KoZIhvcNAQELBQAwRjELMAkGA1UEBhMCQ04xGjAYBgNVBAoTEVdvU2lnbiBDQSBMaW1pdGVk
MRswGQYDVQQDDBJDQSDmsoPpgJrmoLnor4HkuaYwHhcNMTQxMTA4MDA1ODU4WhcNMjkxMTA4
MDA1ODU4WjBWMQswCQYDVQQGEwJDTjEaMBgGA1UEChMRV29TaWduIENBIExpbWl0ZWQxKzAp
BgNVBAMMIkNBIOayg+mAmiBFbWFpbCDlrqLmiLfnq6/or4HkuaYgRzIwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDDFi3sZgVgARd8QuJGPZVKOv8pzhKVIaxpt2Ana5Xw+zRp
fzMRlmISRZ/1+mdCiXe+6mDn+f04pItbfHMMiNZo3LEVUXYfNbeoUO+IW2DEnQhy6bahn4W1
5XNhtOwyPOZc31AGovih5pS+0Qxwhn4lsWhGCopTYvr56rybv0XizoQRp7HdjnlNn+0u1Zwr
m+YkOi/rgBvguQ/UAA0ToXwfMEFoabwcgA0UTc6SwTGFvSu075bUVzH4cZS9T3Rc+ARlhZQI
zebUipJDyR7SPtp4IKGfTiZh60/F4fPKbqpF7zdIK5rvMPI2l1w9GVCWG630ho7qs+H77o31
YP5PBYCNAgMBAAGjggFuMIIBajAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0lBBYwFAYIKwYBBQUH
AwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwLwYDVR0fBCgwJjAkoCKgIIYeaHR0
cDovL2NybHMyLndvc2lnbi5jbi9jYTIuY3JsMGsGCCsGAQUFBwEBBF8wXTAmBggrBgEFBQcw
AYYaaHR0cDovL29jc3AyLndvc2lnbi5jbi9jYTIwMwYIKwYBBQUHMAKGJ2h0dHA6Ly9haWEy
Lndvc2lnbi5jbi9jYTJnMi1jbGllbnQxLmNlcjAdBgNVHQ4EFgQUCL22hQy9hlmNRMUKMWs7
avjXCH4wHwYDVR0jBBgwFoAU4E2/3JtBXRPoZPCn6RWk4YHBujEwRwYDVR0gBEAwPjA8Bg0r
BgEEAYKbUQYBAQECMCswKQYIKwYBBQUHAgEWHWh0dHA6Ly93d3cud29zaWduLmNvbS9wb2xp
Y3kvMA0GCSqGSIb3DQEBCwUAA4ICAQCatndVeBsS4GtFpeGQ1dt2pGiFbDXTBbon9WUYxnyY
2Yxbioj3f1VJ380Lg3iKxrzGp+VaFIK3xQa3bd3Gmgldzcvn4MfnAcsclNIU0XOZJH+8d3yd
JTvemfozxoI3Ke1oH1BR0BopGKWBtdCv3v4PwRexod0I2uYr2urAdbBICpaLa8Eb3nht3h+0
Tgpyplj3hzTwaPUC9b07y0j6MPA4qmp47Lm8/T+jdj83kz9oIQqlmNylC5L1YCuiKQ9yLmIa
jgJ9tF/S3rskbS0JJEwRcMThtWpi4DjNOyx4rbcdZ8x1s/Z5a1ZSebYpZ7nL9wgCVp0VciHK
UmFI8kgNWY0NL1HJ0OxGP0SHGA6pNm+jwVLvquIlTmT7X15y9oocflY7HiEsibjkYb+aY3Ya
hd6N/FvH9VYAnnT298iW7zWJt5psvFhruNC+YVrJJp5l6h4uTQqwkE1Q8zs2oSww7BVZJwcj
JF+OaygIhREKsJXNJZgkSliVna0qYqQVUHsbrXWrFRd+br8+IW2M1/qF9fShl8C6p/Iu1dSM
AQgVy38kpSieCqgh1cHXspI6WV1PWJy+IK5vy4hmh+Nc3m9ZxihH1B8Ut6GGNvuR9u05KYpL
q1gUbu36Z4pNQ00BtbouH2j/xPfXdr/qChyZl9nBjT+k4ClFWz/qYo12+5fMchNtBDGCA2gw
ggNkAgEBMGowVjELMAkGA1UEBhMCQ04xGjAYBgNVBAoTEVdvU2lnbiBDQSBMaW1pdGVkMSsw
KQYDVQQDDCJDQSDmsoPpgJogRW1haWwg5a6i5oi356uv6K+B5LmmIEcyAhBbLvAL7CpbaYZ7
xtCHUmdkMA0GCWCGSAFlAwQCAQUAoIIBzzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0xNjAyMDMxOTA2MTNaMC8GCSqGSIb3DQEJBDEiBCASb5kJPHqV69J9
c/70GhG12GMN/Nd86iO/VTqr2YDgJjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMHkGCSsGAQQBgjcQBDFsMGowVjELMAkGA1UEBhMC
Q04xGjAYBgNVBAoTEVdvU2lnbiBDQSBMaW1pdGVkMSswKQYDVQQDDCJDQSDmsoPpgJogRW1h
aWwg5a6i5oi356uv6K+B5LmmIEcyAhBbLvAL7CpbaYZ7xtCHUmdkMHsGCyqGSIb3DQEJEAIL
MWygajBWMQswCQYDVQQGEwJDTjEaMBgGA1UEChMRV29TaWduIENBIExpbWl0ZWQxKzApBgNV
BAMMIkNBIOayg+mAmiBFbWFpbCDlrqLmiLfnq6/or4HkuaYgRzICEFsu8AvsKltphnvG0IdS
Z2QwDQYJKoZIhvcNAQEBBQAEggEAe95x9MB0nWoHqEI+VEahbn18y+gDa9+hH9XJ3no9nSX5
A4LZX+nUdh1xH+zw7TOMeF+6gsBJMWXg8sqKO1LIOFiP5M9SQW3XWvjinACYHGfqcrGsqTf0
7wmukAvJjSMLcJYXwzBnFM4iUAD2r7kVnJ3LNofGV3APJ/LxjINe39V3QJ17uFY4IAk8SMzl
QY7iKghasBcqRStJJaF2pvuFZsm+c+ZKfTNdLkaH2HqxJoHvkixA6Bal7ezMRDCDze+ie3ZG
sEc+y9/ozuVFC+07RGFJ48AJm3fIN7Y+9Dda+uni5smD6UmdgHt/yDCuigJMtYltwl6dV2q/
s2br7PFdTQAAAAAAAA==
--------------ms000903020308000200070005--
