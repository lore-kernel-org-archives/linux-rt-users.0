Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEF5C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Jan 2021 14:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F09023135
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Jan 2021 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbhASOxK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:53:10 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:41186 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405160AbhASLEr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Jan 2021 06:04:47 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 06:04:45 EST
Received: from [31.193.165.228] (port=65101 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Henri.Roosen@ginzinger.com>)
        id 1l1ohc-0001CG-3C; Tue, 19 Jan 2021 11:57:37 +0100
Received: from exc1.buero.ginzinger.com (10.1.1.204) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 11:57:36 +0100
Received: from exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4]) by
 exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4%2]) with mapi id
 15.01.2106.002; Tue, 19 Jan 2021 11:57:36 +0100
X-CTCH-RefID: str=0001.0A782F1A.6006BB21.001A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Roosen Henri <Henri.Roosen@ginzinger.com>
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Thread-Topic: RT kernel v4.14 NULL pointer dereferences
Thread-Index: AQHWcjJMcwTnsC+ddke4u3BMdVP/nKk71mOAgAAyeoCA86XFAA==
Date:   Tue, 19 Jan 2021 10:57:36 +0000
Message-ID: <4265e04810b55bea4f52f3c0c5057b808dcac814.camel@ginzinger.com>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
         <20200814115848.w4m2bfqttkid6woi@linutronix.de>
         <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
         <20200817111311.zyqjznhferoqqxkh@linutronix.de>
In-Reply-To: <20200817111311.zyqjznhferoqqxkh@linutronix.de>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.1.65]
x-exclaimer-md-original-subject: [NOSIG][NODISC]Re: RT kernel v4.14 NULL
 pointer dereferences
x-exclaimer-md-config: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----A09935177EFAAAC0D01E1BC99ADD3E8E"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an S/MIME signed message

------A09935177EFAAAC0D01E1BC99ADD3E8E
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <35C8265031203749B7609D4DA9C63A54@ginzinger.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

T24gTW9uLCAyMDIwLTA4LTE3IGF0IDEzOjEzICswMjAwLCBiaWdlYXN5QGxpbnV0cm9uaXguZGUg
d3JvdGU6DQo+IE9uIDIwMjAtMDgtMTcgMDg6MTI6MzEgWyswMDAwXSwgUm9vc2VuIEhlbnJpIHdy
b3RlOg0KPiA+ID4gSXMgdGhlIDQuMTQgc2VyaWVzIHRoZSBvbmx5IG9uZSB0aGF0IGlzIGFmZmVj
dGVkPw0KPiA+IA0KPiA+IE5vLCB1bmZvcnR1bmF0ZWx5IG5vdC4NCj4gPiANCj4gPiBJIGVuZGVk
IHVwIHRlc3RpbmcgdGhlIHY0LjE0LjE4NC1ydDg0IG9uIHR3byBzeXN0ZW1zIGFuZCB0aGUNCj4g
PiB2NS40LjQ1LQ0KPiA+IHJ0Mjcgb24gYW5vdGhlciBzeXN0ZW0sIGFsbCBpTVg2US4gT25seSBv
bmUgb2YgdGhlIHY0LjE0IHN5c3RlbXMgaXMNCj4gPiBzdGlsbCBydW5uaW5nLCB0aGUgb3RoZXIg
djQuMTQgc3lzdGVtIGR1bXBpbmcgYmFja3RyYWNlcyB1bnRpbA0KPiA+IGV2ZW50dWFsbHkgcmVz
ZXQsIHRoZSB2NS40IHN5c3RlbSBlbmRsZXNzbHkgZHVtcGluZyBiYWNrdHJhY2VzOg0KPiA+IA0K
PiA+IHY0LjE0OiBodHRwczovL3Bhc3RlLnVidW50dS5jb20vcC9aZEZZaHM0cGp4Lw0KPiA+IHY1
LjQ6IGh0dHBzOi8vcGFzdGUudWJ1bnR1LmNvbS9wL3daUENRdjhLalgvDQo+IA0KPiBTbyB0aGUg
NS40IGhhcyBhbiB1cHRpbWUgb2YgNDUgZGF5cyB1bnRpbCB0aGlzIHN0YXJ0Pw0KPiANCj4gPiBJ
ZiB0aGUgYmFja3RyYWNlcyBkb24ndCBwb2ludCB0byBhIHJvb3QtY2F1c2UsIGFyZSB0aGVyZSBh
bnkga2VybmVsDQo+ID4gY29uZmlndXJhdGlvbiBvcHRpb25zIHdoaWNoIGFyZSB1c2VmdWxsIHRv
IHRyYWNrIHRoaXMgaXNzdWUgZG93bj8NCj4gDQo+IFRoZSA1LjQgaXMgbm90IGNvbXBsZXRlLCBp
dCBzdGFydGVkIGVhcmxpZXIgYW5kIHRoaXMgbWlnaHQgYmUgYQ0KPiBmb2xsb3ctdXAgcHJvYmxl
bSAoaXQgc2VlbXMgdG8gb3JpZ2luYXRlIGluIGRpZSgpKS4NCj4gWW91IGNvdWxkIHNlbmQgbWUg
dGhlIGNvbmZpZywgSSBoYXZlIGFuIGlteDZxIHNvbWV3aGVyZSBzbyBJIG1pZ2h0IGJlDQo+IGFi
bGUgdG8gdGFrZSBhIGxvb2suIEhvd2V2ZXIgSSB3YW50IHNvcnQgYW5vdGhlciBwcGMgaXNzdWUg
Zmlyc3QuDQoNClNlYmFzdGlhbiwgZGlkIHlvdSBoYXZlIGEgY2hhbmNlIHRvIGJyaW5nIHVwIGEg
ZHVyYXRpb24gdGVzdCBvbiB5b3VyDQppbXg2cSBib2FyZD8gQXJlIHRoZXJlIGFueSByZXN1bHRz
IGZyb20gdGVzdGluZz8NCg0KVGhhbmtzLA0KSGVucmkNCg==

------A09935177EFAAAC0D01E1BC99ADD3E8E
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDExOTEwNTczOFowLwYJKoZI
hvcNAQkEMSIEIIsKlpcNbuiOnpWHj2IjzJ1q9Nb3bRYRnwyVFgFquPSQMHkGCSqG
SIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBADw/2FdXmY4n
v3AT/gyBbsY649evc8HD1vVmGONJg6QU0vuOMuC50OELnPuITlK6WPGEqTls6xnh
6AQostagaVzjkoXtwPkocDp6vJuga5CZX/yanuBBvVNHzcN9bPDeRDkdnOKqOrMW
TjqCX28ECO6EvLAjEMxj0O5TQ5CwWG9JyVEXAb3NzpKQQhrg12e7yKGmqpEQnwsC
nSV1xDAEmat7he7eXtO2mvAi2qx/mGkO0Mjjpgyt61km4R6yA+sm1AYF08lhK1ah
cOMy9erBGK7BbJFukQmZS43eA5+R+elPaW5rOqhrhOazUq/q9/6AxyIaxHcJ1kCC
gy30ntIF1PA=

------A09935177EFAAAC0D01E1BC99ADD3E8E--

