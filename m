Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08467C433EA
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 11:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE32C204EA
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 11:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHQL6R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:58:17 -0400
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:36157 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728123AbgHQL6P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 07:58:15 -0400
Received: from [31.193.165.228] (port=43013 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Henri.Roosen@ginzinger.com>)
        id 1k7dmD-00008a-1a; Mon, 17 Aug 2020 13:58:09 +0200
Received: from exc1.buero.ginzinger.com (10.1.1.204) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Mon, 17 Aug 2020 13:58:09 +0200
Received: from exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4]) by
 exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4%3]) with mapi id
 15.01.1466.012; Mon, 17 Aug 2020 13:58:09 +0200
X-CTCH-RefID: str=0001.0A090206.5F3A70D1.0062,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Roosen Henri <Henri.Roosen@ginzinger.com>
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Thread-Topic: RT kernel v4.14 NULL pointer dereferences
Thread-Index: AQHWcjJMcwTnsC+ddke4u3BMdVP/nKk71mOAgAAyeoCAAAheAIAABDEA
Date:   Mon, 17 Aug 2020 11:58:09 +0000
Message-ID: <1ffc7e58e5fdc26c60f403e454d4077241605a7b.camel@ginzinger.com>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
         <20200814115848.w4m2bfqttkid6woi@linutronix.de>
         <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
         <20200817111311.zyqjznhferoqqxkh@linutronix.de>
         <05cc3d6085641c7f0425e45358451b05c5e9fc07.camel@ginzinger.com>
In-Reply-To: <05cc3d6085641c7f0425e45358451b05c5e9fc07.camel@ginzinger.com>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.1.65]
x-exclaimer-md-original-subject: [NOSIG][NODISC]Re: RT kernel v4.14 NULL
 pointer dereferences
x-exclaimer-md-config: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----B23BA2B7D63FEA63DEFDF8052C18D8AB"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an S/MIME signed message

------B23BA2B7D63FEA63DEFDF8052C18D8AB
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <43F2F0EA8030BB42934688319E8C2245@ginzinger.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

