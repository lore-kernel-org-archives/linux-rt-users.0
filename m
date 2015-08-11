From: "Jiang, Yunhong" <yunhong.jiang@intel.com>
Subject: RE: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Tue, 11 Aug 2015 23:21:16 +0000
Message-ID: <DDCAE26804250545B9934A2056554AA020AA0768@ORSMSX112.amr.corp.intel.com>
References: <20150317163541.080310081@goodmis.org>
 <20150317163617.218582800@goodmis.org>
 <20150317163551.3093b6c2@gandalf.local.home>
 <1426753029.4168.80.camel@gmail.com>
 <20150319122611.0d002d48@gandalf.local.home>
 <20150324181034.GD1321@linutronix.de> <1427250833.3459.4.camel@gmail.com>
 <20150409133916.GA2416@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58711 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbbHKXVR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Aug 2015 19:21:17 -0400
In-Reply-To: <20150409133916.GA2416@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGksIGFsbA0KCUp1c3Qgd2FudCB0byBjaGVjayBpZiBhbnlvbmUgaXMgd29ya2luZyB0byBicmlu
ZyB0aGUgInRpbWVyczogZG8gbm90IHJhaXNlIHNvZnRpcnEgdW5jb25kaXRpb25hbGx5IiBiYWNr
PyBTZWVtcyBpdCdzIG5vdCBpbiB0aGUgNC4xLjMtcnQgeWV0Lg0KDQpUaGFua3MNCi0tanloDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtcnQtdXNlcnMtb3du
ZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtcnQtdXNlcnMtDQo+IG93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3INCj4gU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDksIDIwMTUgNjozOSBBTQ0KPiBUbzogTWlrZSBHYWxicmFpdGgN
Cj4gQ2M6IFN0ZXZlbiBSb3N0ZWR0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1ydC11c2VyczsgVGhvbWFzDQo+IEdsZWl4bmVyOyBDYXJzdGVuIEVtZGU7IEpvaG4gS2FjdXI7
IEdvcnRtYWtlciwgUGF1bCAoV2luZCBSaXZlcikNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSVCAy
LzRdIFJldmVydCAidGltZXJzOiBkbyBub3QgcmFpc2Ugc29mdGlycQ0KPiB1bmNvbmRpdGlvbmFs
bHkiDQo+IA0KPiAqIE1pa2UgR2FsYnJhaXRoIHwgMjAxNS0wMy0yNSAwMzozMzo1MyBbKzAxMDBd
Og0KPiANCj4gPk5haCwgSSB3YXMgcmVmZXJyaW5nIHRvIGdldF9uZXh0X3RpbWVyX2ludGVycnVw
dCgpIGJlY2F1c2UgSSBzYXcgdGhhdA0KPiA+cnRfc3Bpbl91bmxvY2tfYWZ0ZXJfdHJ5bG9ja19p
bl9pcnEoJmJhc2UtPmxvY2spIHNpdHRpbmcgdGhlcmUuDQo+IA0KPiBIbW0uIEdvb2QgcXVlc3Rp
b24uIEJ1dCBpdCB3YXMgSW5nbyB3aG8gaW50cm9kdWNlZCB0aGUgbG9jaywgc28gaXQgbWlnaHQN
Cj4gaGF2ZSBzcGVjaWFsIEluZ28gbWFnaWMgaW5jbHVkZWQuDQo+IA0KPiA+CS1NaWtlDQo+IA0K
PiBTZWJhc3RpYW4NCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQg
dGhlIGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LXJ0LXVzZXJzIiBpbg0KPiB0aGUgYm9keSBvZiBh
IG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZw0KPiBNb3JlIG1ham9yZG9tbyBp
bmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
