From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Mon, 20 Mar 2017 22:54:41 +0000
Message-ID: <1490050481.15509.14.camel@intel.com>
References: <1486579285.29816.105.camel@intel.com>
           <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
           <1487011713.17279.27.camel@intel.com>
           <20170215165447.zr4k5rmenwvormdk@linutronix.de>
           <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
           <1487212458.10966.7.camel@intel.com>
         <1487727789.28401.17.camel@intel.com>
           <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
           <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
           <1488424982.29259.32.camel@intel.com>
           <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
         <alpine.DEB.2.20.1703032202240.3691@nanos>
          <1488584180.29259.76.camel@intel.com>
          <alpine.DEB.2.20.1703061222150.3561@nanos>
         <1488852108.29259.85.camel@intel.com>
         <alpine.DEB.2.20.1703071800330.3584@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "julia@ni.com" <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "darren.hart@intel.com" <darren.hart@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:64552 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753610AbdCTWyn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Mar 2017 18:54:43 -0400
In-Reply-To: <alpine.DEB.2.20.1703071800330.3584@nanos>
Content-Language: en-US
Content-ID: <1072E6101CAB874D9E8F8FA8A5109F09@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgVGhvbWFzLMKgDQoNClRoYW5rcyBmb3IgYWxsIHlvdXIgaW5wdXQuDQoNCk9uIFR1ZSwgMjAx
Ny0wMy0wNyBhdCAxODowMyArMDEwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBUdWUs
IDcgTWFyIDIwMTcsIFBhdGVsLCBWZWRhbmcgd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCAyMDE3
LTAzLTA2IGF0IDEyOjI5ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+ID4gDQo+ID4g
PiANCj4gPiA+IFRoaXMgaXMgc2ltcGxlIHRvIGFjaGlldmUgZm9yIHRpbWVycyB3aGVyZSB0aGUg
c2lnbmFsIGlzIGRpcmVjdGVkDQo+ID4gPiB0bw0KPiA+ID4gYSB0aHJlYWQsIGJ1dCBpdCdzIHdh
eSBtb3JlIGNvbXBsZXggZm9yIHByb2Nlc3Mgd2lkZSBzaWduYWwNCj4gPiA+IGRlbGl2ZXJ5Lg0K
PiA+ID4gDQo+ID4gU28sIGRvZXMgdGhpcyBtZWFuIHRoYXQgd2Ugc2hvdWxkIGJlIGFza2luZyBw
ZW9wbGUgbm90IHRvIHVzZSBQT1NJWA0KPiA+IHRpbWVycyB1bnRpbCB0aGlzIGlzIGNvcnJlY3Rl
ZD8NCj4gV2VsbCwgd2UgYWx3YXlzIHJlY29tbWVuZGVkIGNsb2NrX25hbm9zbGVlcCgpIHRvIGJl
IHVzZWQgYW5kIHRvIGF2b2lkDQo+IHNpZ25hbCBiYXNlZCB0aW1lcnMgd2hlbiBldmVyIHBvc3Np
YmxlLg0KDQpJIGhhdmUgMiBxdWVzdGlvbnM6DQoNCjEuIEkgc2VlIGEgcmVncmVzc2lvbiBmb3Ig
UE9TSVggdGltZXJzIG9uIHJlYWwtdGltZSBrZXJuZWwgZnJvbSB0aGUNCm1haW5saW5lIGtlcm5l
bCBmb3IgdGhlIGtlcm5lbCB2ZXJzaW9ucyBJIGFtIHVzaW5nLiBIYXMgYW55b25lIGVsc2UNCnNl
ZW4gdGhpcz8gSSBoYXZlIHRlc3RlZCBtdWx0aXBsZSBrZXJuZWxzICg0LjEsIDQuNCwgNC45LjQp
IGFuZCBJIGFtDQpzZWVpbmcgYSByZWdyZXNzaW9uIGluIGFsbCBvZiB0aG9zZS4gSXMgdGhpcyBz
b21ldGhpbmcgd2UgZXhwZWN0DQpiZWNhdXNlIG9mIGNoYW5nZXMgaW4gc29mdGlycXM/DQoNCjIu
IElmIHRoZXJlIGlzIGluZGVlZCBhIHJlZ3Jlc3Npb24sIHdoYXQgaXMgdGhlIGJlc3Qgd2F5IHRv
IGRvY3VtZW50DQp0aGlzPyBJIHRoaW5rIHBvc3RpbmcgcmVzdWx0cyBvbsKgaHR0cHM6Ly93aWtp
LmxpbnV4Zm91bmRhdGlvbi5vcmcvcmVhbHQNCmltZS9kb2N1bWVudGF0aW9uL2hvd3RvL3Rvb2xz
L2N5Y2xpY3Rlc3TCoGFuZCBwb2ludGluZyBvdXQgcmVncmVzc2lvbnMNCndpbGwgYmUgb25lIHdh
eS4NCg0KVGhhbmtzLA0KVmVkYW5nDQoNCj4gDQo+ID4gDQo+ID4gQWxzbywgSXMgdGhlcmUgYSB3
YXkgdG8gc3BlY2lmeSB3aGljaCBrdGltZXJzb2Z0ZCB0aHJlYWQNCj4gPiAoZXNzZW50aWFsbHkN
Cj4gPiBzZWxlY3RpbmcgYSBwYXJ0aWN1bGFyIENQVSl0byB1c2Ugd2hpbGUgY3JlYXRpbmcgYSB0
aW1lcj8NCj4gPiBDdXJyZW50bHksDQo+ID4gdGhlIGt0aW1lcnNvZnRkIHRocmVhZCBjb3JyZXNw
b25kaW5nIHRvIHRoZSB0aHJlYWQgb24gd2hpY2ggdGhlIENQVQ0KPiA+IGlzDQo+ID4gcnVubmlu
ZyBpcyBiZWluZyB1c2VkIGJ5IGN5Y2xpY3Rlc3QuIFRoaXMgd291bGQgcHJldmVudCB0aGUgYm91
bmNlDQo+ID4gYmV0d2VlbiBrdGltZXJzb2Z0ZCBhbmQgY3ljbGljdGVzdCB0aHJlYWQgd2hlbiBi
b3RoIG9mIHRoZW0gYXJlIG9uDQo+ID4gdGhlDQo+ID4gc2FtZSBDUFUuDQo+IE5vcGUuIFRoaXMg
aXMgZXZlbiBtb3JlIGNvbXBsZXggdGhhbiB5b3UgZGVzY3JpYmUgaXQgYW5kIG5vLCB3ZQ0KPiBk
ZWZpbml0ZWx5DQo+IGRvbid0IHdhbnQgdG8gdGhpbmsgYWJvdXQgdGhpcyBpbiB0aGUgZmlyc3Qg
cGxhY2UuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiA=
