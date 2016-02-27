From: DIXLOR <dixlor@gmail.com>
Subject: [PATCH] AMD IOMMU WARN NONRT
Date: Sat, 27 Feb 2016 14:39:43 +0300
Message-ID: <56D18AFF.40308@gmail.com>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020802010509080401030503"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34423 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbcB0Ljw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 06:39:52 -0500
Received: by mail-lb0-f179.google.com with SMTP id of3so58805109lbc.1
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Feb 2016 03:39:51 -0800 (PST)
Received: from [192.168.1.2] (ppp85-140-247-96.pppoe.mtu-net.ru. [85.140.247.96])
        by smtp.googlemail.com with ESMTPSA id l5sm1709946lfd.22.2016.02.27.03.39.50
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Feb 2016 03:39:50 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms020802010509080401030503
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

diff -ur a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
--- a/drivers/iommu/amd_iommu.c    2016-02-17 23:31:25.000000000 +0300
+++ b/drivers/iommu/amd_iommu.c    2016-02-27 14:36:34.928583707 +0300
@@ -1952,10 +1952,10 @@
      int ret;

      /*
-     * Must be called with IRQs disabled. Warn here to detect early
-     * when its not.
+     * Must be called with IRQs disabled on a non RT kernel. Warn here t=
o
+     * detect early when its not.
       */
-    WARN_ON(!irqs_disabled());
+    WARN_ON_NONRT(!irqs_disabled());

      /* lock domain */
      spin_lock(&domain->lock);
@@ -2118,10 +2118,10 @@
      struct protection_domain *domain;

      /*
-     * Must be called with IRQs disabled. Warn here to detect early
-     * when its not.
+     * Must be called with IRQs disabled on a non RT kernel. Warn here t=
o
+     * detect early when its not.
       */
-    WARN_ON(!irqs_disabled());
+    WARN_ON_NONRT(!irqs_disabled());

      if (WARN_ON(!dev_data->domain))
          return;




--------------ms020802010509080401030503
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
PRR7te6r6wAAAAAAAA==
--------------ms020802010509080401030503--
