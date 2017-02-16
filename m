From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Thu, 16 Feb 2017 02:34:18 +0000
Message-ID: <1487212458.10966.7.camel@intel.com>
References: <1486579285.29816.105.camel@intel.com>
         <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
         <1487011713.17279.27.camel@intel.com>
         <20170215165447.zr4k5rmenwvormdk@linutronix.de>
         <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "julia@ni.com" <julia@ni.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752816AbdBPCeV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 21:34:21 -0500
In-Reply-To: <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Content-ID: <779C9C7546A63E48A6AD68D9BF875647@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

T24gV2VkLCAyMDE3LTAyLTE1IGF0IDIwOjA1IC0wNjAwLCBKdWxpYSBDYXJ0d3JpZ2h0IHdyb3Rl
Og0KPiBPbiBXZWQsIEZlYiAxNSwgMjAxNyBhdCAwNTo1NDo0N1BNICswMTAwLCBiaWdlYXN5QGxp
bnV0cm9uaXguZGUNCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gMjAxNy0wMi0xMyAxODo0ODozMyBb
KzAwMDBdLCBQYXRlbCwgVmVkYW5nIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBJIGFtIGdldHRpbmcg
dmVyeSBzaW1pbGFyIHJlc3VsdHMgZXZlbiBpZiBJIGNoYW5nZSB0aGUgcHJpb3JpdHkNCj4gPiA+
IG9mDQo+ID4gPiBrdGltZXJzb2Z0ZCB0byA5OS4gQXJlIHRoZXJlIGFueSByZWNlbnQgcnQgcGF0
Y2hlcyB3aGljaCBtaWdodA0KPiA+ID4gaGF2ZQ0KPiA+ID4gY2hhbmdlZCB0aGUgYmVoYXZpb3Vy
IG9mIFBPU0lYIHRpbWVycz/CoA0KPiA+IEkgaGFkIHRoaXMgcnVubmluZw0KPiA+IA0KPiA+ID4g
DQo+ID4gPiB+IyBjeWNsaWN0ZXN0IC10MSAtcCA4MCAtaSA1MDAgLWwgMTAwMDAwDQo+ID4gPiAj
IC9kZXYvY3B1X2RtYV9sYXRlbmN5IHNldCB0byAwdXMNCj4gPiA+IHBvbGljeTogZmlmbzogbG9h
ZGF2ZzogNjI3LjQ4IDY2MS45OCA1NDMuNjUgNDA2LzIyNTQNCj4gPiA+IDE4MTQ5wqDCoMKgwqDC
oMKgwqDCoMKgwqANCj4gPiA+IA0KPiA+ID4gVDogMCAoMTYxNDgpIFA6ODAgSTo1MDAgQzogMTAw
MDAwIE1pbjrCoMKgwqDCoMKgwqA1IEFjdDrCoMKgwqAxMSBBdmc6wqDCoMKgMTENCj4gPiA+IE1h
eDogMjMNCj4gPiBvbiBhIEFNRC1BMTAgYm94IGFuZCB0aGUgbGF0ZXN0IHY0LjktUlQuIFRoaXMg
ZG9lcyBub3QgbG9vayB0aGF0DQo+ID4gYmFkLg0KPiA+IEZyb20gdHJhY2luZyBpdCBkb2Vzbid0
IGxvb2sgdG9vIGdvb2QgZWl0aGVyLiBUaGUgLW0gb3B0aW9uIHNob3VsZA0KPiA+IGJlDQo+ID4g
eW91ciBmcmllbmQuIFNpbmNlIHRoZSBjeWNsaWN0ZXN0IGlzbid0IHBpbm5lZCB0byBhIENQVSBh
bmQgSSBoYXZlDQo+ID4gZm91cg0KPiA+IG9mIHRoZW0sIHRoZSBzY2hlZHVsZXIgZGVjaWRlcyB0
byBtaWdyYXRlIGN5Y2xpY3Rlc3Qgb24gZWFjaCB3YWtlDQo+ID4gdXAuDQo+ID4geWF5LiBjeWNs
aWN0ZXN0IGl0c2VsZiBnZXRzIHdva2VuIHVwIHZpYSBhIHNpZ25hbCBmcm9tIHRoZQ0KPiA+IGt0
aW1lcnNvZnRpcnEuDQo+IFBlcmhhcHMgYSBzZXBhcmF0ZSBvZmYtc2hvb3QgdG9waWMsIGJ1dCBo
YXMgdGhlcmUgYmVlbiBzaWduaWZpY2FudA0KPiBjaGFuZ2VzIGluIHY0LjkgdXBzdHJlYW0gKG9y
IHY0LjktcnQpIHdoaWNoIGltcGFjdCBob3cgb2Z0ZW4NCj4gbWlncmF0aW9uDQo+IGlzIHBlcmZv
cm1lZD/CoMKgV2UndmUgc2VlbiB3aGF0IGFwcGVhcnMgdG8gYmUgbXVjaCBtb3JlIGFnZ3Jlc3Np
dmUNCj4gbWlncmF0aW9uIG9mIFNDSEVEX0ZBSVIgdGFza3MsIChhZ2dyZXNzaXZlIGluIHRoZSBz
ZW5zZSB0aGF0IG1vcmUNCj4gdGhyZWFkcyBhcmUgbWlncmF0ZWQgbW9yZSBvZnRlbiksIHdoaWNo
IGFwcGVhcnMgdG8gY2F1c2UgY29udGVudGlvbg0KPiBvbg0KPiBycS1sb2NrcyBpbXBhY3Rpbmcg
bGF0ZW5jaWVzIGluIHRoZSB3YWtlX3VwIHBhdGhzLg0KPiANCj4gV2UncmUgc3RpbGwgd29ya2lu
ZyB0byBmdXJ0aGVyIGNoYXJhY3Rlcml6ZSBhdCB0aGlzDQo+IHBvaW50Li4uLmhvcGVmdWxseQ0K
PiBtb3JlIGluZm9ybWF0aW9uIGZvcnRoY29taW5nLg0KSSB0cmllZCBjb25kdWN0aW5nIHNpbWls
YXIgZXhwZXJpbWVudHMgb24gdjQuNC40Ny1ydDU5LiBCdXQsIHRoZQ0KcmVzdWx0cyBhcmUgc2Ft
ZSBhcyB2NC45IGtlcm5lbC4NCg0KTXkgbWFjaGluZSBhbHNvIGhhcyA4IGNvcmVzIGFuZCBtaWdy
YXRpb24gbWlnaHQgY2F1c2UgcmVncmVzc2lvbnMuIExldA0KbWUgdHJ5IHBpbm5pbmcgdGhlIHBy
b2Nlc3NlcyB0byBhIHNpbmdsZSBDUFUgYW5kIHNlZSBpZiB0aGF0IGlzIG1ha2luZw0KYW55IGRp
ZmZlcmVuY2UuwqANCg0KTW9yZSBpbmZvcm1hdGlvbiB0byBmb2xsb3cgc29vbi4uLg0KDQpUaGFu
a3MgZm9yIGFsbCB0aGUgaW5wdXRzLMKgDQpWZWRhbmcgUGF0ZWwNClNvZnR3YXJlIEVuZ2luZWVy
DQpJbnRlbCBDb3Jwb3JhdGlvbg0KPiDCoMKgwqBKdWxpYQ==
