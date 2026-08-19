Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E68440639
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Aug 2026 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172537; cv=none; b=AMlTgcDxFCr4g+eJ96utLpDPRoxkRDWavPybdhhEopKZ6uYNutrByZZKq0/eugJXkly/HBZ22vnE/Dn6zV89ff/r2JcOfantL0J9MpwLpVXOHisIlmZq5dWgSAUx41jGwBOhydeuN5X7naPssEVmaf5yoYecPw7S1vSicHzDfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172537; c=relaxed/simple;
	bh=dAdKQccPCQAP9MOtrC6DWLMXAGOG5D+EGON3i1vV2MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lnBxyE1NYbiGMKcdzxLn7qvD941cAhQw5ShCbc6s+YZtETEvM5gO6h35St14ZwoeaA9SEQahneqjdNmklfYRNuY9bJ0WXv3prsQ8O+/YCtZYDUkJo4RnE/dZQ/6ykH9CDWPEu5Wzw/zabkBG+NQ9H2SLBqX4seDkmqxzbwuMkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=UTuNQe/j; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UTuNQe/j"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DCFAB2C0E0C;
	Thu, 20 Aug 2026 08:48:51 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1787172531;
	bh=dAdKQccPCQAP9MOtrC6DWLMXAGOG5D+EGON3i1vV2MQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UTuNQe/jDFYFaZD4vD1EtMpIoDFNd9gkxocpkN+pW+bRnV65O5Rb/8Q1ePowslZGQ
	 oiVrmwrohQ4qhn6IFNRg5U73pxABXmX6e0WnI07YpSVrj2eAse15JIoRvDPhTJkaCp
	 3oBwbNimKBZtOX7qhuaad/4ELDDpW7xGQaZbMvhhd770QxIfUmkZUMcZPm7w8B1L3E
	 4/drhtCa6bJhI3oO9Z2x3kTAJkdB3ixFv7ICRZrvr8ejA7LOlgB/NQbUdK/uGqHYOS
	 KcenHR81V5amFLJIMDaEyZ3suwI9aJULaa3mjTiYpvshG4i/DNBuRQ6PSWb9P0jEW9
	 x5es6qPSHMJ8A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a8616b30001>; Thu, 20 Aug 2026 08:48:51 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 20 Aug 2026 08:48:51 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Thu, 20 Aug 2026 08:48:51 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Mike Schanne
	<mschanne@kns.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, LKML
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, linux-rt-users
	<linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Thread-Topic: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Thread-Index: Ad0v6ySl1n2AMDDLRcmW3l5JdKXWrv//ORaAgABfvoA=
Date: Wed, 19 Aug 2026 20:48:51 +0000
Message-ID: <5943e7e5-9578-42a1-b693-d79f9eef88f0@alliedtelesis.co.nz>
References: <TY0PR0101MB48672132B8525B7B39565EE4D2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>
 <20260819150611.xWELTqJ-@linutronix.de>
In-Reply-To: <20260819150611.xWELTqJ-@linutronix.de>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AC6F45753F60448919ADE1460C724DC@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CKmJXgrD c=1 sm=1 tr=0 ts=6a8616b3 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VwQbUJbxAAAA:8 a=UlNkbvKAAAAA:8 a=lriMMl8CF1PGcbrYiv0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=geFFMbpNSZSG5jv3XVn1:22
X-SEG-SpamProfiler-Score: 0

