From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Wed, 25 Jan 2017 11:28:01 +0000
Message-ID: <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:16684 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbdAYL2E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 06:28:04 -0500
In-Reply-To: <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgU2ViYXN0aWFuLA0KDQo+IA0KPiBPbiAyMDE3LTAxLTI0IDA5OjE1OjU5IFsrMDAwMF0sIEtv
ZWhyZXIgTWF0aGlhcyAoRVRBUy9FU1c1KSB3cm90ZToNCj4gPiBUaGUga2VybmVsIHZlcnNpb24g
NC4xLjM3LXJ0NDMgaXMgd29ya2luZyBmaW5lLCB0aGUga2VybmVsIHZlcnNpb25zIDQuNC4zOS1y
dDUwIGFuZA0KPiA0LjguMTEtcnQ3IHNob3cgdGhlIHNhbWUgc3RyYW5nZSBiZWhhdmlvciBhcyA0
LjkuMC1ydDEuDQo+ID4gU29tZXRoaW5nIG9uIHRoZSB3YXkgYmV0d2VlbiA0LjEuMzctcnQ0MyBh
bmQgNC40LjM5LXJ0NTAgc2VlbXMgdG8gY2F1c2UgdGhlDQo+IHRyb3VibGUuDQo+IA0KPiBjYW4g
eW91IGNoZWNrIGlmIG9uZSBvZiB0aGUgZWFybGllciB2NC40LVJUIHJlbGVhc2VzIChtYXliZSBz
dGFydCB3aXRoDQo+IC1ydDIgb3IgLXJ0MSkgYWxzbyBzaG93cyB0aGlzIGJlaGF2aW91cj8NCj4g
SWYgbm90LCB3b3VsZCB5b3UgaGF2ZSBhIHRlc3RjYXNlPw0KSSB0ZXN0ZWQgd2l0aCA0LjQuMC1y
dDIuDQpIZXJlIHRoaXMgaXNzdWUgb2NjdXJzIHZlcnkgcmFyZWx5LiBJIHJhbiB0aGUgZ2RiIGZv
ciBhYm91dCAzMCB0aW1lcywgYW5kIGhlcmUgSSBnb3Qgb25lIGhpdC4NCldpdGggdGhlIG90aGVy
IGtlcm5lbCB2ZXJzaW9ucyBJIGdvdCB0aGUgaXNzdWUgaW4gMjAtNDAlIG9mIHRoZSBjYXNlcy4N
Cg0KSSB3aWxsIHRyeSBvdXQgdGhlIG90aGVyIDQuNC4wIHJlbGVhc2VzLi4uDQoNCkkgYWxzbyB0
cmllZCB0byBnZW5lcmF0ZSBhbiBlYXN5IHVzZWFibGUgdGVzdCBjYXNlIC0gd2l0aG91dCBzdWNj
ZXNzIHNvIGZhci4NClRoZSBpc3N1ZSBvY2N1cnMgd2l0aCBvdXIgKGxhcmdlKSBhcHBsaWNhdGlv
bi4NCg0KU29tZSBvYnNlcnZhdGlvbnMgSSBoYXZlIG1hZGU6DQotIFdoZW5ldmVyIHRoZSBpc3N1
ZSBvY2N1cnMsIGF0IGxlYXN0IG9uZSB0aHJlYWQgd2FzIGluIHRoZSBzeXN0ZW0gY2FsbCAiY2xv
bmUiIC0gZWl0aGVyIGNhbGxlZCBieSBwdGhyZWFkX2NyZWF0ZSgpIA0Kb3IgYnkgc3lzdGVtKCku
IEkgZ290IHRoaXMgaW5mb3JtYXRpb24gYnkgY2FsbGluZyAiaW5mbyB0aHIiIGluc2lkZSBnZGIu
DQotIEkgcmVtb3ZlZCB0aGUgY2FsbHMgdG8gcHRocmVhZF9zZXRzY2hlZHBhcmFtKCkgdG8gYXZv
aWQgcnVubmluZyB0aGUgdGhyZWFkcyBpbiBTQ0hFRF9GSUZPIHNjaGVkdWxpbmcuDQpFdmVuIHRo
ZXJlIEkgZ290IHRoZSBpc3N1ZS4gSXQgc2VlbXMgbm90IHRvIGJlIHJlbGF0ZWQgdG8gdGhyZWFk
cyBydW5uaW5nIGluIHJlYWwgdGltZSBwcmlvcml0eS4NCg0KTXkgdG9vbGluZyAoRGViaWFuIHRl
c3Rpbmcvc3RyZXRjaCk6DQpnZGIgNy4xMg0KZ2NjIDYuMi4xDQoNClJlZ2FyZHMNCg0KTWF0aGlh
cw0K
