From: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Subject: Re: [PATCH] cyclictest: remove compatibilty hack for old libnuma,
 repairs "-a" for isolcpus
Date: Thu, 21 May 2015 12:23:25 +0000
Message-ID: <1432211005.5810.29.camel@eagleseven.com>
References: <20150427125846.1de46037@sluggy>
	 <1432126711-18618-1-git-send-email-henning.schild@siemens.com>
	 <alpine.LFD.2.10.1505201629400.7867@riemann>
	 <20150521131119.4909a2dd@md1em3qc>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"gary.robertson@linaro.org" <gary.robertson@linaro.org>,
	"williams@redhat.com" <williams@redhat.com>
To: "henning.schild@siemens.com" <henning.schild@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eagleseven.com ([76.74.2.20]:14059 "EHLO
	mail.eagleseven.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbEUM2v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 08:28:51 -0400
In-Reply-To: <20150521131119.4909a2dd@md1em3qc>
Content-Language: en-US
Content-ID: <53C8051D1E1FE74392C9E7742BE19ACE@eagleseven.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

T24gVGh1LCAyMDE1LTA1LTIxIGF0IDEzOjExICswMjAwLCBIZW5uaW5nIFNjaGlsZCB3cm90ZToN
Cj4gT24gV2VkLCAyMCBNYXkgMjAxNSAxNjozODoyNSArMDIwMA0KPiBKb2huIEthY3VyIDxqa2Fj
dXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgaXMgYSB0ZXJyaWJsZSBoYWNrLCBi
dXQgSSdtIGFmcmFpZCB0byByZW1vdmUgaXQgeWV0Lg0KPiA+IEV2ZW4gc3lzdGVtcyBhcyByZWNl
bnQgYXMgRmVkb3JhIDE5IGhhdmUgYSBsaWJudW1hIGxlc3MgdGhhbiB0aGF0Lg0KPiA+IHBtIC1x
ZiAvdXNyL2xpYjY0L2xpYm51bWEuc28NCj4gPiBudW1hY3RsLWRldmVsLTIuMC44LTQuZmMxOS54
ODZfNjQNCj4gPiBbamthY3VyQHJpZW1hbm4gcnQtdGVzdHNdJCBjYXQgL2V0Yy9mZWRvcmEtcmVs
ZWFzZSANCj4gPiBGZWRvcmEgcmVsZWFzZSAxOSAoU2NocsO2ZGluZ2Vy4oCZcyBDYXQpDQo+IA0K
PiBBY2NvcmRpbmcgdG8gaHR0cHM6Ly9mZWRvcmFwcm9qZWN0Lm9yZy93aWtpL1JlbGVhc2VzIHRo
YXQgaXMgYW4gb2xkDQo+IHVuc3VwcG9ydGVkIHJlbGVhc2UsIHNvIGkgd291bGQgbm90IGNhbGwg
aXQgcmVjZW50LiBObyBmdW5ueSBzdGF0ZQ0KPiBpbmJldHdlZW4sIHRoYXQgY2F0IGlzIGRlYWQu
IEFzIGZhciBhcyBpIGNhbiBzZWUgRmVkb3JhIDIwKyBzaG91bGQgaGF2ZQ0KPiAyLjAuOSssIHdo
aWNoIGlzIGZpbmUuDQo+IElmIHlvdSBhc2sgbWUsIGEgY29tcGF0aWJpbHR5IGhhY2sgdGhhdCBi
cmFrZXMgYWxsIG1vZGVybiBzeXN0ZW1zIGlzIG5vdA0KPiBhY2NlcHRhYmxlLg0KPiANCj4gSSBk
byBub3Qga25vdyBob3cgbWFueSBiaXRzIGFuZCBwaWVjZXMgY291bGQgYmUgdHVuZWQsIGJ1dCBh
dXRvbWFrZSBmb3INCj4gdGhhdCBvbmUgaXNzdWUgc2VlbXMgb3ZlcmtpbGwuDQo+IA0KPiBIZW5u
aW5nDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5l
ICJ1bnN1YnNjcmliZSBsaW51eC1ydC11c2VycyIgaW4NCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdl
IHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcNCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAg
aHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQoNClRoZW4gYWdhaW4s
IENlbnRPUyA1IChhbmQgb3RoZXIgdmFyaWFudHMgb2YgdGhhdCBpbGspIGlzIHVuZGVyIG9mZmlj
aWFsDQpzdXBwb3J0IHVudGlsIGVhcmx5IDIwMTdbMV0sIGFuZCBpdCB1c2VzIDAuOS44WzJdDQot
LSANCktpbmQgUmVnYXJkcyAvIG1lZCB2w6RubGlnIGjDpGxzbmluZywNCg0KU3RhZmZhbiBUamVy
bnN0csO2bQ0KDQpbMV1odHRwOi8vd2lraS5jZW50b3Mub3JnL0ZBUS9HZW5lcmFsI2hlYWQtZmU4
YTBiZTkxZWUzZTdkZWE4MTJlODY5NDQ5MWUxZGRlNWI3NWU2ZCANClsyXWh0dHA6Ly92YXVsdC5j
ZW50b3Mub3JnL2NlbnRvcy81L29zL1NSUE1TL251bWFjdGwtMC45LjgtMTIuZWw1XzYuc3JjLnJw
bQ0KDQo=
