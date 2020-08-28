Return-Path: <SRS0=BfXC=CG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B8BC433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Aug 2020 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2F62071B
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Aug 2020 08:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1Ir7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:47:59 -0400
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:60996 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgH1Irx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Aug 2020 04:47:53 -0400
Received: from [31.193.165.228] (port=22397 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Henri.Roosen@ginzinger.com>)
        id 1kBa31-0000Va-0V; Fri, 28 Aug 2020 10:47:47 +0200
Received: from exc1.buero.ginzinger.com (10.1.1.204) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Fri, 28 Aug 2020 10:47:46 +0200
Received: from exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4]) by
 exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4%3]) with mapi id
 15.01.1466.012; Fri, 28 Aug 2020 10:47:46 +0200
X-CTCH-RefID: str=0001.0A090213.5F48C4B3.0060,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Roosen Henri <Henri.Roosen@ginzinger.com>
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Thread-Topic: RT kernel v4.14 NULL pointer dereferences
Thread-Index: AQHWfHD/vw22G4yAUUaodEFUYa16lqlLzMYAgAFIngA=
Date:   Fri, 28 Aug 2020 08:47:46 +0000
Message-ID: <1394d73cab1d99f9276e9799923d15f5a1d4bc91.camel@ginzinger.com>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
         <20200814115848.w4m2bfqttkid6woi@linutronix.de>
         <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
         <20200817111311.zyqjznhferoqqxkh@linutronix.de>
         <05cc3d6085641c7f0425e45358451b05c5e9fc07.camel@ginzinger.com>
         <1ffc7e58e5fdc26c60f403e454d4077241605a7b.camel@ginzinger.com>
         <be2424198cd899ca182b38c51f97f5b9acc16131.camel@ginzinger.com>
         <20200827125256.etg57uakct2gobl3@linutronix.de>
         <20200827131136.aepfkssev6psio3c@linutronix.de>
In-Reply-To: <20200827131136.aepfkssev6psio3c@linutronix.de>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.1.65]
x-exclaimer-md-original-subject: [NOSIG][NODISC]Re: RT kernel v4.14 NULL
 pointer dereferences
x-exclaimer-md-config: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----C4317505A665A6DDF16433194C5F7271"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an S/MIME signed message

------C4317505A665A6DDF16433194C5F7271
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <08EB3103D8492E45A65B5F5AC15C200C@ginzinger.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

