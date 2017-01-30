From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Mon, 30 Jan 2017 07:24:27 +0000
Message-ID: <6bb5dbe00d8a4d1382cb7c49b21d3019@FE-MBX1012.de.bosch.com>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
 <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
 <ef2c680e3ed541c4b0df5e0715ca8264@FE-MBX1012.de.bosch.com>
 <3c9395f9c6b944978c1f420276bde0ee@FE-MBX1012.de.bosch.com>
 <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
 <20170127153341.6er3av4saygdzr7o@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:10125 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdA3HYu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jan 2017 02:24:50 -0500
In-Reply-To: <20170127153341.6er3av4saygdzr7o@linutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgU2ViYXN0aWFuLA0KDQo+ID4gSW4gYWxsIHRoZSBzdWNjZXNzZnVsIGxvb3BzIHRoZSBsaW5l
cyBpbiB0aGUgdHJhY2UgbG9vayBsaWtlIHRoZSBsaW5lcyBpbiB0aGUgc3VjY2Vzc2Z1bA0KPiAo
Mm5kKSBleGFtcGxlIGJlbG93Lg0KPiA+IEluIHRoZSBlcnJvciBjYXNlIHRoZXJlIGlzIGFuIGFk
ZGl0aW9uYWwgc2NoZWRfd2FraW5nIGFuZCBzY2hlZF93YWtldXAgaW4gdGhlDQo+IHRyYWNlLg0K
PiA+IEFsc28gdGhlcmUgaXMgYWx3YXlzICJwcmV2X3N0YXRlPVMiIHdpdGhpbiB0aGUgZm9ya2Vk
IHByb2Nlc3MuDQo+ID4gSW4gdGhlIGVycm9yIGNhc2UsIHRoZXJlIGlzICJwcmV2X3N0YXRlPVR8
SyIuDQo+IA0KPiBUaGF0IFR8SyBpcyBwcm9iYWJseSBzb21lIGtpbmQgb2YgZGVidWcgc3RhdGUg
dGhlIHByb2dyYW0gcmVtYWlucyB1bnRpbCB0aGUNCj4gZGVidWdnZXIgcHV0cyBpdCBiYWNrIG9u
IHRyYWNrLiBJIHRoaW5rIHRoZSBpbnRlcmVzdGluZyBwYXJ0IGlzdCBmaWd1cmUgb3V0IHdoYXQg
ZGVjaWRlZA0KPiB0byBzZW5kIHRoaXMgc2lnbmFsIG9yIHB1dCB0aGUgcHJvZ3JhbSBpbnRvIHN0
b3Atc3RhdGUuIFVzdWFsbHkgYSBicmVha3BvaW50LCBpbnZhbGlkDQo+IG9wY29kZSwg4oCmIGNh
dXNlcyB0aGlzIGtpbmQgb2YgYWN0aW9uIGJ1dCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgeW91
IHVzZSBub25lIG9mDQo+IHRob3NlLg0KUGVyaGFwcyBJIHdhcyBub3QgcHJlY2lzZSBlbm91Z2gg
aW4gbXkgcHJldmlvdXMgbWFpbC4gDQpUaGUgZWZmZWN0IHRoYXQgSSBkZXNjcmliZWQgaW4gdGhl
cmUgd2FzIG5vdCBhIFNJR1NUT1AgYnV0IGEgaGFuZ2luZyB0aHJlYWQuDQpJIGhhZCB0byBwcmVz
cyBDVFJMLUMgdG8gaW50ZXJydXB0IHRoZSBleGVjdXRpb24gYW5kIHRvIGVudGVyIHRoZSBnZGIg
cHJvbXB0Lg0KVGhpcyBoYW5naW5nIG9jY3VycyBpbiAxMC0yMCUgb2YgdGhlIHJ1bnMuDQpBbHNv
IGhlcmUsIHRoaXMgaGFuZyBhbHdheXMgb2NjdXJzIHdoZW4gb25lIG9mIHRoZSB0aHJlYWRzIGRv
ZXMgYSBraW5kIG9mICJjbG9uZSIuDQpBbmQgdGhpcyBlZmZlY3Qgb25seSBhcHBlYXJzIGl0IHRo
ZSBrZXJuZWwgaXMgY29uZmlndXJlZCBmb3IgImZ1bGwgcHJlZW1wdGlibGUiLg0KDQpTbyB0aGVy
ZSBhcmUgdHdvIGVmZmVjdHMgSSBoYXZlIG5vdGljZWQ6DQotIFRoZSBzdHJhbmdlIFNJR1NUT1Ag
d2hlcmUgSSBjYW5ub3QgcHJvdmlkZSBhIHNpbXBsZSB0ZXN0IGV4ZWN1dGFibGUNCi0gVGhlIHN0
cmFuZ2UgaXNzdWUgd2l0aCB0aGUgaGFuZ2luZyB0aHJlYWQgKHBsZWFzZSB1c2UgdGhlIGV4YW1w
bGUgZnJvbSBteSBwcmV2aW91cyBtYWlsKQ0KSW4gYm90aCBpc3N1ZXMsIGEgImNsb25lIiBpcyBl
eGVjdXRlZCBpbiBvbmUgb2YgdGhlIHRocmVhZHMuDQoNClJlZ2FyZHMNCg0KTWF0aGlhcw0K
