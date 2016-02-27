From: DIXLOR <dixlor@gmail.com>
Subject: Re: WARNING: amd_iommu. linux-4.4.1-rt6
Date: Sat, 27 Feb 2016 14:38:47 +0300
Message-ID: <56D18AC7.4090409@gmail.com>
References: <56CBA91D.6080909@gmail.com>
 <alpine.DEB.2.11.1602271024130.3638@nanos>
 <alpine.DEB.2.11.1602271057270.3638@nanos>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090005040601090701030501"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34243 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbcB0Li5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 06:38:57 -0500
Received: by mail-lb0-f172.google.com with SMTP id of3so58799748lbc.1
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Feb 2016 03:38:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602271057270.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090005040601090701030501
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Yet another WARN

[    2.667483] WARNING: CPU: 6 PID: 1 at drivers/iommu/amd_iommu.c:2124=20
0xffffffff812cd85a()
[    2.667484] Modules linked in:
[    2.667488] CPU: 6 PID: 1 Comm: swapper/0 Tainted: G U          4.4.2-=
plx+ #6
[    2.667489] Hardware name: empty empty/S8225, BIOS 'V3.03   ' 11/01/20=
12
[    2.667490]  ffffffff815efa4c ffffffff8121e0d6 0000000000000000 ffffff=
ff81033fef
[    2.667492]  ffff880422992180 ffff8804230e0098 ffff8804229c0800 ffff88=
0423934000
[    2.667493]  ffff880422a0c000 ffffffff812cd85a ffff880422992180 ffff88=
04230e0098
[    2.667495] Call Trace:
[    2.667497]  [<ffffffff8121e0d6>] ? 0xffffffff8121e0d6
[    2.667498]  [<ffffffff81033fef>] ? 0xffffffff81033fef
[    2.667499]  [<ffffffff812cd85a>] ? 0xffffffff812cd85a
[    2.667500]  [<ffffffff812cd886>] ? 0xffffffff812cd886
[    2.667500]  [<ffffffff812cd9a7>] ? 0xffffffff812cd9a7
[    2.667501]  [<ffffffff814fa559>] ? 0xffffffff814fa559
[    2.667502]  [<ffffffff812cb3aa>] ? 0xffffffff812cb3aa
[    2.667502]  [<ffffffff812cb9da>] ? 0xffffffff812cb9da
[    2.667503]  [<ffffffff812ceaa3>] ? 0xffffffff812ceaa3
[    2.667504]  [<ffffffff812ca7e8>] ? 0xffffffff812ca7e8
[    2.667504]  [<ffffffff812ca808>] ? 0xffffffff812ca808
[    2.667505]  [<ffffffff81306adf>] ? 0xffffffff81306adf
[    2.667506]  [<ffffffff812cb33a>] ? 0xffffffff812cb33a
[    2.667507]  [<ffffffff8172b08a>] ? 0xffffffff8172b08a
[    2.667507]  [<ffffffff8170c281>] ? 0xffffffff8170c281
[    2.667508]  [<ffffffff8172b1d5>] ? 0xffffffff8172b1d5
[    2.667509]  [<ffffffff8172b250>] ? 0xffffffff8172b250
[    2.667509]  [<ffffffff8170c28f>] ? 0xffffffff8170c28f
[    2.667510]  [<ffffffff810003df>] ? 0xffffffff810003df
[    2.667511]  [<ffffffff81708e04>] ? 0xffffffff81708e04
[    2.667511]  [<ffffffff814f62c8>] ? 0xffffffff814f62c8
[    2.667512]  [<ffffffff814f62cd>] ? 0xffffffff814f62cd
[    2.667513]  [<ffffffff814facef>] ? 0xffffffff814facef
[    2.667513]  [<ffffffff814f62c8>] ? 0xffffffff814f62c8
[    2.667514] ---[ end trace 0000000000000001 ]---




27.02.2016 12:58, Thomas Gleixner =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sat, 27 Feb 2016, Thomas Gleixner wrote:
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -1952,10 +1952,10 @@ static int __attach_device(struct iommu_
>>   	int ret;
>>  =20
>>   	/*
>> -	 * Must be called with IRQs disabled. Warn here to detect early
>> -	 * when its not.
>> +	 * Must be called with IRQs disabled on a non RT kernel. Warn here t=
o
>> +	 * detect early when its not.
>>   	 */
>> -	WARN_ON(!irqs_disabled());
>> +	WARN_ON_NORT(!irqs_disabled());
> That wants to be
>
> +	WARN_ON_NONRT(!irqs_disabled());
>
> of course.
>
> -ENOTAWAKEYET
>



--------------ms090005040601090701030501
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
+NTNvsiOFQAAAAAAAA==
--------------ms090005040601090701030501--
