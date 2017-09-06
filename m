From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: [PATCH v2 02/40] tracing: Add support to detect and avoid
 duplicates
Date: Wed, 6 Sep 2017 20:58:03 +0000
Message-ID: <1504731482.21216.8.camel@intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <7f3ca68455bdac47285ed45d608075a4af287362.1504642143.git.tom.zanussi@linux.intel.com>
         <20170906144722.6eb71312@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "joel.opensrc@gmail.com" <joel.opensrc@gmail.com>,
        "Liu, Baohong" <baohong.liu@intel.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2693 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbdIFU6F (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Sep 2017 16:58:05 -0400
In-Reply-To: <20170906144722.6eb71312@gandalf.local.home>
Content-Language: en-US
Content-ID: <3C3ED21A51293349B8B15E52EDD5DF78@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

T24gV2VkLCAyMDE3LTA5LTA2IGF0IDE0OjQ3IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gVHVlLMKgwqA1IFNlcCAyMDE3IDE2OjU3OjE0IC0wNTAwDQo+IFRvbSBaYW51c3NpIDx0
b20uemFudXNzaUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjaW5nX21hcC5jDQo+ID4gYi9rZXJuZWwvdHJhY2Uv
dHJhY2luZ19tYXAuYw0KPiA+IGluZGV4IDMwNTAzOWIuLjQzN2I0OTAgMTAwNjQ0DQo+ID4gLS0t
IGEva2VybmVsL3RyYWNlL3RyYWNpbmdfbWFwLmMNCj4gPiArKysgYi9rZXJuZWwvdHJhY2UvdHJh
Y2luZ19tYXAuYw0KPiA+IEBAIC00MTQsNiArNDE0LDcgQEAgc3RhdGljIGlubGluZSBib29sIGtl
eXNfbWF0Y2godm9pZCAqa2V5LCB2b2lkDQo+ID4gKnRlc3Rfa2V5LCB1bnNpZ25lZCBrZXlfc2l6
ZSkNCj4gPiDCoF9fdHJhY2luZ19tYXBfaW5zZXJ0KHN0cnVjdCB0cmFjaW5nX21hcCAqbWFwLCB2
b2lkICprZXksIGJvb2wNCj4gPiBsb29rdXBfb25seSkNCj4gPiDCoHsNCj4gPiDCoAl1MzIgaWR4
LCBrZXlfaGFzaCwgdGVzdF9rZXk7DQo+ID4gKwlpbnQgZHVwX3RyeSA9IDA7DQo+ID4gwqAJc3Ry
dWN0IHRyYWNpbmdfbWFwX2VudHJ5ICplbnRyeTsNCj4gPiDCoA0KPiA+IMKgCWtleV9oYXNoID0g
amhhc2goa2V5LCBtYXAtPmtleV9zaXplLCAwKTsNCj4gPiBAQCAtNDI2LDEwICs0MjcsMzEgQEAg
c3RhdGljIGlubGluZSBib29sIGtleXNfbWF0Y2godm9pZCAqa2V5LCB2b2lkDQo+ID4gKnRlc3Rf
a2V5LCB1bnNpZ25lZCBrZXlfc2l6ZSkNCj4gPiDCoAkJZW50cnkgPSBUUkFDSU5HX01BUF9FTlRS
WShtYXAtPm1hcCwgaWR4KTsNCj4gPiDCoAkJdGVzdF9rZXkgPSBlbnRyeS0+a2V5Ow0KPiA+IMKg
DQo+ID4gLQkJaWYgKHRlc3Rfa2V5ICYmIHRlc3Rfa2V5ID09IGtleV9oYXNoICYmIGVudHJ5LT52
YWwgDQo+ID4gJiYNCj4gPiAtCQnCoMKgwqDCoGtleXNfbWF0Y2goa2V5LCBlbnRyeS0+dmFsLT5r
ZXksIG1hcC0NCj4gPiA+a2V5X3NpemUpKSB7DQo+ID4gLQkJCWF0b21pYzY0X2luYygmbWFwLT5o
aXRzKTsNCj4gPiAtCQkJcmV0dXJuIGVudHJ5LT52YWw7DQo+ID4gKwkJaWYgKHRlc3Rfa2V5ICYm
IHRlc3Rfa2V5ID09IGtleV9oYXNoKSB7DQo+ID4gKwkJCWlmIChlbnRyeS0+dmFsICYmDQo+ID4g
KwkJCcKgwqDCoMKga2V5c19tYXRjaChrZXksIGVudHJ5LT52YWwtPmtleSwgbWFwLQ0KPiA+ID5r
ZXlfc2l6ZSkpIHsNCj4gPiArCQkJCWF0b21pYzY0X2luYygmbWFwLT5oaXRzKTsNCj4gPiArCQkJ
CXJldHVybiBlbnRyeS0+dmFsOw0KPiA+ICsJCQl9IGVsc2UgaWYgKHVubGlrZWx5KCFlbnRyeS0+
dmFsKSkgew0KPiBJJ20gdGhpbmtpbmcgd2UgbmVlZCBhIFJFQURfT05DRSgpIGhlcmUuDQo+IA0K
PiAJCXZhbCA9IFJFQURfT05DRShlbnRyeS0+dmFsKTsNCj4gDQo+IHRoZW4gdXNlICJ2YWwiIGlu
c3RlYWQgb2YgZW50cnktPnZhbC4gT3RoZXJ3aXNlLCB3b250IGl0IGJlIHBvc3NpYmxlDQo+IGlm
IHR3byB0YXNrcyBhcmUgaW5zZXJ0aW5nIGF0IHRoZSBzYW1lIHRpbWUsIHRvIGhhdmUgdGhpczoN
Cj4gDQo+IChVc2luZyByZWcgYXMgd2hlbiB0aGUgdmFsdWUgaXMgcmVhZCBpbnRvIGEgcmVnaXN0
ZXIgZnJvbSBtZW1vcnkpDQo+IA0KPiAJQ1BVMAkJCUNQVTENCj4gCS0tLS0JCQktLS0tDQo+IMKg
cmVnID0gZW50cnktPnZhbA0KPiDCoChyZWcgPT0gemVybykNCj4gDQo+IAkJCcKgwqDCoGVudHJ5
LT52YWwgPSBlbHQ7DQo+IA0KPiDCoGtleXNfbWF0Y2goa2V5LCByZWcpDQo+IMKgKGZhbHNlKQ0K
PiANCj4gwqByZWcgPSBlbnRyeS0+dmFsDQo+IMKgKHJlZyA9IGVsdCkNCj4gDQo+IMKgaWYgKHVu
bGlrZWx5KCFyZWcpKQ0KPiANCj4gQ2F1c2VzIHRoZSBpZiB0byBmYWlsLg0KPiANCj4gQSBSRUFE
X09OQ0UoKSwgd291bGQgbWFrZSBzdXJlIHRoZSBlbnRyeS0+dmFsIHVzZWQgdG8gdGVzdCBhZ2Fp
bnN0DQo+IGtleQ0KPiB3b3VsZCBhbHNvIGJlIHRoZSBzYW1lIHZhbHVlIHVzZWQgdG8gdGVzdCBp
ZiBpdCBpcyB6ZXJvLg0KPiANCkhpIFN0ZXZlLMKgDQoNClRoYW5rcyBmb3IgdGhlIGlucHV0LsKg
DQoNCkkgYWdyZWUgd2l0aCB5b3VyIGNoYW5nZS4gQWRkaW5nIFJFQURfT05DRSB3aWxsIGF2b2lk
IGEgcmFjZSBjb25kaXRpb24NCndoaWNoIG1pZ2h0IHJlc3VsdCBpbiBhZGRpbmcgZHVwbGljYXRl
cy4gV2lsbCBhZGQgaXQgaW4gdGhlIG5leHQNCnZlcnNpb24uDQoNCi1WZWRhbmcNCj4gLS0gU3Rl
dmUNCj4gDQo+IA0KPiANCj4gPiANCj4gPiArCQkJCS8qDQo+ID4gKwkJCQnCoCogVGhlIGtleSBp
cyBwcmVzZW50LiBCdXQsIHZhbA0KPiA+IChwb2ludGVyIHRvIGVsdA0KPiA+ICsJCQkJwqAqIHN0
cnVjdCkgaXMgc3RpbGwgTlVMTC4gd2hpY2gNCj4gPiBtZWFucyBzb21lIG90aGVyDQo+ID4gKwkJ
CQnCoCogdGhyZWFkIGlzIGluIHRoZSBwcm9jZXNzIG9mDQo+ID4gaW5zZXJ0aW5nIGFuDQo+ID4g
KwkJCQnCoCogZWxlbWVudC4NCj4gPiArCQkJCcKgKg0KPiA+ICsJCQkJwqAqIE9uIHRvcCBvZiB0
aGF0LCBpdCdzIGtleV9oYXNoDQo+ID4gaXMgc2FtZSBhcyB0aGUNCj4gPiArCQkJCcKgKiBvbmUg
YmVpbmcgaW5zZXJ0ZWQgcmlnaHQgbm93Lg0KPiA+IFNvLCBpdCdzDQo+ID4gKwkJCQnCoCogcG9z
c2libGUgdGhhdCB0aGUgZWxlbWVudCBoYXMNCj4gPiB0aGUgc2FtZQ0KPiA+ICsJCQkJwqAqIGtl
eSBhcyB3ZWxsLg0KPiA+ICsJCQkJwqAqLw0KPiA+ICsNCj4gPiArCQkJCWR1cF90cnkrKzsNCj4g
PiArCQkJCWlmIChkdXBfdHJ5ID4gbWFwLT5tYXBfc2l6ZSkgew0KPiA+ICsJCQkJCWF0b21pYzY0
X2luYygmbWFwLT5kcm9wcyk7DQo+ID4gKwkJCQkJYnJlYWs7DQo+ID4gKwkJCQl9DQo+ID4gKwkJ
CQljb250aW51ZTsNCj4gPiArCQkJfQ0KPiA+IMKgCQl9DQo+ID4gwqANCj4gPiDCoAkJaWYgKCF0
ZXN0X2tleSkgew0KPiA+IEBAIC00NTEsNiArNDczLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBr
ZXlzX21hdGNoKHZvaWQgKmtleSwgdm9pZA0KPiA+ICp0ZXN0X2tleSwgdW5zaWduZWQga2V5X3Np
emUpDQo+ID4gwqAJCQkJYXRvbWljNjRfaW5jKCZtYXAtPmhpdHMpOw0KPiA+IMKgDQo+ID4gwqAJ
CQkJcmV0dXJuIGVudHJ5LT52YWw7DQo+ID4gKwkJCX0gZWxzZSB7DQo+ID4gKwkJCQkvKg0KPiA+
ICsJCQkJwqAqIGNtcHhjaGcoKSBmYWlsZWQuIExvb3AgYXJvdW5kDQo+ID4gb25jZQ0KPiA+ICsJ
CQkJwqAqIG1vcmUgdG8gY2hlY2sgd2hhdCBrZXkgd2FzDQo+ID4gaW5zZXJ0ZWQuDQo+ID4gKwkJ
CQnCoCovDQo+ID4gKwkJCQlkdXBfdHJ5Kys7DQo+ID4gKwkJCQljb250aW51ZTsNCj4gPiDCoAkJ
CX0NCj4gPiDCoAkJfQ0KPiA+IMKg
