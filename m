From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Fri, 23 Sep 2016 13:23:22 +0000
Message-ID: <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <20160923123224.odybv2uos6tot6it@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:21278 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965948AbcIWNXa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 09:23:30 -0400
In-Reply-To: <20160923123224.odybv2uos6tot6it@linutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgU2ViYXN0aWFuLA0KDQo+ID4gVGhlIGNvZGUgdGhhdCBpcyBjYXVzaW5nIHRoZSBsb25nIGxh
dGVuY2llcyBzZWVtcyB0byBiZSB0aGUgZnVuY3Rpb24NCj4gPiAiaWdiX3dhdGNoZG9nX3Rhc2si
IHdpdGhpbiBpZ2JfbWFpbi5jIChMaW5lOiA0Mzg2KS4NCj4gPiBUaGlzIGZ1bmN0aW9uIHdpbGwg
YmUgY2FsbGVkIHBlcmlvZGljYWxseS4NCj4gPiBXaGVuIEkgZG8gYSByZXR1cm4gYXQgdGhlIGJl
Z2lubmluZyBvZiB0aGlzIGZ1bmN0aW9uIHRoZSBhZGRpdGlvbmFsIGxhdGVuY3kgaXMgbm90DQo+
IHNlZW4uDQo+ID4gSW4gcGFydGljdWxhciB0aGF0IGZ1bmN0aW9uIGNhbGxzICJpZ2JfaGFzX2xp
bmsiIHdoaWNoIHNlZW1zIHRvIGJlIG9uZQ0KPiA+IGNhbmRpZGF0ZSB0aGF0IGlzIGNhdXNpbmcg
YWRkaXRpb25hbCBsYXRlbmN5Lg0KPiA+IERvIHlvdSBoYXZlIGFueSBjbHVlIGhvdyB0aGlzIGNv
ZGUgY2FuIGJlIGV4ZWN1dGVkIHByb3Blcmx5IHdpdGhvdXQNCj4gPiBjYXVzaW5nIHRoZSBhZGRp
dGlvbmFsIGxhdGVuY2llcz8NCj4gDQo+IE5vcGUuIFRoZSB3YXRjaGRvZyBmdW5jdGlvbiBpcyBp
bnZva2VkIHZpYSBzY2hlZHVsZV93b3JrKCkgc28gaXQgc2hvdWxkIG5vdCBiZQ0KPiBibG9ja2lu
ZyBhbnl0aGluZy4gVGhlcmUgaXMgbm8gcHJlZW1wdCBkaXNhYmxlIG9yIGFueXRoaW5nIGxpa2Ug
dGhhdC4gQ291bGQgeW91DQo+IG5hcnJvdyBpdCBkb3duIGZ1cnRoZXI/IFRoZSBpZ2JfaGFzX2xp
bmsoKSBzZWVtcyBhbHNvIHNtYWxsIGFuZCBzaW1wbGUuDQo+DQpPSy4gSSB0cmllZCB0byBkaWcg
ZGVlcGVyIGludG8gdGhhdC4uLi4NClRoZSBjcml0aWNhbCBzdHVmZiBzZWVtcyB0byBiZQ0KaWdi
X2hhc19saW5rKCkgY2FsbGluZyBody0+bWFjX29wcy5jaGVja19mb3JfbGluayAod2hpY2ggaXMg
aWdiX2NoZWNrX2Zvcl9saW5rXzgyNTc1KCkgKQ0KY2FsbGluZyBpZ2JfY2hlY2tfZm9yX2NvcHBl
cl9saW5rKCkgY2FsbGluZyBpZ2JfcGh5X2hhc19saW5rLg0KDQpXaXRoaW4gaWdiX3BoeV9oYXNf
bGluaygpIHRoZSBsaW5lIHdpdGggdGhlIGNvZGUNCiAgIHJldF92YWwgPSBody0+cGh5Lm9wcy5y
ZWFkX3JlZyhodywgUEhZX1NUQVRVUywgJnBoeV9zdGF0dXMpOw0Kc2VlbXMgdG8gYmUgdGhlIGNh
bmRpZGF0ZSB0aGF0IGNhdXNpbmcgdGhlIHRyb3VibGUuDQpBbmQgdGhpcyBmdW5jdGlvbiBwb2lu
dGVyIHBvaW50cyB0byBpZ2JfcmVhZF9waHlfcmVnXzgyNTgwKCkuDQoNCkRvZXMgdGhpcyBnaXZl
IHlvdSBhbnkgaWRlYSB3aGF0IGdvZXMgd3Jvbmc/DQoNClRoYW5rcyBmb3IgYW55IGhpbnRzIQ0K
DQpSZWdhcmRzDQoNCk1hdGhpYXMNCg0KDQoNCg==
