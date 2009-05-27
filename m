From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] cyclictest: calcdiff calculated wrong seconds if the difference
 was bigger than 2147s
Date: Wed, 27 May 2009 23:22:15 +0200
Message-ID: <4A1DAF07.6020704@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070506010300000206090402"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.deheime.ch ([62.12.167.34]:59860 "EHLO limpopo.deheime.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbZE0V37 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2009 17:29:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id 0BF90C
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 23:24:56 +0200 (CEST)
Received: from limpopo.deheime.ch ([127.0.0.1])
	by localhost (limpopo.deheime.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coPeuwCW9mGe for <linux-rt-users@vger.kernel.org>;
	Wed, 27 May 2009 23:24:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id A22B5F
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 23:24:55 +0200 (CEST)
Received: from [192.168.0.20] (250-251.0-85.cust.bluewin.ch [85.0.251.250])
	(Authenticated sender: falstaff@deheime.ch)
	by limpopo.deheime.ch (Postfix) with ESMTP id 2B907C
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 23:24:55 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms070506010300000206090402
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 src/cyclictest/cyclictest.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be9a3f9..6d695cb 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -290,7 +290,7 @@ static inline void tsnorm(struct timespec *ts)
 static inline long calcdiff(struct timespec t1, struct timespec t2)
 {
 	long diff;
-	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
+	diff = USEC_PER_SEC * (long)((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
 	return diff;
 }
@@ -298,7 +298,7 @@ static inline long calcdiff(struct timespec t1, struct timespec t2)
 static inline long calcdiff_ns(struct timespec t1, struct timespec t2)
 {
 	long diff;
-	diff = NSEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
+	diff = NSEC_PER_SEC * (long)((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
 	return diff;
 }
-- 


--------------ms070506010300000206090402
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILqTCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggQvMIIDmKADAgECAhB1oZd0ulUyzGAiSf6CeJYS
MA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQTAeFw0wOTA1MjMwNzUyNTJaFw0xMDA1MjMwNzUyNTJaMIIBGjEOMAwGA1UEBBMF
QWduZXIxDzANBgNVBCoTBlN0ZWZhbjEVMBMGA1UEAxMMU3RlZmFuIEFnbmVyMR4wHAYJKoZI
hvcNAQkBFg9zdGVmYW5AYWduZXIuY2gxHzAdBgkqhkiG9w0BCQEWEGluZm9AZmFsc3RhZmYu
Y2gxJjAkBgkqhkiG9w0BCQEWF2ZhbHN0YWZmQHBpbGF0dXNjaGF0LmNoMSkwJwYJKoZIhvcN
AQkBFhpzdGVmYW4uYWduZXJAa211LW9mZmljZS5jaDEiMCAGCSqGSIb3DQEJARYTZmFsc3Rh
ZmZAZGVoZWltZS5jaDEoMCYGCSqGSIb3DQEJARYZc3RlZmFuLmFnbmVyQHN0dWQuaHNsdS5j
aDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKO0oa9Q0urbCn+PB8JWoqMACX+w
ssnrSfSTmVRgzQuu2m/if16/tPahCgKwYnlSVUTtsS8fyRPm0Ogs1jBFV3vtqDp2E1LWPmL5
PtmOBNvBNxQYpVlsew5oomlp+szJ7jy1uely4E6GCnyRtcExVczHv7eaVrld4zEoZG6jGbdw
fxXR1uF917dYDyzlH61TFz1KBO2SMEGBO+ItEaGsthKrlmrnaqrif4rQnIWATB7eQGI1aIXF
OAQFq7vtlHrHAFlGKjjgL2O5BwhD/pQbzcvU2P1IMHwUkUo8Tm0Ol9CqkdK20dsBKCsOMVeH
q6aXeLdHxugOfB0j/vyzMvCKBZ8CAwEAAaOBpzCBpDCBkwYDVR0RBIGLMIGIgQ9zdGVmYW5A
YWduZXIuY2iBEGluZm9AZmFsc3RhZmYuY2iBF2ZhbHN0YWZmQHBpbGF0dXNjaGF0LmNogRpz
dGVmYW4uYWduZXJAa211LW9mZmljZS5jaIETZmFsc3RhZmZAZGVoZWltZS5jaIEZc3RlZmFu
LmFnbmVyQHN0dWQuaHNsdS5jaDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAAPk
az+hdUmmCbkDlGmMtUq1i5ZgGizIxPP9hHFrhKqvrHfp8vxZhWVsZl/+/B7ExvHyx/0xpAFb
E8RpMfXfsiWlZD+iYqgPgRdKw6MiCIB21+RPkgmFIptgvzH4yus3WRrKNOyNUf27VkudCLbR
utiCQdmLrDCPmehaaZLhE57iMIIELzCCA5igAwIBAgIQdaGXdLpVMsxgIkn+gniWEjANBgkq
hkiG9w0BAQUFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0EwHhcNMDkwNTIzMDc1MjUyWhcNMTAwNTIzMDc1MjUyWjCCARoxDjAMBgNVBAQTBUFnbmVy
MQ8wDQYDVQQqEwZTdGVmYW4xFTATBgNVBAMTDFN0ZWZhbiBBZ25lcjEeMBwGCSqGSIb3DQEJ
ARYPc3RlZmFuQGFnbmVyLmNoMR8wHQYJKoZIhvcNAQkBFhBpbmZvQGZhbHN0YWZmLmNoMSYw
JAYJKoZIhvcNAQkBFhdmYWxzdGFmZkBwaWxhdHVzY2hhdC5jaDEpMCcGCSqGSIb3DQEJARYa
c3RlZmFuLmFnbmVyQGttdS1vZmZpY2UuY2gxIjAgBgkqhkiG9w0BCQEWE2ZhbHN0YWZmQGRl
aGVpbWUuY2gxKDAmBgkqhkiG9w0BCQEWGXN0ZWZhbi5hZ25lckBzdHVkLmhzbHUuY2gwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCjtKGvUNLq2wp/jwfCVqKjAAl/sLLJ60n0
k5lUYM0Lrtpv4n9ev7T2oQoCsGJ5UlVE7bEvH8kT5tDoLNYwRVd77ag6dhNS1j5i+T7ZjgTb
wTcUGKVZbHsOaKJpafrMye48tbnpcuBOhgp8kbXBMVXMx7+3mla5XeMxKGRuoxm3cH8V0dbh
fde3WA8s5R+tUxc9SgTtkjBBgTviLRGhrLYSq5Zq52qq4n+K0JyFgEwe3kBiNWiFxTgEBau7
7ZR6xwBZRio44C9juQcIQ/6UG83L1Nj9SDB8FJFKPE5tDpfQqpHSttHbASgrDjFXh6uml3i3
R8boDnwdI/78szLwigWfAgMBAAGjgacwgaQwgZMGA1UdEQSBizCBiIEPc3RlZmFuQGFnbmVy
LmNogRBpbmZvQGZhbHN0YWZmLmNogRdmYWxzdGFmZkBwaWxhdHVzY2hhdC5jaIEac3RlZmFu
LmFnbmVyQGttdS1vZmZpY2UuY2iBE2ZhbHN0YWZmQGRlaGVpbWUuY2iBGXN0ZWZhbi5hZ25l
ckBzdHVkLmhzbHUuY2gwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQAD5Gs/oXVJ
pgm5A5RpjLVKtYuWYBosyMTz/YRxa4Sqr6x36fL8WYVlbGZf/vwexMbx8sf9MaQBWxPEaTH1
37IlpWQ/omKoD4EXSsOjIgiAdtfkT5IJhSKbYL8x+MrrN1kayjTsjVH9u1ZLnQi20brYgkHZ
i6wwj5noWmmS4ROe4jGCA3EwggNtAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAhB1oZd0ulUyzGAiSf6CeJYSMAkGBSsOAwIaBQCgggHQMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDUyNzIxMjIxNVow
IwYJKoZIhvcNAQkEMRYEFNORw09X8itng3leNj6SKh1M9AWIMF8GCSqGSIb3DQEJDzFSMFAw
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQG
EwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMj
VGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHWhl3S6VTLMYCJJ/oJ4lhIw
gYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENv
bnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECEHWhl3S6VTLMYCJJ/oJ4lhIwDQYJKoZIhvcNAQEBBQAEggEAS7w2ik4p
Mdzb4Q/2LmrDtwB4scBE1xEE0UpiNDIafPA3GRgPIcn8Jit7AiGSaEzcv4x2/mfp5akdwkSQ
pLB2w75i39mv93bbehxLzmTusRSSA2BY3xXNQJIzHdFxujnEQl9egJA+TvlZuiVWMTqFECsd
COnmcFjdf0m4yT+5FjcoMCU/rTxR7QeCuNZHliFVQ3a4K2L8LkMID891ceE54W+/omZGAKIE
Z4MfO5WIz4Jl7eQjfBrAO+Lx95NFd8/sXcjcrJQNhFhHOp00rvT+YU3Dzw2QmQVk2QhIqlEi
VVarZzap7Os3NInlSZ0gskgutaSULFf3z9mSDFM8vUqRwwAAAAAAAA==
--------------ms070506010300000206090402--
