From: DIXLOR <dixlor@gmail.com>
Subject: Re: Numbering system
Date: Wed, 2 Mar 2016 01:59:22 +0300
Message-ID: <56D61ECA.2010609@gmail.com>
References: <56D5C521.2050700@gmail.com>
 <alpine.DEB.2.11.1603012102150.3638@nanos>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030407010408090004080208"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33478 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcCAW7f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Mar 2016 17:59:35 -0500
Received: by mail-lb0-f175.google.com with SMTP id ed16so30202782lbb.0
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Mar 2016 14:59:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1603012102150.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms030407010408090004080208
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


>> Make numbering system with reference to the version of the kernel.
>>
>> linux-4.4.2-rt1 First -RT in 4.4.2
>> ....
>> linux-4.4.2-rt6 Last -RT in 4.4.2
>> linux-4.4.3-rt1 First -RT in 4.4.3
>> linux-4.4.3-rt2
>> ....
>> linux-4.4.4-rt1 First -RT in 4.4.4
>> ...
> We've done the consecutive numbering scheme since rt started, so why sh=
ould we
> change that?
Because the senior ranks in kernel version numbering, have a positional s=
ystem.
After version 4.4.3 can't get version 4.5.4, only 4.5.0


# cat Makefile

VERSION =3D 4
PATCHLEVEL =3D 4
SUBLEVEL =3D 3
EXTRAVERSION =3D here must be non mainline numbering: -rt1, -rt2, etc.
=2E..

If SUBLEVEL changed, then EXTRAVERSION must be set to zero or one.
Like a 8,9,10,11,... 20, 21, 22.






--------------ms030407010408090004080208
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
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
TPfOrQppFQAAAAAAAA==
--------------ms030407010408090004080208--
