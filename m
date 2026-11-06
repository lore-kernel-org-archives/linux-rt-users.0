Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937435;
	b=NvQmE0tyRnZ5uHqtMB8+z0oDs8usiQQTbckn7hBT+32KxFeKuBJaNd1r2oY+GvvI2bUG
	 71Z/nvAjz1MeHgZqC6+8Y14vt+QogrzXhZeP8rY8L0EjjEiAG7j2D6X2yEODlsRmMWUJC
	 WhQ5Hqj6ib1puuyt5VZldTvU2x/OAyEvM6sLYSe6T7aFrJoXdouAdurOjqAV7CZspE6BT
	 95dcjeuyBoy6T4tXXQdoftayxqL4HYtPMZtLBE3a9feVD+NTgPa7SQ+hwmxlovi//Vnie
	 91r/VVhn6DMiW5ttOB2oVVO+COn6nPL0GAqIWad+SoQtaKAseSvTiHncxxwU20H70Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937435;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score;
	bh=OLYVLP7hIHAlNUnk9c8nHGLTclyt/oAp/IPAkfaIHH4=;
	b=XEqiBvFMQLh9efOXLJj3p+IEprdcakfqERCtFVsBmuO2PJICsVW7B7PPrW05Aa8Pz2+t
	 tEwB9J6SB1xCvkbH1CSnSNuubkJBAcbX9h3n/amnBHuyY/XzPcjzGXx/eD8+G3HhZ2v9Z
	 w1oi24VvwMpj6JdHqTOeikWAtjB9Fm2/0vG9DfpBa45KVwib2mbX0+eZu4ZGlryQS+XUb
	 QoRybA0z2cY7eky33veqfDbj62HheuOPVVHKO5rVIYMNO7l9CQF7cWWBcAAuxlJShCh0y
	 vCoFfkfrVLNvXSnDxRWSIW7pLBXe3UwBtcv37a6iHG8vbsonDip1JOyoQsAU34Aui7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b="JR/7UvE1";
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E6606A328
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Nov 2026 03:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74E6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=JR/7UvE1
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 094EF2C0404;
	Fri,  6 Nov 2026 16:57:06 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1793937426;
	bh=OLYVLP7hIHAlNUnk9c8nHGLTclyt/oAp/IPAkfaIHH4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JR/7UvE1oenV19Sv/89AMndwW6bbkzt2Ay5DZ2VzTe2OVK2GtrVvj8iYHpeSMqt9f
	 QDdjyeT0VZlYIfUZmgQw4KK/BznFpYVENrIiYrdM6V6RkVBHHT/zO8J8JylaxZrzbZ
	 EWyXgmlN73jiLiJgGdY/Qy5S6F7/KyX8kmQ6SMtEXGbvoFVHi8E5CkuZ5w6VJdOP6z
	 MlyhySWJFm2lFOYUMkdoJx/D9PkcAYFrjro2mQYj5zi7gApKioEOusonAuTtnAMx+f
	 dpEYxhxRdGgKVROePVDqwQ5jK0O6tsyI6T7xY8RwCoXf6kSMjBiSw5vywHt2bl7w45
	 tHx8CQ621SqSA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6aed50110001>; Fri, 06 Nov 2026 16:57:05 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 16:57:05 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.2562.056; Fri, 6 Nov 2026 16:57:05 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Mike Schanne <mschanne@kns.com>, "'gregkh@linuxfoundation.org'"
	<gregkh@linuxfoundation.org>
CC: 'LKML' <linux-kernel@vger.kernel.org>, "'linux-rt-devel@lists.linux.dev'"
	<linux-rt-devel@lists.linux.dev>, 'linux-rt-users'
	<linux-rt-users@vger.kernel.org>, 'Sebastian Andrzej Siewior'
	<bigeasy@linutronix.de>, 'Thomas Gleixner' <tglx@linutronix.de>, "'Steven
 Rostedt'" <rostedt@goodmis.org>, Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] Revert "uio: use threaded interrupts"
Thread-Topic: [PATCH] Revert "uio: use threaded interrupts"
Thread-Index: Ad1te4Ezu/k/o99STK2OTlNpcneIYv//dNQA
Date: Fri, 6 Nov 2026 03:57:05 +0000
Message-ID: <17b35fd1-13bd-4548-ad7c-5444cbc9a262@alliedtelesis.co.nz>
References: <TY0PR01MB57238A4ACC7B9B3214A00A6CD2772@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR01MB57238A4ACC7B9B3214A00A6CD2772@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FF90EB44285964C87E9C8304CB78B78@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=S4h6w5sP c=1 sm=1 tr=0 ts=6aed5011 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=UlNkbvKAAAAA:8 a=i3znQdv51DuuqUM6O5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=geFFMbpNSZSG5jv3XVn1:22
X-SEG-SpamProfiler-Score: 0

