From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Wed, 25 Jan 2017 14:00:21 +0000
Message-ID: <ef2c680e3ed541c4b0df5e0715ca8264@FE-MBX1012.de.bosch.com>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
 <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:22166 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdAYOAY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 09:00:24 -0500
In-Reply-To: <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgU2ViYXN0aWFuLA0KDQo+ID4gPiA+ID4gVGhlIGtlcm5lbCB2ZXJzaW9uIDQuMS4zNy1ydDQz
IGlzIHdvcmtpbmcgZmluZSwgdGhlIGtlcm5lbA0KPiA+ID4gPiA+IHZlcnNpb25zDQo+ID4gPiA+
ID4gNC40LjM5LXJ0NTAgYW5kDQo+ID4gPiA+IDQuOC4xMS1ydDcgc2hvdyB0aGUgc2FtZSBzdHJh
bmdlIGJlaGF2aW9yIGFzIDQuOS4wLXJ0MS4NCj4gPiA+ID4gPiBTb21ldGhpbmcgb24gdGhlIHdh
eSBiZXR3ZWVuIDQuMS4zNy1ydDQzIGFuZCA0LjQuMzktcnQ1MCBzZWVtcw0KPiA+ID4gPiA+IHRv
IGNhdXNlIHRoZQ0KPiA+ID4gPiB0cm91YmxlLg0KPiA+ID4gPg0KPiA+ID4gPiBjYW4geW91IGNo
ZWNrIGlmIG9uZSBvZiB0aGUgZWFybGllciB2NC40LVJUIHJlbGVhc2VzIChtYXliZSBzdGFydA0K
PiA+ID4gPiB3aXRoDQo+ID4gPiA+IC1ydDIgb3IgLXJ0MSkgYWxzbyBzaG93cyB0aGlzIGJlaGF2
aW91cj8NCj4gPiA+ID4gSWYgbm90LCB3b3VsZCB5b3UgaGF2ZSBhIHRlc3RjYXNlPw0KPiA+ID4g
SSB0ZXN0ZWQgd2l0aCA0LjQuMC1ydDIuDQo+ID4gPiBIZXJlIHRoaXMgaXNzdWUgb2NjdXJzIHZl
cnkgcmFyZWx5LiBJIHJhbiB0aGUgZ2RiIGZvciBhYm91dCAzMA0KPiA+ID4gdGltZXMsIGFuZCBo
ZXJlIEkgZ290IG9uZSBoaXQuDQo+ID4gPiBXaXRoIHRoZSBvdGhlciBrZXJuZWwgdmVyc2lvbnMg
SSBnb3QgdGhlIGlzc3VlIGluIDIwLTQwJSBvZiB0aGUgY2FzZXMuDQo+ID4gPg0KPiA+ID4gSSB3
aWxsIHRyeSBvdXQgdGhlIG90aGVyIDQuNC4wIHJlbGVhc2VzLi4uDQo+ID4NCj4gPiBJIHJhbiBt
b3JlIHRlc3RzLiBUaGUga2VybmVsIDQuNC4xLXJ0NCBpcyB3b3JraW5nIGZhaXJseSBmaW5lIChv
bmx5DQo+ID4gYWJvdXQgb25lIGhpdCBldmVyeSAzMCBydW5zKSBidXQgdGhlIGtlcm5lbCA0LjQu
MS1ydDUgaXMgY2F1c2luZyB0aGUgaXNzdWUgdmVyeQ0KPiBvZnRlbi4NCj4gDQo+IGFuZCA0LjEu
MzctcnQ0MyBzaG93cyBub3QgU0lHU1RPUFMgaW4gMTAwIHJ1bnM/DQpUaGF0J3MgcmlnaHQuDQpJ
IHVzZWQgNC4xLjM3LXJ0NDMgYW5kIHJhbiB0aGUgdGVzdCBmb3IgMjAwIHRpbWVzLiBUaGVyZSB3
YXMgbm8gc2luZ2xlIGlzc3VlLg0KDQpSZWdhcmRzDQoNCk1hdGhpYXMNCg0KDQo=
