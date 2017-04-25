From: "Koehrer Mathias (ETAS/ESW3)" <mathias.koehrer@etas.com>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Tue, 25 Apr 2017 06:06:00 +0000
Message-ID: <fde43c84103d4dd48a4a09368fffc4eb@FE-MBX1012.de.bosch.com>
References: <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
 <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
 <ef2c680e3ed541c4b0df5e0715ca8264@FE-MBX1012.de.bosch.com>
 <3c9395f9c6b944978c1f420276bde0ee@FE-MBX1012.de.bosch.com>
 <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
 <20170302175155.rymagis536dnw5nh@linutronix.de>
 <d831bc9a2939474f8b8290905f393088@FE-MBX1012.de.bosch.com>
 <20170307232151.7macprg6qnl3exbh@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D9B5C8530@S1P5DAG10E.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: David Hauck <davidh@netacquire.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:46802 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980492AbdDYGGC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Apr 2017 02:06:02 -0400
In-Reply-To: <FCC5AC80E299464B82E1345E2C10FC9D9B5C8530@S1P5DAG10E.EXCHPROD.USA.NET>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgRGF2aWQNCj4gSSB3YW50ZWQgdG8gZm9sbG93LXVwIG9uIHRoaXMgdGhyZWFkIHNpbmNlIHdl
LCB0b28sIGFyZSBzZWVpbmcgaXNzdWVzIHdpdGggR0RCIGFuZA0KPiB2NC45LXJ0IGtlcm5lbHMu
IFdlJ3ZlIGJlZW4gd29ya2luZyBvbiB1cGdyYWRpbmcgb3VyIHN5c3RlbXMvYXBwbGljYXRpb24g
ZnJvbSB0aGUNCj4gdjMuMTgtcnQga2VybmVsIHNlcmllcyAoc3BlY2lmaWNhbGx5IHYzLjE4Li4y
OS1ydDMwKSB0byB2NC45LXJ0IChzcGVjaWZpY2FsbHkgNC45LjEzLXJ0MTEpDQo+IGFuZCBpbW1l
ZGlhdGVseSBzdGFydGVkIGV4cGVyaWVuY2luZyB2YXJpb3VzIEdEQiByZWxhdGVkIGlzc3Vlcy4g
VGhlIGZpcnN0IChpbmFiaWxpdHkNCj4gdG8gcGF1c2UgYXQgYnJlYWtwb2ludHMgYW5kIHNpbmds
ZS1zdGVwKSB3YXMgZWxpbWluYXRlZCBieSByZXZlcnRpbmcgdG8gdXNpbmcgR0RCDQo+IHY3LjEx
LjEgKGZyb20gR0RCIHY3LjEyLjEpLiBIb3dldmVyLCB0aGUgc2Vjb25kICh0aGUgU0lHU1RPUCBp
c3N1ZSBvcmlnaW5hbGx5DQo+IHJlcG9ydGVkIGJ5IE1hdGhpYXMpIGlzbid0IHNvbWV0aGluZyB3
ZSd2ZSBiZWVuIGFibGUgdG8gd29yayBhcm91bmQuIEhhdmUgZWl0aGVyIG9mDQo+IHlvdSBtYWRl
IGFueSBvZiB5b3VyIG93biBwcm9ncmVzcyBvbiB0aGlzIGlzc3VlPyBBcmUgb3RoZXJzIGFsc28g
c2VlaW5nIHRoaXM/DQpObyBwcm9ncmVzcyBmcm9tIG91ciBzaWRlLi4uIFdlIGFyZSBzdGF5aW5n
IG9uIHRoZSAzLjE4IGtlcm5lbCAod2hpY2ggaXMgbm90IHJlYWxseSBmaW5lIA0KYXMgaXQgaXMg
bm93IEVPTC4uLi4pDQoNCkJlc3QgcmVnYXJkcw0KDQpNYXRoaWFzIA0K
