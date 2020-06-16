Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E5C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 07:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BBF20734
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 07:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFPHai (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:30:38 -0400
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:42351 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgFPHai (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 03:30:38 -0400
Received: from [31.193.165.228] (port=59536 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Henri.Roosen@ginzinger.com>)
        id 1jl63F-0004LW-1a
        for linux-rt-users@vger.kernel.org; Tue, 16 Jun 2020 09:30:33 +0200
Received: from exc1.buero.ginzinger.com (10.1.1.204) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Tue, 16 Jun 2020 09:30:33 +0200
Received: from exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4]) by
 exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4%3]) with mapi id
 15.01.1466.012; Tue, 16 Jun 2020 09:30:33 +0200
X-CTCH-RefID: str=0001.0A09020F.5EE87519.007A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Roosen Henri <Henri.Roosen@ginzinger.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RT kernel v4.14 NULL pointer dereferences
Thread-Topic: RT kernel v4.14 NULL pointer dereferences
Thread-Index: AQHWQ7AEsl/YcRf3Y02gFeKb814OWw==
Date:   Tue, 16 Jun 2020 07:30:33 +0000
Message-ID: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.1.65]
x-exclaimer-md-original-subject: [NOSIG][NODISC]RT kernel v4.14 NULL pointer
 dereferences
x-exclaimer-md-config: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----36D3FC1C7459EB4DAD754369A4CD8D36"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an S/MIME signed message

------36D3FC1C7459EB4DAD754369A4CD8D36
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <131363172619054C8D533C390DA2FD65@ginzinger.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

SGkgUlQtZXhwZXJ0cywNCg0KRHVyYXRpb24gdGVzdHMgd2l0aCBSVCBlbmFibGVkIHY0LjE0IGtl
cm5lbHMgb24gb3VyIEFSTSBpTVg2USBzeXN0ZW1zDQphcmUgc2hvd2luZyAiVW5hYmxlIHRvIGhh
bmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQp2aXJ0dWFsIGFkZHJlc3Mi
IGFmdGVyIHJ1bm5pbmcgZm9yIHNvbWUgbW9udGhzLiBUaGUgc2FtZSB0ZXN0cyBvbiBOT04tDQpS
VCBrZXJuZWxzIGRvbid0IHNob3cgYW55IHByb2JsZW0gYW5kIGhhdmUgYmVlbiBydW5uaW5nIHdp
dGhvdXQgYW55DQpwcm9ibGVtcyBmb3IgbW9yZSB0aGFuIDIwIG1vbnRocyBub3cuDQoNCkkndmUg
YmVlbiB1cGRhdGluZyB0aGUgdGVzdHMgZnJvbSB0aW1lIHRvIHRpbWUgd2l0aCBtb3JlIHJlY2Vu
dA0Ka2VybmVscy4gVGVzdGluZyBpcyBiYXNpY2FsbHkgZG9uZSB3aXRoIGN5Y2xpY3Rlc3QsIGlu
IHBhcmFsbGVsIHdpdGgNCnNvbWUgbG9hZCBzY3JpcHRzL2hhY2tiZW5jaC4gUGxlYXNlIGhhdmUg
YSBsb29rIGF0IHRoZSBrZXJuZWwgdHJhY2VzOg0KNC4xNC43MS1ydDQ0ICAtPiBodHRwczovL3Bh
c3RlLmRlYmlhbi5uZXQvMTE1MjIwNi8NCjQuMTQuMTA2LXJ0NTYgLT4gaHR0cHM6Ly9wYXN0ZS5k
ZWJpYW4ubmV0LzExNTIyMDQvDQo0LjE0LjE0Ni1ydDY3IC0+IGh0dHBzOi8vcGFzdGUuZGViaWFu
Lm5ldC8xMTUyMjAyLw0KDQpJJ3ZlIHNlZW4gdGhlIHY0LjE0LXJ0IGJyYW5jaCBnb3Qgc29tZSBm
aXhlcywgc28gbXkgcXVlc3Rpb25zIGFyZToNCjEpIGlzIHByb2JsZW0gSSdtIGZhY2luZyBrbm93
biBhbmQgZml4ZWQgaW4gdjQuMTQtcnQsIG9yDQoyKSBpcyB0aGUgcHJvYmxlbSBJJ20gc2VlaW5n
IGEgbmV3IGlzc3VlIHByb2JhYmx5IHN0aWxsIHVuZml4ZWQgaW4NCjQuMTQuMTgzLXJ0ODMgKHdo
aWNoIEknbSB0ZXN0aW5nIHJpZ2h0IG5vdyk/DQoNCkFueSBoZWxwIGlzIGhpZ2hseSBhcHByZWNp
YXRlZCENCg0KVGhhbmtzLA0KSGVucmkNCg==

