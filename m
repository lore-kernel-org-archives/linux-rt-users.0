From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Tue, 7 Mar 2017 02:01:49 +0000
Message-ID: <1488852108.29259.85.camel@intel.com>
References: <1486579285.29816.105.camel@intel.com>
          <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
          <1487011713.17279.27.camel@intel.com>
          <20170215165447.zr4k5rmenwvormdk@linutronix.de>
          <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
          <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com>
          <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
          <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
          <1488424982.29259.32.camel@intel.com>
          <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
         <alpine.DEB.2.20.1703032202240.3691@nanos>
         <1488584180.29259.76.camel@intel.com>
         <alpine.DEB.2.20.1703061222150.3561@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "julia@ni.com" <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "Hart, Darren" <darren.hart@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15003 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932348AbdCGCCB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Mar 2017 21:02:01 -0500
In-Reply-To: <alpine.DEB.2.20.1703061222150.3561@nanos>
Content-Language: en-US
Content-ID: <3F9386990272A943B064F29E4A28C092@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

T24gTW9uLCAyMDE3LTAzLTA2IGF0IDEyOjI5ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIEZyaSwgMyBNYXIgMjAxNywgUGF0ZWwsIFZlZGFuZyB3cm90ZToNCj4gPiANCj4gPiBJ
IG5vdyBoYXZlIHRoZSBmb2xsb3dpbmcgY29uY2VybnMgYW5kIGNvbW1lbnRzOg0KPiA+IDEuIHJl
YWwtdGltZSBrZXJuZWwgdnMuIE1haW5saW5lIGtlcm5lbDogVGhlIHJlYWwtdGltZSBrZXJuZWwg
aXMNCj4gPiB3b3JzZQ0KPiA+IHdpdGggUE9TSVggdGltZXJzIHRoYW4gdGhlIG1haW5saW5lIGtl
cm5lbC4gVGhpcyBpcyBvZGQuIElzIHRoaXMNCj4gPiBiZWNhdXNlIHRoZSBzb2Z0aXJxcyBhcmUg
bm90IHRoZSBzYW1lIGFueW1vcmUoU29ycnksIEkgYW0gc3RpbGwgbm90DQo+ID4gZmFtaWxpYXIg
d2l0aCB3aGF0IHRoZXkgaGF2ZSBiZWNvbWUuIEkgZGVkdWNlZCB0aGUgIm5vdCB0aGUgc2FtZSIN
Cj4gPiBwYXJ0DQo+ID4gZnJvbSBjb21taXQgbWVzc2FnZXMvY29tbWVudHMgaW4gY29kZS4gOikp
PyBBbHNvLCBpbiBodHRwczovL2dpdC5rZQ0KPiA+IHJuZWwNCj4gPiAub3JnL2NnaXQvbGludXgv
a2VybmVsL2dpdC9ydC9saW51eC1zdGFibGUtcnQuZ2l0L2NvbW1pdC8/aD12NC40LQ0KPiA+IHJ0
JmlkPTRhYTdjYmE1N2Y3M2FjZjFlM2U0OTk4YWUxNjUwOTY1MzE3YzJkZTEsIGl0IGlzIG1lbnRp
b25lZDoNCj4gPiAiDQo+ID4gQnJpbmcgYmFjayB0aGUgc29mdGlycSBzcGxpdCBmb3Igbm93LCB1
bnRpbCB3ZSBmaXhlZCB0aGUgc2lnbmFsDQo+ID4gZGVsaXZlcnkgcHJvYmxlbSBmb3IgcmVhbC4N
Cj4gPiAiDQo+ID4gV2hhdCBzaWduYWwgZGVsaXZlcnkgcHJvYmxlbSBpcyBiZWluZyByZWZlcnJl
ZCB0bz8NCj4gVGhlIHByb2JsZW0gd2l0aCB0aGVzZSB0aW1lcnMgaXMgdGhhdCB0aGUgaGVhdnkg
bGlmdGluZyBvZiBzaWduYWwNCj4gcHJvY2Vzc2luZyBoYXBwZW5zIGluICJzdG9sZW4iIGNvbnRl
eHQuIFRoYXQgbWVhbnMgdGhhdCB0aGUgd29yayBpcw0KPiBub3QNCj4gZG9uZSBpbiB0aGUgY29u
dGV4dCBvZiB0aGUgcHJvY2Vzcy90aHJlYWQgd2hpY2ggYXJtZWQgdGhlIHRpbWVyLCBidXQNCj4g
aW4NCj4gc29mdGlycSBjb250ZXh0Lg0KPiANCj4gV2hhdCB3ZSByZWFsbHkgd2FudCBoZXJlIGlz
IHRoZSBmb2xsb3dpbmc6DQo+IA0KPiDCoMKgwqDCoMKgdGltZXIgZXhwaXJlcygpDQo+IMKgwqDC
oMKgwqAJwqDCoMKgbWFyayB0aW1lciBleHBpcmVkIGluIHRocmVhZC9wcm9jZXNzDQo+IAnCoMKg
wqBldmVudHVhbGx5IHdha2V1cCB0aHJlYWQNCj4gDQo+IFRoaXMgaXMgc2ltcGxlIHRvIGFjaGll
dmUgZm9yIHRpbWVycyB3aGVyZSB0aGUgc2lnbmFsIGlzIGRpcmVjdGVkIHRvDQo+IGENCj4gdGhy
ZWFkLCBidXQgaXQncyB3YXkgbW9yZSBjb21wbGV4IGZvciBwcm9jZXNzIHdpZGUgc2lnbmFsIGRl
bGl2ZXJ5Lg0KPiANClNvLCBkb2VzIHRoaXMgbWVhbiB0aGF0IHdlIHNob3VsZCBiZSBhc2tpbmcg
cGVvcGxlIG5vdCB0byB1c2UgUE9TSVgNCnRpbWVycyB1bnRpbCB0aGlzIGlzIGNvcnJlY3RlZD/C
oA0KDQpBbHNvLCBJcyB0aGVyZSBhIHdheSB0byBzcGVjaWZ5IHdoaWNoIGt0aW1lcnNvZnRkIHRo
cmVhZCAoZXNzZW50aWFsbHkNCnNlbGVjdGluZyBhIHBhcnRpY3VsYXIgQ1BVKXRvIHVzZSB3aGls
ZSBjcmVhdGluZyBhIHRpbWVyPyBDdXJyZW50bHksDQp0aGUga3RpbWVyc29mdGQgdGhyZWFkIGNv
cnJlc3BvbmRpbmcgdG8gdGhlIHRocmVhZCBvbiB3aGljaCB0aGUgQ1BVIGlzDQpydW5uaW5nIGlz
IGJlaW5nIHVzZWQgYnkgY3ljbGljdGVzdC4gVGhpcyB3b3VsZCBwcmV2ZW50IHRoZSBib3VuY2UN
CmJldHdlZW4ga3RpbWVyc29mdGQgYW5kIGN5Y2xpY3Rlc3QgdGhyZWFkIHdoZW4gYm90aCBvZiB0
aGVtIGFyZSBvbiB0aGUNCnNhbWUgQ1BVLsKgDQoNClRoYW5rcywNClZlZGFuZyBQYXRlbA0KU29m
dHdhcmUgRW5naW5lZXINCkludGVsIENvcnBvcmF0aW9uDQo+ID4gDQo+ID4gMi4gSW4gdGhlIGNh
c2UgdGhlIENQVSBhZmZpbml0eSBpcyBzZXQsIFRoZSBDUFUgaXMgc2hhcmVkIGJldHdlZW4NCj4g
PiBjeWNsaWN0ZXN0IHRocmVhZCBhbmQgdGhlIGt0aW1lcnNvZnRkIHRocmVhZC4gU28sIGluIHRo
ZSBlbmQsIDEgQ1BVDQo+ID4gbWlncmF0aW9uIGlzIGNoZWFwZXIgdGhhbiAzIGNvbnRleHQgc3dp
dGNoZXMuLi4gSXMgdGhpcyB0aGUgcmlnaHQNCj4gPiBhbmFseXNpcz8gSSBrbm93IHRoaXMgd2ls
bCB2YXJ5IGZyb20gYXBwbGljYXRpb24gdG8gYXBwbGljYXRpb24uDQo+IE5vLCBtaWdyYXRpb24g
aXMgbm90IGdlbmVyYWxseSBjaGVhcGVyLCBpbiBtb3N0IGNhc2VzIGl0cyBtb3JlDQo+IGV4cGVu
c2l2ZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4
