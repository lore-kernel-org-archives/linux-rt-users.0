From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Tue, 27 Sep 2016 06:29:24 +0000
Message-ID: <68efc1a28c454c3f95f1d5d5231e2f68@FE-MBX1012.de.bosch.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <38815425.6GFOjqvR3a@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:34441 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbcI0G32 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Sep 2016 02:29:28 -0400
In-Reply-To: <38815425.6GFOjqvR3a@ws-stein>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgQWxleGFuZGVyLA0KDQp0aGFua3MgZm9yIHRoZSBwcm9wb3NhbC4gDQo+IA0KPiBJTUhPIHNv
bWV0aGluZyBpbiBpZ2Jfd2F0Y2hkb2dfdGFzayBjYXVzZXMgdGhlIGxhdGVuY3kgaW5kZXBlbmRl
bnRseSBmcm9tDQo+IGFjdHVhbCBsaW5rLiBBdCBmaXJzdCBnbGFuY2UgSSB3b3VsZCBzdXNwZWN0
IGlnYl91cGRhdGVfc3RhdHMgKGNhbGxlZCB3aXRoIHNwaW5sb2NrDQo+IGhlbGQpIGFzIGl0IHNl
ZW1zIHRvIGRvIGEgbG90IG9mIHJlYWRzLiBNYXliZSB0aGlzIHN0YWxscyBzb21laG93Lg0KPiBE
b2VzIHRoZSBsYXRlbmN5IHN0aWxsIG9jY3VyIGlmIHlvdSBjb21tZW50IHRoYXQgc3BpbmxvY2sg
YW5kIGNhbGwgdG8NCj4gaWdiX3VwZGF0ZV9zdGF0cyBvdXQ/DQogDQpJIHRyaWVkIHRoYXQsIGhv
d2V2ZXIgdGhlIHJlc3VsdCBpcyB0aGUgdmVyeSBzYW1lLiBJIGhhdmUgdGhlIHZlcnkgc2FtZSBs
YXRlbmN5IHNwaWtlcyBhcyBiZWZvcmUuDQpJIHdlbnQgZXZlbiBmdXJ0aGVyLiBXaXRoaW4gdGhl
IGZ1bmN0aW9uIGlnYl93YXRjaGRvZ190YXNrIEkgcmVtb3ZlZCBldmVyeXRoaW5nIGJ1dCB0aGUg
Y2FsbCB0byBpZ2JfaGFzX2xpbmsoKQ0KYW5kIHRoZSBmaW5hbCB0aW1lciByZXNldC4NCkhvd2V2
ZXIgZXZlbiB0aGF0IGxlZCB0byB0aGUgc2FtZSByZXN1bHQuDQpBbmQgdGhlcmUgSSBhbSBhZ2Fp
biBhdCB0aGUgZmluZGluZ3MgaW4gb25lIG9mIG15IHByZXZpb3VzIHBvc3RpbmdzIHdpdGhpbiB0
aGlzIHRocmVhZC4NClRoZSBjYWxsIHRvIGlnYl9oYXNfbGluayBtaWdodCBiZSBhIHJlYXNvbiBm
b3IgdGhlIGxhdGVuY3kgaml0dGVycywgaG93ZXZlciBJIGNhbm5vdCByZWFsbHkgYnJlYWsgaXQg
ZG93biBpbnRvIGEgDQpzaW5nbGUgcGllY2Ugb2YgY29kZSB0aGF0IGlzIHJlbGV2YW50IGhlcmUu
DQoNCg0KQmVzdCByZWdhcmRzDQoNCk1hdGhpYXMNCg==