SGkgU2ViYXN0aWFuLA0KDQpPbiAyMC8wOC8yMDI2IDAzOjA2LCBTZWJhc3RpYW4gQW5kcnplaiBT
aWV3aW9yIHdyb3RlOg0KPiBDaHJpcywgd2hhdCB3YXMgdGhlIHVzZSBjYXNlIHRvIHNwbGl0IHRo
aXM/DQoNCkkgd2FzIGRlYWxpbmcgd2l0aCBoYXZpbmcgYSBVSU8gaW50ZXJydXB0IGZvciBhbiBp
bnB1dCBvbiBhIFBDQTk1MzkuIA0KVGhlcmUncyBzb21lIG1vcmUgaW5mbyBvbiB0aGUgb3JpZ2lu
YWwgZW1haWwgdGhyZWFkWzFdIGJ1dCBiYXNpY2FsbHkgDQpiZWNhdXNlIHRoZSBQQ0E5NTM5IGlu
cHV0cyBhcmUgbmVzdGVkIF9fc2V0dXBfaXJxKCkgZW5mb3JjZXMgdGhhdCBhbnlvbmUgDQpyZXF1
ZXN0aW5nIHRoZW0gZG9lcyBzbyB3aXRoIGEgdGhyZWFkZWQgaW50ZXJydXB0Lg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0MDgyMzQwNTAuMjA1NjM3NC0zLWNocmlzLnBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uei8NCg0KPg0KPiBPbiAyMDI2LTA4LTE5IDE1OjAxOjAwIFsr
MDAwMF0sIE1pa2UgU2NoYW5uZSB3cm90ZToNCj4+IENvbW1pdCBmOGEyN2RmYTRiODJkNDQyYWYx
YzA2NDVhNWFjYzcwY2M5N2M2N2Y2ICgidWlvOiB1c2UgdGhyZWFkZWQNCj4+IGludGVycnVwdHMi
KSBtYWtlcyBhbGwgdWlvIGludGVycnVwdHMgdGhyZWFkZWQgYnkgZGVmYXVsdC4gIEhvd2V2ZXIN
Cj4+IHVuZGVyIENPTkZJR19QUkVFTVBUX1JULCBhbGwgaW50ZXJydXB0cyBhcmUgYWxyZWFkeSB0
aHJlYWRlZC4gIFRoaXMNCj4+IHJlc3VsdHMgaW4gMiBpcnEgdGhyZWFkcyBwZXIgdWlvIGluc3Rh
bmNlLCBhZGRpbmcgYW4gdW5uZWNlc3NhcnkNCj4+IGV4dHJhIGNvbnRleHQgc3dpdGNoIHBlciBp
bnRlcnJ1cHQuDQo+Pg0KPj4gRG8gbm90IHJlcXVlc3QgYSB0aHJlYWRlZCBpbnRlcnJ1cHQgZm9y
IHVpbyB1bmRlciBDT05GSUdfUFJFRU1QVF9SVA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgU2NoYW5uZSBtc2NoYW5uZUBrbnMuY29tPG1haWx0bzptc2NoYW5uZUBrbnMuY29tPg0KPj4g
LS0tDQo+PiBkcml2ZXJzL3Vpby91aW8uYyB8IDE3ICsrKysrKysrKysrKystLS0tDQo+PiAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvLmMgYi9kcml2ZXJzL3Vpby91aW8uYw0KPj4gaW5kZXgg
MDA0YTU0OWM2Li40ZTI4Nzc3YWMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3Vpby91aW8uYw0K
Pj4gKysrIGIvZHJpdmVycy91aW8vdWlvLmMNCj4+IEBAIC00NDgsOCArNDQ4LDEyIEBAIHN0YXRp
YyBpcnFyZXR1cm5fdCB1aW9faW50ZXJydXB0X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2X2lk
KQ0KPj4gICAgICAgICAgICAgICAgIGlycXJldHVybl90IHJldDsNCj4+ICAgICAgICAgICAgICAg
ICAgcmV0ID0gaWRldi0+aW5mby0+aGFuZGxlcihpcnEsIGlkZXYtPmluZm8pOw0KPj4gLSAgICAg
ICAgICAgICAgaWYgKHJldCA9PSBJUlFfSEFORExFRCkNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZXQgPSBJUlFfV0FLRV9USFJFQUQ7DQo+PiArICAgICAgICAgICAgIGlmIChy
ZXQgPT0gSVJRX0hBTkRMRUQpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChJU19FTkFCTEVEKENPTkZJR19QUkVFTVBUX1JUKSkNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW9fZXZlbnRfbm90aWZ5KGlkZXYtPmluZm8pOw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IElSUV9XQUtFX1RIUkVBRDsNCj4+
ICsgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gfQ0K
Pj4gQEAgLTEwMzgsOCArMTA0MiwxMyBAQCBpbnQgX191aW9fcmVnaXN0ZXJfZGV2aWNlKHN0cnVj
dCBtb2R1bGUgKm93bmVyLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBG
RHMgYXQgdGhlIHRpbWUgb2YgdW5yZWdpc3RlciBhbmQgdGhlcmVmb3JlIG1heSBub3QgYmUNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogZnJlZWQgdW50aWwgdGhleSBhcmUg
cmVsZWFzZWQuDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJlcXVlc3RfdGhyZWFkZWRfaXJxKGlu
Zm8tPmlycSwgdWlvX2ludGVycnVwdF9oYW5kbGVyLCB1aW9faW50ZXJydXB0X3RocmVhZCwNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5pcnFfZmxhZ3MsIGluZm8tPm5hbWUsIGlk
ZXYpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKElTX0VOQUJMRUQoQ09O
RklHX1BSRUVNUFRfUlQpKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gcmVxdWVzdF9pcnEoaW5mby0+aXJxLCB1aW9faW50ZXJydXB0X2hh
bmRsZXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGluZm8tPmlycV9mbGFncywgaW5mby0+bmFtZSwgaWRldik7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJlcXVlc3RfdGhyZWFkZWRfaXJx
KGluZm8tPmlycSwgdWlvX2ludGVycnVwdF9oYW5kbGVyLCB1aW9faW50ZXJydXB0X3RocmVhZCwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5mby0+aXJxX2ZsYWdzLCBpbmZvLT5uYW1lLCBpZGV2KTsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKHJldCkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5mby0+dWlvX2RldiA9IE5VTEw7DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9yZXF1ZXN0X2lycTsNCj4gU2ViYXN0
aWFu