------36D3FC1C7459EB4DAD754369A4CD8D36
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOFAYJKoZIhvcNAQcCoIIOBTCCDgECAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggsYMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
hkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYh
UPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6
fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1
KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI
03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqc
k39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0
cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
AAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwR
GiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDc
ZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwp
WZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNm
NppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztve
BdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDA
fd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/
cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe
2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxh
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUqMIIEEqAD
AgECAhEAgK6FAFOiNDdgM5+lyjA8gTANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9E
TyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0Ew
HhcNMTgwNzE4MDAwMDAwWhcNMjEwNzE3MjM1OTU5WjArMSkwJwYJKoZIhvcNAQkB
FhpoZW5yaS5yb29zZW5AZ2luemluZ2VyLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMmwBmquEWhoUH5WNJe7bQRLBAccBq0ZBVQbLAbJQwN5bg9i
wSsPG7mveXqXYWpuHhbb7lbs3zFTS4H511nWurRqcvVceVOs5vtsbVMHjfuNmHo8
WrMCJPFBw64uBUoGdsiwuAvA0CeFpPyA/CsAuvIbmvEF+GxMjaeQhqQ9d5K4z4I6
w6R3wFtNJiSUMUSdgtnNPDYnUIKILR3mfbSCHWA7Pepe1dh+S9JFWhcoNv1h6D/R
SAKVdUtC2GS0vt3nk4cEg8Z0s4/OvVDRm2jluvPK+fEeUfGahwHFrk68nYTq3v2P
dMxHg93+Li+jYAX6R3XXGbdcjZJ3UM5MGEKq+u0CAwEAAaOCAdowggHWMB8GA1Ud
IwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBQ9s9JCcV1JOI2I
/oXSyF8VIj2VhTAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUE
FjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIB
AwUwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMw
WgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RP
UlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYI
KwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2NhLmNv
bS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0Eu
Y3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wJQYDVR0R
BB4wHIEaaGVucmkucm9vc2VuQGdpbnppbmdlci5jb20wDQYJKoZIhvcNAQELBQAD
ggEBAKdv6bSTLlu63Ckq7aibIwJCE0hhs83Z6Jr5G2wWrwVdFB9Dkb6l2NmdGRoq
qbSz3Remg5qamURXec3XdEBxO1FPMcZJrHKAZuNjYdj1tzYA/rbTdYmVbno1TG5/
O6rVb7A624UZHoucW+NpfNCrxfQY+BliMbCKJEWqQE0P6vyDenSYa76NLt1699B5
vyHbYLrJHAjFzHe7BqSkP815C47KpJFXuGYasewJDOpvyINtn6kBlrAIanoVfDFa
W9aUjUeNjqmcCEN4TpuSZCf1L8oWAjv5oH0R87orEAFZnSVWDIW8i7TMiFtCiF3D
LYmN6J96LCNCs0iQIFqcnJnkHAkxggLAMIICvAIBATCBrTCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCA
roUAU6I0N2Azn6XKMDyBMA0GCWCGSAFlAwQCAQUAoIHkMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDYxNjA3MzAzNVowLwYJKoZI
hvcNAQkEMSIEICgOCX3EvngU8LSFcuMh6Cl0qV/JDrakrwIsgLn0UMIlMHkGCSqG
SIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAJX/a1fe/AiV
CBpkrG1ayaDc7HS+m9iTxJEGxdE7n53AnyteOqsNqSvRawGs7iaU4gmXtRhbuxTX
YU2cvc0zdtKVucwl9CBrDyAiT/HmTVNOrGAgL0uikDKud8fLvAn41mm9VDsVfInl
GtRAMcLvvXrLyXDaeLHh+8zetCkdMRvQXRYuEmQoNoU79039VjIuKarK+ZM28uGg
yGlvsp0ldgAIby2qlPinxEelsgaF8rnYZawk3QDK21yYYvpzOQUw7tyV6MqBLF4r
kEVdg5N1Vk2gD/DtKNC+xhGi1sgtZcuPfykfUiGbs+u0mqm8ljAOtZnxZ3kogqsF
gwC1XCHTE2U=

------36D3FC1C7459EB4DAD754369A4CD8D36--

