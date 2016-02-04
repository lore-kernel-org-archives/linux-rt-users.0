From: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Subject: lock/reserve 2nd level cache for rt tasks
Date: Thu, 4 Feb 2016 07:31:09 +0000
Message-ID: <7c5e452e40b6426eaf16d37927f527cb@DE01EX11.GLOBAL.JHCN.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx02.jhcn.net ([194.25.102.130]:48682 "EHLO mx02.jhcn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbcBDHnh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Feb 2016 02:43:37 -0500
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGVsbG8sCgpvbiBteSBxdWFkIGNvcmUgY3B1IChpbnRlbCBpNykgdGhlIHgxMXZuYyAoc2VydmVy
KSBzbG93cyBkb3duIAp0aGUgcnQtdGFzayAoaXQgdG9vayB1cCB0byA1IHRpbWVzIGxvbmdlciks
IGV2ZW4gaWYgSSBib3VuZCAKdGhlIHgxMXZuYyB0byBhbm90aGVyIGNvcmUgdGhhbiB0aGUgcnQt
dGFzayB2aWEgdGFza3NldC4gCgpJIGd1ZXNzZWQgdGhhdCB0aGUgeDExdm5jIGludmFsaWRhdGVz
IDJuZCBhbmQvb3IgM3JkIGxldmVsLgoKSXMgdGhlcmUgYW55IHdheSB0byByZXNlcnZlIGNwdSBj
YWNoZSB0byBhIHNwZWNpZmllZCB0YXNrIApvciB0byBhIHNwZWNpZmllZCBjb3JlPwoKVGhhbmtz
IGZvciBhbnkgaWRlYS4KCkFuZHJlYXMKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KUmVnaXN0ZXJnZXJpY2h0OiBUcmF1bnN0ZWluIC8gUmVnaXN0cnkgQ291
cnQ6IEhSQiAyNzUgLSBTaXR6IC8gSGVhZCBPZmZpY2U6IFRyYXVucmV1dApBdWZzaWNodHNyYXRz
dm9yc2l0emVuZGVyIC8gQ2hhaXJtYW4gb2YgU3VwZXJ2aXNvcnkgQm9hcmQ6IFJhaW5lciBCdXJr
aGFyZApHZXNjaMOkZnRzZsO8aHJ1bmcgLyBNYW5hZ2VtZW50IEJvYXJkOiBUaG9tYXMgU2Vzc2Vs
bWFubiAoVm9yc2l0emVuZGVyIC8gQ2hhaXJtYW4pLApNaWNoYWVsIEdyaW1tLCBIdWJlcnQgRXJt
ZXIsIEx1dHogUmlzc2luZwoKRS1NYWlsIEhhZnR1bmdzYXVzc2NobHVzcyAvIEUtTWFpbCBEaXNj
bGFpbWVyOiBodHRwOi8vd3d3LmhlaWRlbmhhaW4uZGUvZGlzY2xhaW1lcgo=

