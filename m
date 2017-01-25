From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Wed, 25 Jan 2017 13:36:27 +0000
Message-ID: <d3906c1c79be47b1889d19e23048ecf7@FE-MBX1012.de.bosch.com>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:21249 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdAYNgb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 08:36:31 -0500
In-Reply-To: <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgU2ViYXN0aWFuLA0KPiA+ID4gPiBUaGUga2VybmVsIHZlcnNpb24gNC4xLjM3LXJ0NDMgaXMg
d29ya2luZyBmaW5lLCB0aGUga2VybmVsDQo+ID4gPiA+IHZlcnNpb25zDQo+ID4gPiA+IDQuNC4z
OS1ydDUwIGFuZA0KPiA+ID4gNC44LjExLXJ0NyBzaG93IHRoZSBzYW1lIHN0cmFuZ2UgYmVoYXZp
b3IgYXMgNC45LjAtcnQxLg0KPiA+ID4gPiBTb21ldGhpbmcgb24gdGhlIHdheSBiZXR3ZWVuIDQu
MS4zNy1ydDQzIGFuZCA0LjQuMzktcnQ1MCBzZWVtcyB0bw0KPiA+ID4gPiBjYXVzZSB0aGUNCj4g
PiA+IHRyb3VibGUuDQo+ID4gPg0KPiA+ID4gY2FuIHlvdSBjaGVjayBpZiBvbmUgb2YgdGhlIGVh
cmxpZXIgdjQuNC1SVCByZWxlYXNlcyAobWF5YmUgc3RhcnQNCj4gPiA+IHdpdGgNCj4gPiA+IC1y
dDIgb3IgLXJ0MSkgYWxzbyBzaG93cyB0aGlzIGJlaGF2aW91cj8NCj4gPiA+IElmIG5vdCwgd291
bGQgeW91IGhhdmUgYSB0ZXN0Y2FzZT8NCj4gPiBJIHRlc3RlZCB3aXRoIDQuNC4wLXJ0Mi4NCj4g
PiBIZXJlIHRoaXMgaXNzdWUgb2NjdXJzIHZlcnkgcmFyZWx5LiBJIHJhbiB0aGUgZ2RiIGZvciBh
Ym91dCAzMCB0aW1lcywNCj4gPiBhbmQgaGVyZSBJIGdvdCBvbmUgaGl0Lg0KPiA+IFdpdGggdGhl
IG90aGVyIGtlcm5lbCB2ZXJzaW9ucyBJIGdvdCB0aGUgaXNzdWUgaW4gMjAtNDAlIG9mIHRoZSBj
YXNlcy4NCj4gPg0KPiA+IEkgd2lsbCB0cnkgb3V0IHRoZSBvdGhlciA0LjQuMCByZWxlYXNlcy4u
Lg0KPiANCj4gSSByYW4gbW9yZSB0ZXN0cy4gVGhlIGtlcm5lbCA0LjQuMS1ydDQgaXMgd29ya2lu
ZyBmYWlybHkgZmluZSAob25seSBhYm91dCBvbmUgaGl0IGV2ZXJ5DQo+IDMwIHJ1bnMpIGJ1dCB0
aGUga2VybmVsIDQuNC4xLXJ0NSBpcyBjYXVzaW5nIHRoZSBpc3N1ZSB2ZXJ5IG9mdGVuLg0KPiAN
ClVwZGF0ZToNCkkgcmVtb3ZlZCB0aGUgcGF0Y2ggImtlcm5lbC1wZXJmLW1hcmstcGVyZl9jcHVf
Y29udGV4dC1zLXRpbWVyLWFzLWlycXNhZmUucGF0Y2giIGZyb20gdGhlIDQuNC4xLXJ0NSBzZXJp
ZXMuDQpUaGlzIGltcHJvdmVkIHRoZSBzaXR1YXRpb24uIE5vIEkgZ290IHRoZSBpc3N1ZSBhYm91
dCBpbiA1LTEwJSBvZiB0aGUgcnVucy4NCg0KDQpXaXRoIDQuOS40LXJ0MiBJIHRyaWVkIHRvIHJl
bW92ZSB0aGUgc2FtZSBhc3NpZ25tZW50IChhcyBwYXJ0IG9mIHRoaXMgdmVyeSBwYXRjaCkgaW4g
a2VybmVsL2V2ZW50cy9jb3JlLmM6DQp0aW1lci0+aXJxc2FmZSA9IDE7DQpIb3dldmVyIHRoaXMg
ZGlkIG5vdCBzaG93IGFueSBtYWpvciBpbXByb3ZlbWVudC4uLiANCkl0IGxvb2tzIGFzIHRoaXMg
bm90IHRoZSBpc3N1ZSBhbG9uZS4gSG93ZXZlciBpdCBtaWdodCBiZSBhbiBpbmRpY2F0aW9uIHdo
ZXJlIHRoZSBpc3N1ZSBpcyBjYXVzZWQgZnJvbS4NCg0KUmVnYXJkcw0KDQpNYXRoaWFzDQo=
