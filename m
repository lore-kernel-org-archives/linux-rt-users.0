From: Clark Williams <williams@redhat.com>
Subject: Re: [patch] irq threading: fix PF_HARDIRQ definition
Date: Thu, 12 Feb 2009 10:50:34 -0600
Message-ID: <20090212105034.586c53d1@torg>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	<20090211205533.329cea1c@torg>
	<20090212083850.GA29995@elte.hu>
	<20090212084222.GA32091@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Cc: Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:40409 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173AbZBLQvY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 11:51:24 -0500
In-Reply-To: <20090212084222.GA32091@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBUaHUs
IDEyIEZlYiAyMDA5IDA5OjQyOjIyICswMTAwDQpJbmdvIE1vbG5hciA8bWluZ29AZWx0ZS5odT4g
d3JvdGU6DQo+IA0KPiBBbnl3YXksIG15IGZpeCBzaG91bGQgc29sdmUgdGhpcy4gRG8geW91IHN0
aWxsIHNlZSB0aGUgbG9ja3VwIHVuZGVyIFg/IChtYWtlDQo+IHN1cmUgeW91IGFsc28gaGF2ZSB0
aGUgSVBJIGZpeCBhcHBsaWVkLCBzZWUgdGhlIHBhdGNoIGluIHRoaXMgc2FtZSB0aHJlYWQuKQ0K
DQpUaGF0IGRpZCBpdCAodGhlIElQSSBwYXRjaCBhbmQgdGhlIHJlZGVmaW5pdGlvbikuIEknbSB1
cCB3aXRoOg0KDQokIHVuYW1lIC1hDQpMaW51eCB0b3JnIDIuNi4yOS1yYzQtcnQxLXRpcCAjNTEg
U01QIFBSRUVNUFQgUlQgVGh1IEZlYiAxMiAwOTo0MDowNg0KQ1NUIDIwMDkgeDg2XzY0IHg4Nl82
NCB4ODZfNjQgR05VL0xpbnV4DQoNClRoYW5rcywgSSdsbCBkbyBzb21lIGxhdGVuY3kgdGVzdGlu
ZyBvbiBteSB0ZXN0IGJveGVzIG5leHQuLi4NCg0KQ2xhcmsNCi0tLS0tQkVHSU4gUEdQIFNJR05B
VFVSRS0tLS0tDQpWZXJzaW9uOiBHbnVQRyB2Mi4wLjEwIChHTlUvTGludXgpDQoNCmlFWUVBUkVD
QUFZRkFrbVVVMmdBQ2drUUh5dWovK1RURXAzYzd3Q2dqblF1WWdvTG1HT21xMjZhMlQxOThlaC8N
CktkZ0Fuam1YK2Nxd3hZQXR6YUhlTUg2L25PNk1OdVVIDQo9TkhoLw0KLS0tLS1FTkQgUEdQIFNJ
R05BVFVSRS0tLS0tDQo=
