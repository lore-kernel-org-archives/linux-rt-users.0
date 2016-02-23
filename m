From: DIXLOR <dixlor@gmail.com>
Subject: WARNING: amd_iommu. linux-4.4.1-rt6
Date: Tue, 23 Feb 2016 03:25:46 +0300
Message-ID: <56CBA70A.8090007@gmail.com>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030802030906020303070803"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36593 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcBWAZx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2016 19:25:53 -0500
Received: by mail-lb0-f175.google.com with SMTP id x1so91844210lbj.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2016 16:25:52 -0800 (PST)
Received: from [192.168.1.2] (ppp83-237-170-190.pppoe.mtu-net.ru. [83.237.170.190])
        by smtp.googlemail.com with ESMTPSA id l129sm3624880lfl.18.2016.02.22.16.25.50
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 16:25:51 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms030802030906020303070803
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


[    1.828887] iommu: Adding device 0000:00:14.5 to group 10
[    1.831805] ------------[ cut here ]------------
[    1.831814] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd_iommu.c:1958=20
0xffffffff812d6449()
[    1.831817] Modules linked in:
[    1.831827] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G W       4.4.1-rt6=
+ #5
[    1.831831] Hardware name: empty empty/S8225, BIOS 'V3.03   ' 11/01/20=
12
[    1.831835]  ffffffff815fd5cc ffffffff81224d47 0000000000000000 ffffff=
ff81034e17
[    1.831847]  ffff8804231a5a00 ffff880422bb8420 ffff88042310e898 ffff88=
0423934000
[    1.831858]  ffff880422bb8400 ffffffff812d6449 ffff880422b5e7f8 ffff88=
0422b5e8e8
[    1.831868] Call Trace:
[    1.831873]  [<ffffffff81224d47>] ? 0xffffffff81224d47
[    1.831878]  [<ffffffff81034e17>] ? 0xffffffff81034e17
[    1.831883]  [<ffffffff812d6449>] ? 0xffffffff812d6449
[    1.831889]  [<ffffffff812d398c>] ? 0xffffffff812d398c
[    1.831894]  [<ffffffff812d40c2>] ? 0xffffffff812d40c2
[    1.831899]  [<ffffffff812d7313>] ? 0xffffffff812d7313
[    1.831904]  [<ffffffff812d3080>] ? 0xffffffff812d3080
[    1.831909]  [<ffffffff812d30a0>] ? 0xffffffff812d30a0
[    1.831913]  [<ffffffff8130fce7>] ? 0xffffffff8130fce7
[    1.831918]  [<ffffffff812d3bab>] ? 0xffffffff812d3bab
[    1.831923]  [<ffffffff8173b173>] ? 0xffffffff8173b173
[    1.831928]  [<ffffffff8171c2de>] ? 0xffffffff8171c2de
[    1.831933]  [<ffffffff8173b2be>] ? 0xffffffff8173b2be
[    1.831937]  [<ffffffff8173b339>] ? 0xffffffff8173b339
[    1.831942]  [<ffffffff8171c2ec>] ? 0xffffffff8171c2ec
[    1.831946]  [<ffffffff810003e2>] ? 0xffffffff810003e2
[    1.831952]  [<ffffffff81718e0d>] ? 0xffffffff81718e0d
[    1.831956]  [<ffffffff81504810>] ? 0xffffffff81504810
[    1.831961]  [<ffffffff81504815>] ? 0xffffffff81504815
[    1.831966]  [<ffffffff8150936f>] ? 0xffffffff8150936f
[    1.831971]  [<ffffffff81504810>] ? 0xffffffff81504810
[    1.831976] ---[ end trace 0000000000000010 ]---



--------------ms030802030906020303070803
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
2HNmXyRvQAAAAAAAAA==
--------------ms030802030906020303070803--