SGkgTWlrZSwNCg0KT24gMDYvMTEvMjAyNiAxMjoyMiwgTWlrZSBTY2hhbm5lIHdyb3RlOg0KPiBU
aGlzIHJldmVydHMgY29tbWl0IGY4YTI3ZGZhNGI4MmQ0NDJhZjFjMDY0NWE1YWNjNzBjYzk3YzY3
ZjYuDQo+DQo+IFRoZSBvcmlnaW5hbCBzb2x1dGlvbiBicmVha3MgdGhlIHRocmVhZGlycXMgY2Fz
ZSBpbmNsdWRpbmcgUFJFRU1QVF9SVA0KPiBVbmRlciBQUkVFTVBUX1JULCBpdCBhZGRzIGFuIGV4
dHJhIGt0aHJlYWQgcGVyIFVJTyBpcnEsDQo+IHdoaWNoIGFkZHMgYSBjb250ZXh0IHN3aXRjaCBw
ZXIgaW50ZXJydXB0Lg0KPg0KPiBTZWU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI0MDMyNjE5NTkyNy4zMjY1Mjk3LTEtY2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56
Lw0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0L2Y4YTI3ZGZhNGI4
MmQ0NDJhZjFjMDY0NWE1YWNjNzBjYzk3YzY3ZjYNCj4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBTY2hhbm5lIDxtc2NoYW5uZUBrbnMuY29tPg0KQWNrZWQtYnk6IENocmlzIFBhY2toYW0gPGNo
cmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCg0KSSdsbCBoYXZlIHRvIGRpZyBvdXQg
dGhlIGJvYXJkIHRoYXQgaGFkIHRoZSBvcmlnaW5hbCBwcm9ibGVtIGFuZCBsb29rIA0KZm9yIGEg
ZGlmZmVyZW50IGZpeC4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL3Vpby91aW8uYyB8IDE5ICsrKysr
LS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWlvL3Vpby5jIGIvZHJpdmVy
cy91aW8vdWlvLmMNCj4gaW5kZXggZjhmYTIwNTIyNjYwLi45ZWY1YjI3NmIwOTAgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdWlvL3Vpby5jDQo+ICsrKyBiL2RyaXZlcnMvdWlvL3Vpby5jDQo+IEBA
IC00NDIsMzAgKzQ0MiwyMSBAQCBFWFBPUlRfU1lNQk9MX0dQTCh1aW9fZXZlbnRfbm90aWZ5KTsN
Cj4gICAgKiBAaXJxOiBJUlEgbnVtYmVyLCBjYW4gYmUgVUlPX0lSUV9DWUNMSUMgZm9yIGN5Y2xp
YyB0aW1lcg0KPiAgICAqIEBkZXZfaWQ6IFBvaW50ZXIgdG8gdGhlIGRldmljZXMgdWlvX2Rldmlj
ZSBzdHJ1Y3R1cmUNCj4gICAgKi8NCj4gLXN0YXRpYyBpcnFyZXR1cm5fdCB1aW9faW50ZXJydXB0
X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiArc3RhdGljIGlycXJldHVybl90IHVp
b19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiAgIHsNCj4gICAgICAgICAgc3Ry
dWN0IHVpb19kZXZpY2UgKmlkZXYgPSAoc3RydWN0IHVpb19kZXZpY2UgKilkZXZfaWQ7DQo+ICAg
ICAgICAgIGlycXJldHVybl90IHJldDsNCj4NCj4gICAgICAgICAgcmV0ID0gaWRldi0+aW5mby0+
aGFuZGxlcihpcnEsIGlkZXYtPmluZm8pOw0KPiAgICAgICAgICBpZiAocmV0ID09IElSUV9IQU5E
TEVEKQ0KPiAtICAgICAgICAgICAgICAgcmV0ID0gSVJRX1dBS0VfVEhSRUFEOw0KPiAtDQo+IC0g
ICAgICAgcmV0dXJuIHJldDsNCj4gLX0NCj4gLQ0KPiAgIC8qKg0KPiAgICAqIHVpb19pbnRlcnJ1
cHRfdGhyZWFkIC0gaXJxIHRocmVhZCBoYW5kbGVyDQo+ICAgICogQGlycTogSVJRIG51bWJlcg0K
PiAgICAqIEBkZXZfaWQ6IFBvaW50ZXIgdG8gdGhlIGRldmljZXMgdWlvX2RldmljZSBzdHJ1Y3R1
cmUNCj4gICAgKi8NCj4gLXN0YXRpYyBpcnFyZXR1cm5fdCB1aW9faW50ZXJydXB0X3RocmVhZChp
bnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+IC17DQo+IC0gICAgICAgc3RydWN0IHVpb19kZXZpY2Ug
KmlkZXYgPSAoc3RydWN0IHVpb19kZXZpY2UgKilkZXZfaWQ7DQo+ICsgICAgICAgICAgICAgICB1
aW9fZXZlbnRfbm90aWZ5KGlkZXYtPmluZm8pOw0KPg0KPiAtICAgICAgIHVpb19ldmVudF9ub3Rp
ZnkoaWRldi0+aW5mbyk7DQo+IC0NCj4gLSAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICsg
ICAgICAgcmV0dXJuIHJldDsNCj4gICB9DQo+DQo+ICAgc3RydWN0IHVpb19saXN0ZW5lciB7DQo+
IEBAIC0xMDQ0LDggKzEwMzUsOCBAQCBpbnQgX191aW9fcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBt
b2R1bGUgKm93bmVyLA0KPiAgICAgICAgICAgICAgICAgICAqIEZEcyBhdCB0aGUgdGltZSBvZiB1
bnJlZ2lzdGVyIGFuZCB0aGVyZWZvcmUgbWF5IG5vdCBiZQ0KPiAgICAgICAgICAgICAgICAgICAq
IGZyZWVkIHVudGlsIHRoZXkgYXJlIHJlbGVhc2VkLg0KPiAgICAgICAgICAgICAgICAgICAqLw0K
PiAtICAgICAgICAgICAgICAgcmV0ID0gcmVxdWVzdF90aHJlYWRlZF9pcnEoaW5mby0+aXJxLCB1
aW9faW50ZXJydXB0X2hhbmRsZXIsIHVpb19pbnRlcnJ1cHRfdGhyZWFkLA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+aXJxX2ZsYWdzLCBpbmZvLT5u
YW1lLCBpZGV2KTsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IHJlcXVlc3RfaXJxKGluZm8tPmly
cSwgdWlvX2ludGVycnVwdCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
Zm8tPmlycV9mbGFncywgaW5mby0+bmFtZSwgaWRldik7DQo+ICAgICAgICAgICAgICAgICAgaWYg
KHJldCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+dWlvX2RldiA9IE5VTEw7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9yZXF1ZXN0X2lycTsNCj4gLS0N
Cj4gMi41My4wDQo+DQo+IFRoaXMgZW1haWwgaXMgbm9uLWJpbmRpbmcsIGlzIHN1YmplY3QgdG8g
Y29udHJhY3QsIGFuZCBuZWl0aGVyIEt1bGlja2UgYW5kIFNvZmZhIEluZHVzdHJpZXMsIEluYy4g
bm9yIGl0cyBzdWJzaWRpYXJpZXMgKGVhY2ggYW5kIGNvbGxlY3RpdmVseSDigJxLJlPigJ0pIHNo
YWxsIGhhdmUgYW55IG9ibGlnYXRpb24gdG8geW91IHRvIGNvbnN1bW1hdGUgdGhlIHRyYW5zYWN0
aW9ucyBoZXJlaW4gb3IgdG8gZW50ZXIgaW50byBhbnkgYWdyZWVtZW50LCBvdGhlciB0aGFuIGlu
IGFjY29yZGFuY2Ugd2l0aCB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgYSBkZWZpbml0aXZl
IGFncmVlbWVudCBpZiBhbmQgd2hlbiBuZWdvdGlhdGVkLCBmaW5hbGl6ZWQgYW5kIGV4ZWN1dGVk
IGJldHdlZW4gdGhlIHBhcnRpZXMuIFRoaXMgZW1haWwgYW5kIGFsbCBpdHMgY29udGVudHMgYXJl
IHByb3RlY3RlZCBieSBJbnRlcm5hdGlvbmFsIGFuZCBVbml0ZWQgU3RhdGVzIGNvcHlyaWdodCBs
YXdzLiBBbnkgcmVwcm9kdWN0aW9uIG9yIHVzZSBvZiBhbGwgb3IgYW55IHBhcnQgb2YgdGhpcyBl
bWFpbCB3aXRob3V0IHRoZSBleHByZXNzIHdyaXR0ZW4gY29uc2VudCBvZiBLJlMgaXMgcHJvaGli
aXRlZC4=
