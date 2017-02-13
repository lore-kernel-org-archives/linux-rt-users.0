From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Mon, 13 Feb 2017 18:48:33 +0000
Message-ID: <1487011713.17279.27.camel@intel.com>
References: <1486579285.29816.105.camel@intel.com>
         <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30803 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbdBMSsl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 13:48:41 -0500
In-Reply-To: <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
Content-Language: en-US
Content-ID: <FE8568075653AC499826C54FC8B5E106@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

T24gRnJpLCAyMDE3LTAyLTEwIGF0IDIwOjA3ICswMTAwLCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3
aW9yIHdyb3RlOg0KPiBPbiAyMDE3LTAyLTA4IDE4OjQxOjI1IFsrMDAwMF0sIFBhdGVsLCBWZWRh
bmcgd3JvdGU6DQo+ID4gDQo+ID4gSGkswqANCj4gSGksDQo+IA0KPiA+IA0KPiA+IFRoZSByZXN1
bHRzIGZvciB0aGUgUE9TSVggdGltZXJzIHdlcmUgbm90IGFzIEkgZXhwZWN0ZWQuIFRoZQ0KPiA+
IGxhdGVuY3kNCj4gPiBmb3IgcmVhbC10aW1lIGtlcm5lbCAodjQuOS40LXJ0Mikgd2FzIHdvcnNl
IGNvbXBhcmVkIHRvIHRoZQ0KPiA+IG1haW5saW5lDQo+ID4ga2VybmVsICh2NC45LjQpLiBJbiBh
bG1vc3QgYWxsIHRoZSBjYXNlcywgdGhlIGxhdGVuY3kgaXMgYWxtb3N0DQo+ID4gZG91YmxlZA0K
PiA+IMKgd2l0aCB0aGUgbWF4IHZhbHVlIHJlYWNoaW5nIGFib3V0IDEwIHRpbWVzIHdoZW4gcGVy
Zm9ybWluZyB0aGUNCj4gPiB0ZXN0cw0KPiA+IHVuZGVyIGxvYWQuDQo+IElzIGl0IGFsc28gdGhl
IGNhc2UgaWYgeW91IGJvb3N0IHRoZSBwcmlvcml0eSBvZiBrdGltZXJzb2Z0ZC9YDQo+IHRocmVh
ZHM/DQo+IEZvciBjbG9ja19uYW5vc2xlZXAsIHRoZSB3YWtlLXVwcyBoYXBwZW4gZGlyZWN0bHkg
ZnJvbSBoYXJkLXRpbWVyDQo+IGludGVycnVwdC4gRm9yIHRoZSBwb3NpeC10aW1lciB3ZSBoYXZl
IHRvIGRlbGF5IHRob3NlIHRvIHRoZQ0KPiBrdGltZXJzb2Z0ZA0KPiB0aHJlYWQgd2hpY2ggcnVu
cyB1c3VhbGx5IFJUIHByaW8gMS4NCj4gDQpJIGFtIGdldHRpbmcgdmVyeSBzaW1pbGFyIHJlc3Vs
dHMgZXZlbiBpZiBJIGNoYW5nZSB0aGUgcHJpb3JpdHkgb2YNCmt0aW1lcnNvZnRkIHRvIDk5LiBB
cmUgdGhlcmUgYW55IHJlY2VudCBydCBwYXRjaGVzIHdoaWNoIG1pZ2h0IGhhdmUNCmNoYW5nZWQg
dGhlIGJlaGF2aW91ciBvZiBQT1NJWCB0aW1lcnM/wqANCg0KQWxzbywgYXJlIFBPU0lYIHRpbWVy
cyByZWFsbHkgc3VpdGVkIGZvciAicmVhbC10aW1lIiBhcHBsaWNhdGlvbnM/SQ0KYmVsaWV2ZSBh
IHNpbWlsYXIgcXVlc3Rpb24gd2FzIHJhaXNlZCBieSBSYW4gU2hhbGl0IGEgZmV3IGRheXMgYmFj
azrCoA0KaHR0cDovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1ydC11c2Vycy9tc2cxNjI0
OS5odG1sDQoNClRoYW5rcywNClZlZGFuZw0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBWZWRhbmcg
UGF0ZWwNCj4gPiBTb2Z0d2FyZSBFbmdpbmVlcg0KPiA+IEludGVsIENvcnBvcmF0aW9uDQo+IFNl
YmFzdGlhbg==