T24gTW9uLCAyMDIwLTA4LTE3IGF0IDEzOjQzICswMjAwLCBIZW5yaSBSb29zZW4gd3JvdGU6DQo+
IE9uIE1vbiwgMjAyMC0wOC0xNyBhdCAxMzoxMyArMDIwMCwgYmlnZWFzeUBsaW51dHJvbml4LmRl
IHdyb3RlOg0KPiA+IE9uIDIwMjAtMDgtMTcgMDg6MTI6MzEgWyswMDAwXSwgUm9vc2VuIEhlbnJp
IHdyb3RlOg0KPiA+ID4gPiBJcyB0aGUgNC4xNCBzZXJpZXMgdGhlIG9ubHkgb25lIHRoYXQgaXMg
YWZmZWN0ZWQ/DQo+ID4gPiANCj4gPiA+IE5vLCB1bmZvcnR1bmF0ZWx5IG5vdC4NCj4gPiA+IA0K
PiA+ID4gSSBlbmRlZCB1cCB0ZXN0aW5nIHRoZSB2NC4xNC4xODQtcnQ4NCBvbiB0d28gc3lzdGVt
cyBhbmQgdGhlDQo+ID4gPiB2NS40LjQ1LQ0KPiA+ID4gcnQyNyBvbiBhbm90aGVyIHN5c3RlbSwg
YWxsIGlNWDZRLiBPbmx5IG9uZSBvZiB0aGUgdjQuMTQgc3lzdGVtcw0KPiA+ID4gaXMNCj4gPiA+
IHN0aWxsIHJ1bm5pbmcsIHRoZSBvdGhlciB2NC4xNCBzeXN0ZW0gZHVtcGluZyBiYWNrdHJhY2Vz
IHVudGlsDQo+ID4gPiBldmVudHVhbGx5IHJlc2V0LCB0aGUgdjUuNCBzeXN0ZW0gZW5kbGVzc2x5
IGR1bXBpbmcgYmFja3RyYWNlczoNCj4gPiA+IA0KPiA+ID4gdjQuMTQ6IGh0dHBzOi8vcGFzdGUu
dWJ1bnR1LmNvbS9wL1pkRlloczRwangvDQo+ID4gPiB2NS40OiBodHRwczovL3Bhc3RlLnVidW50
dS5jb20vcC93WlBDUXY4S2pYLw0KPiA+IA0KPiA+IFNvIHRoZSA1LjQgaGFzIGFuIHVwdGltZSBv
ZiA0NSBkYXlzIHVudGlsIHRoaXMgc3RhcnQ/DQo+IA0KPiBDb3JyZWN0Lg0KPiANCj4gPiA+IElm
IHRoZSBiYWNrdHJhY2VzIGRvbid0IHBvaW50IHRvIGEgcm9vdC1jYXVzZSwgYXJlIHRoZXJlIGFu
eQ0KPiA+ID4ga2VybmVsDQo+ID4gPiBjb25maWd1cmF0aW9uIG9wdGlvbnMgd2hpY2ggYXJlIHVz
ZWZ1bGwgdG8gdHJhY2sgdGhpcyBpc3N1ZSBkb3duPw0KPiA+IA0KPiA+IFRoZSA1LjQgaXMgbm90
IGNvbXBsZXRlLCBpdCBzdGFydGVkIGVhcmxpZXIgYW5kIHRoaXMgbWlnaHQgYmUgYQ0KPiA+IGZv
bGxvdy11cCBwcm9ibGVtIChpdCBzZWVtcyB0byBvcmlnaW5hdGUgaW4gZGllKCkpLg0KPiA+IFlv
dSBjb3VsZCBzZW5kIG1lIHRoZSBjb25maWcsIEkgaGF2ZSBhbiBpbXg2cSBzb21ld2hlcmUgc28g
SSBtaWdodA0KPiA+IGJlDQo+ID4gYWJsZSB0byB0YWtlIGEgbG9vay4gSG93ZXZlciBJIHdhbnQg
c29ydCBhbm90aGVyIHBwYyBpc3N1ZSBmaXJzdC4NCj4gDQo+IFBsZWFzZSBmaW5kIHRoZSB2NS40
LjQ1LXJ0MjctY29uZmlnIGZpbGUgYXR0YWNoZWQgdG8gdGhpcyBlbWFpbC4gTGV0IA0KDQpUbyBj
bGFyaWZ5IHRoZSB2NS40LjQ1LXJ0MjcgYmVmb3JlIGFueSBjb25mdXNpb246IEkgdXNlZCB0aGUg
djUuNC40NC0NCnJ0MjcgbWVyZ2VkIGludG8gb3VyIHY1LjQuNDUgYnJhbmNoLg0KDQo+IG1lDQo+
IGtub3cgaWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGFib3V0IHRoZSBjb25maWcgZmlsZSBv
ciB1c2VmdWwNCj4gZGVidWdnaW5nIEkgY2FuIHN3aXRjaCBvbjsgSSdsbCBiZSByZXN0YXJ0aW5n
IGEgY291cGxlIG9mIHN5c3RlbXMgZm9yDQo+IG5ldyBkdXJhdGlvbiB0ZXN0cy4NCj4gDQo+IFRo
YW5rcyBmb3IgeW91ciBoZWxwIQ0KPiBIZW5yaQ0KPiANCg==

------B23BA2B7D63FEA63DEFDF8052C18D8AB
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDgxNzExNTgxMlowLwYJKoZI
hvcNAQkEMSIEIG6EaOXWJFqBDpGLGbIFKHCuUZBZFp+aYcMDwp9BuKoCMHkGCSqG
SIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAJe/M8qUG6CQ
cqs2kW2KpKnx5rbAS6DtCSeVCHfs1wNNimpvkMGOwhL/BtAzlXJJgUKCMTd5NJwq
U5aciRqO5Tg3w9nGfh0mw5EeeFHkuY1dw6nmByT4kB+IPCBKBxU+geSh3Aiu7ItX
vd2cBsOTmdEj0j8ybJvdIVHabp8oakbGG8lNRpTcBxNMOIUwBOxqybUw4tMoU/Zk
POSdN4+T9bL9TpPUOYHV2TVP2IuuAgcPh4zv2XIhXADdleUxgQ/F/DOSyQ5n0y/w
5mLR5z0F+oVUaoqGOYS9xV+XtuDlhozNCtHoh3Po58UskgEyAMYnzk0jqOHFLBXG
LZxik7qzrl4=

------B23BA2B7D63FEA63DEFDF8052C18D8AB--

