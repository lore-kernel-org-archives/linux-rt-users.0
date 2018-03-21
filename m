Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:39390 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751319AbeCUIbl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Mar 2018 04:31:41 -0400
From: Roosen Henri <Henri.Roosen@ginzinger.com>
Subject: Re: inconsistent lock state on v4.14.20-rt17
Date: Wed, 21 Mar 2018 08:31:31 +0000
Message-ID: <1521621090.2390.1.camel@ginzinger.com>
References: <1520350053.1744.6.camel@ginzinger.com>
         <20180306182154.nkia5hl4r3r2ncru@linutronix.de>
         <1520411200.1744.11.camel@ginzinger.com>
         <20180308155741.vbdqprs6stx5zu4q@linutronix.de>
         <1520530739.1744.18.camel@ginzinger.com>
         <20180308180025.zdhu3zl24zfkb3qz@linutronix.de>
         <1520588836.1921.2.camel@ginzinger.com>
         <20180314195523.5ndigtyecugodzmg@linutronix.de>
         <20180316103009.6cwjctghuoellcua@linutronix.de>
         <20180317210358.3h66haslmgqcwojs@linutronix.de>
In-Reply-To: <20180317210358.3h66haslmgqcwojs@linutronix.de>
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <2502AD8D6F69CA4B8E313896687BC580@ginzinger.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

DQoNCkhlbnJpIFJvb3NlbiB8IEVudHdpY2tsdW5nIFNvZnR3YXJlDQoNCkdJTlpJTkdFUiBFTEVD
VFJPTklDIFNZU1RFTVMgR01CSA0KDQpUZWwuOiArNDMgNzcyMyA1NDIyIDE2MQ0KTWFpbDogaGVu
cmkucm9vc2VuQGdpbnppbmdlci5jb20NCldlYjogd3d3Lmdpbnppbmdlci5jb20NCg0KDQoNCg0K
T24gU2F0LCAyMDE4LTAzLTE3IGF0IDIyOjAzICswMTAwLCBiaWdlYXN5QGxpbnV0cm9uaXguZGUg
d3JvdGU6DQo+IE9uIDIwMTgtMDMtMTYgMTE6MzA6MDkgWyswMTAwXSwgVG8gUm9vc2VuIEhlbnJp
IHdyb3RlOg0KPiA+IE9uIDIwMTgtMDMtMTQgMjA6NTU6MjQgWyswMTAwXSwgVG8gUm9vc2VuIEhl
bnJpIHdyb3RlOg0KPiA+ID4gVGhpcyBzdXJ2aXZlZCA2IGRheXMuIEl0IHdhcyBjaGFsbGVuZ2lu
ZyB0byBjYW5jZWwgaGFja2JlbmNoDQo+ID4gPiBiZWNhdXNlIGl0DQo+ID4gPiB3YXMgcnVubmlu
ZyB2aWEgc3NoIGluIGEgc2NyZWVuIHNlc3Npb24gYW5kIEkgd2FzIGxvb3NpbmcgbXkNCj4gPiA+
IG5ldHdvcmsNCj4gPiA+IGNvbm5lY3Rpb24gZHVlIHRvIGluYWN0aXZpdHnigKYNCj4gPg0KPiA+
IG9rYXkuIEl0IG1heSBoYXZlIHN1cnZpdmVkIGJ1dCBpdCBtYW5hZ2VkIHRvIHRyaWdnZXIgdGhp
cy4gVHJ5aW5nDQo+ID4gdG8NCj4gPiBtYWtlIHNlbnNlIHRvIHRoaXPigKYNCj4NCj4gU28gYWZ0
ZXIgSSB0cmFjZWQgaXQgZG93biBJIGZpZ3VyZWQgb3V0IHRoYXQgeW91IG5lZWQNCj4gICA2YjBl
ZjkyZmVlMmEgKCJydG11dGV4OiBNYWtlIHJ0X211dGV4X2Z1dGV4X3VubG9jaygpIHNhZmUgZm9y
IGlycS0NCj4gb2ZmIGNhbGxzaXRlcyIpDQo+ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy90aXAv
NmIwZWY5MmZlZTJhDQo+DQoNClNvcnJ5IGZvciBub3QgYmVpbmcgYWJsZSB0byByZXBseSBlYXJs
aWVyLCBJIHdhcyBvbiBhIHNob3J0IGhvbGlkYXkuDQpUaGFua3MgZm9yIGZpZ3VyaW5nIG91dCB0
aGUgZml4ISBJIG5vdGljZWQgeW91IHJlbGVhc2VkIHY0LjE0LjI4LXJ0MjMNCndoaWNoIGluY2x1
ZGVzIHRoZSBwYXRjaC4gSSB3aWxsIGdpdmUgdGhhdCB2ZXJzaW9uIGEgdGVzdCBvbiBvdXINCnN5
c3RlbXMuDQoNCkFzIHRoZSBpbmNvbnNpc3RlbnQgbG9jayBzdGF0ZSBpc3N1ZSB3YXMgaW50cm9k
dWNlZCBvbmx5IGluIHY0LjE0LCB0aGlzDQp3aWxsIG5vdCBiZSB0aGUgaXNzdWUgd2UndmUgc2Vl
biBvbiB2NC45LiBIb3dldmVyLCB0aGF0IG1pZ2h0IGhhdmUgYmVlbg0KZml4ZWQgYWxvbmcgdGhl
IHdheSB0byB2NC4xNC4uLiBJIHdpbGwga2VlcCB5b3UgcG9zdGVkIG9uIHRoZSBvdXRjb21lLg0K
DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gSGVucmkNCj4NCj4gU2ViYXN0aWFuDQoNClRoYW5r
cywNCkhlbnJpDQoNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQoNCkdpbnppbmdlciBlbGVjdHJvbmljIHN5c3RlbXMgR21iSA0KR2V3ZXJiZWdlYmlldCBQaXJh
dGggMTYNCjQ5NTIgV2VuZyBpbSBJbm5rcmVpcw0Kd3d3Lmdpbnppbmdlci5jb20NCg0KRmlybWVu
YnVjaG51bW1lcjogRk4gMzY0OTU4ZA0KRmlybWVuYnVjaGdlcmljaHQ6IFJpZWQgaW0gSW5ua3Jl
aXMNClVJRC1Oci46IEFUVTY2NTIxMDg5DQoNCg==
