From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: unable to handle kernel NULL pointer dereference on 3.18.13-rt10
Date: Wed, 22 Jul 2015 06:26:42 +0000
Message-ID: <b4572ce5932444febd055f1403c58d9e@FE-MBX1012.de.bosch.com>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
 <alpine.DEB.2.11.1507091605410.5134@nanos>
 <c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
 <20150710132318.GA27402@linutronix.de>
 <e1b9f04b95504df78cab1eb4e6946238@FE-MBX1012.de.bosch.com>
 <55A36EF0.7020404@linutronix.de>
 <15fcff88e0b4417aba7fd635a98b1ad0@FE-MBX1012.de.bosch.com>
 <55A37DC9.6050604@linutronix.de> <55A607CC.3030808@etas.com>
 <12C1B74BDFD05D40B2356A9B12DFA3396C276FDBA2@KEBMXSPMB01.keba.co.at>
 <20150720145648.GA9559@linutronix.de>
 <12C1B74BDFD05D40B2356A9B12DFA3396C27797F4A@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>
To: eg Engleder Gerhard <eg@keba.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:43860 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbbGVG0p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 02:26:45 -0400
In-Reply-To: <12C1B74BDFD05D40B2356A9B12DFA3396C27797F4A@KEBMXSPMB01.keba.co.at>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgYWxsLA0KPiA+ID5zaW1pbGFyIHNpdHVhdGlvbiBoZXJlIHdpdGggMy4xOC4xMS1ydDcuIFRo
ZSBwcm9ibGVtIG9jY3VycmVkIG9uY2Ugc28gZmFyLg0KPiA+DQo+ID4gSXMgdGhpcyBfd2l0aF8g
b3IgX3dpdGhvdXRfIHRoZSBwYXRjaCBpbiBxdWVzdGlvbj8NCj4gDQo+IFdpdGggdGhlIHBhdGNo
LiBzbHViX2RlbGF5X2N0b3Jfb25fcnQucGF0Y2ggaXMgYXBwbGllZC4gSXQgaXMgMy4xOC4xMS1y
dDcgd2l0aA0KPiBhZGRpdGlvbmFsIGRyaXZlcnMNCj4gZm9yIG91ciBoYXJkd2FyZS4NCg0KU2lu
Y2UgSSBoYXZlIHJlbW92ZWQgdGhlIHNsdWJfZGVsYXlfY3Rvcl9vbl9ydC5wYXRjaCBmcm9tIDMu
MTguMTMtcnQxMCBJIGhhdmUgbmV2ZXIgc2VlbiB0aGlzIGlzc3VlIGFueW1vcmUgb24gb3VyIHN5
c3RlbXMuDQoNCk5vdyBJIGhhZCBhIGxvb2sgYXQgdGhlIGxhdGVzdCAzLjE4LjE3LXJ0MTQ6IEhl
cmUgSSBkbyBub3Qgc2VlIHRoYXQgcGF0Y2ggYW55bW9yZS4NCkhhcyBpdCBiZWVuIHJlbW92ZWQg
ZnJvbSB0aGUgcGF0Y2hzZXQ/IA0KSXMgdGhlcmUgc3RpbGwgYSBuZWVkIHRvIGlnbm9yZSBvbmUg
b2YgdGhlIHBhdGNoZXM/DQpOZWl0aGVyIGluIHRoZSBhbm5vdW5jZW1lbnQgdG8gMy4xOC4xNi1y
dDEzIG5vciB0byAzLjE4LjE3LXJ0MTQgSSByZWFkIGFueSBjb21tZW50IG9uIHRoYXQuDQoNClJl
Z2FyZHMNCg0KTWF0aGlhcw0K