T24gVGh1LCAyMDIwLTA4LTI3IGF0IDE1OjExICswMjAwLCBiaWdlYXN5QGxpbnV0cm9uaXguZGUg
d3JvdGU6DQo+IE9uIDIwMjAtMDgtMjcgMTQ6NTI6NTggWyswMjAwXSwgVG8gUm9vc2VuIEhlbnJp
IHdyb3RlOg0KPiA+IE9uIDIwMjAtMDgtMjYgMDk6NTY6MTYgWyswMDAwXSwgUm9vc2VuIEhlbnJp
IHdyb3RlOg0KPiA+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIHlvdSBmaW5kIGFueSB1
bnJlZ3VsYXJpdGllcyBpbiBteQ0KPiA+ID4gY29uZmlnIG9yDQo+ID4gPiBzdWdnZXN0aW9ucyBv
biBhbnkgdXNlZnVsbCBkZWJ1Z2dpbmctL2ZvcmVuc2ljLWNvbmZpZy1vcHRpb25zLg0KPiA+IA0K
PiA+IEkgaGF2ZSBubyBzdWdnZXN0aW9ucy4gV2VsbCBiZXNpZGVzIG1lbW9yeSBkZWJ1Z2dpbmcs
IGxvY2tkZXAgYW5kDQo+ID4gdGhlc2UNCj4gPiBraW5kIG9mIHRoaW5ncy4NCj4gDQo+IFlvdSBu
ZXZlciBzZW50IGEgYmFja3RyYWNlLCBkaWQgeW91PyBJIHJlbWVtYmVyIHlvdSBwb3N0ZWQgYSBs
aW5rIGENCj4gcGFzdGViaW4gd2hpY2ggY29udGFpbiBvbmx5IHRoZSAibWlkZGxlIiBvZiB0aGUg
dHJhY2UsIG5vdCB3aGVyZSBpdA0KPiBzdGFydGVkLg0KDQpDb3JyZWN0LCBwbGVhc2Ugc2VlIA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcnQtdXNlcnMvMjU0MTJiZWZmYjk2YWI4YzJi
OGY4NjliZGFjNWE2NmM0OWZhYTVjYS5jYW1lbEBnaW56aW5nZXIuY29tLw0KDQpVbmZvcnR1bmF0
ZWx5IHRoZSBvbmx5IHY1LjQgYmFja3RyYWNlIEkgY3VycmVudGx5IGhhdmUsIHRoZSBrZXJuZWwg
d2FzDQpjb250aW51b3VzbHkgZHVtcGluZyBiYWNrdHJhY2VzLCB0aGVyZWZvcmUgb25seSB0aGUg
Im1pZGRsZSIgb2YgdGhlDQp0cmFjZSBpcyBhdmFpbGFibGUgKGh0dHBzOi8vcGFzdGUudWJ1bnR1
LmNvbS9wL3daUENRdjhLalgvKS4NCg0KQ3VycmVudGx5IHRlc3RpbmcgMiBzeXN0ZW1zIHdpdGgg
djUuNC41OC1ydDM1IGZvciAyIHdlZWtzIG5vdy4gTWlnaHQNCnRha2UgYW5vdGhlciA2IHdlZWtz
IG9yIG1vcmUgYmVmb3JlIGJhY2t0cmFjZXMgYmVjb21lIGF2YWlsYWJsZS4NCg0KVGhlIHBhc3Rl
YmlucyBvZiB0aGUgdjQuMTQga2VybmVscyBmcm9tIHRoZSBmaXJzdCBwb3N0IGluIHRoaXMgdGhy
ZWFkDQpkb24ndCB3b3JrIGFueW1vcmUsIEkgcmUtcG9zdGVkIHRoZW0gaGVyZToNCg0KNC4xNC43
MS1ydDQ0ICAtPiBodHRwczovL3Bhc3RlLnVidW50dS5jb20vcC9yZ1NOcjk3dzZrLw0KNC4xNC4x
MDYtcnQ1NiAtPiBodHRwczovL3Bhc3RlLnVidW50dS5jb20vcC9jc1Z2SmNZR3J0Lw0KNC4xNC4x
NDYtcnQ2NyAtPiBodHRwczovL3Bhc3RlLnVidW50dS5jb20vcC9jcnlicDZGNkhiLw0KDQpUaGUg
djQuMTQgbG9ncyBoYXZlIGEgbW9yZSBjb21wbGV0ZSBiYWNrdHJhY2UuIFNlZW1zIHRoZSB2NC4x
NCBsb2cgYXJlDQphbGwgc2hvd2luZyBiYWNrdHJhY2VzIG9mIFN5U19yZWFkL1N5U193cml0ZSBz
eXNjYWxscyBvbiB1bml4LXN0cmVhbS0NCnNvY2tldHMsIGJ1dCB0aGF0IG1pZ2h0IGJlIGp1c3Qg
YSByZWQtaGVycmluZy4NCg0KVGhhbmtzIQ0KSGVucmkNCg==

------C4317505A665A6DDF16433194C5F7271
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDgyODA4NDc1MVowLwYJKoZI
hvcNAQkEMSIEIGG+hb8hr17UzfYn1xp38a0ncNl5Qbz0+LRaW1rpKofiMHkGCSqG
SIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAGwoe66cWoLN
8XvG0uiYTevQz/FFMFXIZ1cwjHDZcNh2i7wnh3ZzRFVgHzrfkCsklYx/lwQstKM0
GK6a/tFqOW1qqehJgEFps+Qz49WU3rwftj0cDflB6ckv8/wT63/c09Cz+aeZYASU
IZQu0QFUiiJzAD4nfxDNoc2bGonp5YsQ8siN2PSnH/1ASqDLFYS+gAuqdv6pW/uT
oLSM3zNhR4JpVwI8pNlJfkP3DNayZkfPAQ7V7pMbzLJwyIBRu/Mk7hSyxI1FFdFA
S8EgNlZnikMz/6GY3pGO2f2IxsjtYJ0KmgW2ZuADIlWNeumYtQSLLqL19re8pVsJ
UlPxqOkOeeo=

------C4317505A665A6DDF16433194C5F7271--

