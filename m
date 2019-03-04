Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A932C4360F
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C19820652
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 22:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Asn4j3gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfCDWZw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:25:52 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:8259
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfCDWZw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 17:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wgZTrAbv3ufGRh+hu3/Ch7X/bozpkUJg+AvRzfaOSw=;
 b=Asn4j3giU+gvLMg500jXtpEqwuKoOQVksXP+aMDVJNVwzoysp4F0ZR+RKKzx4g0DB7uIGlCkUhg9fnh0yP7Efi+fwkWYf0jYOzNRgtJtzn0N2dJ/CsdtUBUpRG8T2VybyVzIAx/t4SYzWRPebRwWZCPwwdGUwvz1sOy7JSE/OQk=
Received: from VI1PR08MB2862.eurprd08.prod.outlook.com (10.170.239.138) by
 VI1PR08MB0864.eurprd08.prod.outlook.com (10.164.93.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 22:25:41 +0000
Received: from VI1PR08MB2862.eurprd08.prod.outlook.com
 ([fe80::f0d9:64f0:bde3:8c4b]) by VI1PR08MB2862.eurprd08.prod.outlook.com
 ([fe80::f0d9:64f0:bde3:8c4b%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 22:25:41 +0000
From:   Julien Grall <Julien.Grall@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
Thread-Topic: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
Thread-Index: AQHU0q6jo+7E6szr3EWbZC0EUBeUr6X7uCyAgABONoCAAAajAA==
Date:   Mon, 4 Mar 2019 22:25:41 +0000
Message-ID: <75159b6e-0733-e300-e4f5-d519ca7f6b13@arm.com>
References: <20190304172053.17340-1-julien.grall@arm.com>
 <545fb96e-0f07-758e-5c79-a725e74e3387@arm.com>
 <20190304220152.nozgclpu2jx3zgvy@linutronix.de>
In-Reply-To: <20190304220152.nozgclpu2jx3zgvy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0468.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::24) To VI1PR08MB2862.eurprd08.prod.outlook.com
 (2603:10a6:802:1f::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Grall@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.100.41.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 625304d1-d0df-4ad9-a0c8-08d6a0f055e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0864;
x-ms-traffictypediagnostic: VI1PR08MB0864:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0864;20:NeRW3pTb1dL9c/tZIvXymodxSM42GNug3ZIzfv3Qg3gkBdDHCmvo29uVLLx5mO9v48B50AEx2Kr4qRTt5YrrgGvNi8AxLfXY9OIhipXXpNMBQVlATmogAGsaahb2DORZq0yEymvBvJ/04+9/5FM5wU/eCS7WXTGwqdxnZ3mbS74=
x-microsoft-antispam-prvs: <VI1PR08MB08643550CDD2FC32A6C30DD380710@VI1PR08MB0864.eurprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(71200400001)(71190400001)(14444005)(256004)(106356001)(105586002)(6486002)(66066001)(6436002)(3846002)(6116002)(5660300002)(2616005)(31696002)(2906002)(97736004)(6512007)(31686004)(6246003)(53936002)(54906003)(68736007)(316002)(4326008)(86362001)(186003)(486006)(6916009)(52116002)(305945005)(99286004)(53546011)(102836004)(386003)(6506007)(25786009)(26005)(36756003)(8676002)(81166006)(81156014)(7736002)(8936002)(229853002)(14454004)(76176011)(11346002)(446003)(478600001)(72206003)(476003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0864;H:VI1PR08MB2862.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JQXlOe/ur8bSE/00OU9OLo1s+kmrIZJ5AVSSM5eb1S7gVO3KKrvcFrfTuS4LUtOEla9xYho+9VDvgSSOk65l3xo0nlwZSrczwtZ9mZ8yK4du89y5Mek7MpjPqyYpgAYh5Y5y2RzDF915+SRIHyWAnnkqBZl6luCK1Htbhs4LAxiIQAzcQFsajWBEATVtxkZ94AiPTGZfUVDiDuRyTLMYRumOfNnjT5UiuDev9nPBbb5b8aXNabscUmDqISR5kilrygvDCZyHtVAqpu9fdkGQ32tPTrc8Yrw/Xu/gkQ2FN8pIgFj9zEm/rRxb8hrtrW5wVtdLE+KDDFgqj6Dip9Xw3feXNJvNpPQ3IlUq9OJwyC4xtdNbP6cxoOJGQkxAmwo+6iTNLBc3TJYCe8qRXk4zYkqHAcO8r9/wjibUfiFNyHU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <493ABD42A8E1E3448E13CEF95608B7C7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625304d1-d0df-4ad9-a0c8-08d6a0f055e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 22:25:41.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0864
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGVsbG8gU2ViYXN0aWFuLA0KDQpPbiAwNC8wMy8yMDE5IDIyOjAxLCBTZWJhc3RpYW4gQW5kcnpl
aiBTaWV3aW9yIHdyb3RlOg0KPiBPbiAyMDE5LTAzLTA0IDE3OjIxOjU3IFsrMDAwMF0sIEp1bGll
biBHcmFsbCB3cm90ZToNCj4+IChDQyBjb3JyZWN0bHkgbGludXgtcnQtdXNlcnMpDQo+Pg0KPj4g
T24gMDQvMDMvMjAxOSAxNzoyMCwgSnVsaWVuIEdyYWxsIHdyb3RlOg0KPj4+IEF0IHRoZSBtb21l
bnQgc2hvd19sb2NrIGlzIGltcGxlbWVudGVkIHVzaW5nIHNwaW5fbG9ja190IGFuZCBjYWxsZWQg
ZnJvbQ0KPj4+IGFuIGludGVycnVwdCBjb250ZXh0IG9uIEFybTY0LiBUaGUgZm9sbG93aW5nIGJh
Y2t0cmFjZSB3YXMgdHJpZ2dlcmVkIGJ5Og0KPj4+DQo+Pj4gNDJzaCMgZWNobyBsID4gL3Byb2Mv
c3lzcnEtdHJpZ2dlcg0KPj4+DQo+Pj4gWyA0NDMyLjA3Mzc1Nl0gc3lzcnE6IFN5c1JxIDogU2hv
dyBiYWNrdHJhY2Ugb2YgYWxsIGFjdGl2ZSBDUFVzDQo+Pj4gWyA0NDMyLjQwMzQyMl0gQlVHOiBz
bGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQga2VybmVsL2xv
Y2tpbmcvcnRtdXRleC5jOjk3NA0KPj4+IFsgNDQzMi40MDM0MjRdIHN5c3JxOiBDUFU2Og0KPj4+
IFsgNDQzMi40MDM0MjZdIGluX2F0b21pYygpOiAxLCBpcnFzX2Rpc2FibGVkKCk6IDEyOCwgcGlk
OiAyNDEwLCBuYW1lOiBrd29ya2VyL3UxNjoyDQo+Pj4NCj4+PiBbLi4uXQ0KPj4+DQo+Pj4gWyA0
NDMyLjQwMzU4MV0gQ2FsbCB0cmFjZToNCj4+PiBbIDQ0MzIuNDAzNTg0XSAgZHVtcF9iYWNrdHJh
Y2UrMHgwLzB4MTQ4DQo+Pj4gWyA0NDMyLjQwMzU4Nl0gIHNob3dfc3RhY2srMHgxNC8weDIwDQo+
Pj4gWyA0NDMyLjQwMzU4OF0gIGR1bXBfc3RhY2srMHg5Yy8weGQ0DQo+Pj4gWyA0NDMyLjQwMzU5
Ml0gIF9fX21pZ2h0X3NsZWVwKzB4MWNjLzB4Mjk4DQo+Pj4gWyA0NDMyLjQwMzU5NV0gIHJ0X3Nw
aW5fbG9jaysweDVjLzB4NzANCj4+PiBbIDQ0MzIuNDAzNTk2XSAgc2hvd2FjcHUrMHgzNC8weDY4
DQo+Pj4gWyA0NDMyLjQwMzU5OV0gIGZsdXNoX3NtcF9jYWxsX2Z1bmN0aW9uX3F1ZXVlKzB4ZDQv
MHgyNzgNCj4+PiBbIDQ0MzIuNDAzNjAyXSAgZ2VuZXJpY19zbXBfY2FsbF9mdW5jdGlvbl9zaW5n
bGVfaW50ZXJydXB0KzB4MTAvMHgxOA0KPj4+IFsgNDQzMi40MDM2MDVdICBoYW5kbGVfSVBJKzB4
MjZjLzB4NjY4DQo+Pj4gWyA0NDMyLjQwMzYwN10gIGdpY19oYW5kbGVfaXJxKzB4OWMvMHhhMA0K
Pj4+IFsgNDQzMi40MDM2MDldICBlbDFfaXJxKzB4YjQvMHgxM2MNCj4+Pg0KPj4+IFdpdGggUlQt
cGF0Y2hlcywgc3Bpbl9sb2NrIGNhbiBub3cgc2xlZXAgYW5kIHRoZXJlZm9yZSBjYW5ub3QgYmUg
dXNlZCBmcm9tDQo+Pj4gaW50ZXJydXB0IGNvbnRleHQuIFVzZSBhIHJhd19zcGluX2xvY2sgaW5z
dGVhZCB0byBwcmV2ZW50IHRoZSBsb2NrIHRvDQo+Pj4gc2xlZXAuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBKdWxpZW4gR3JhbGwgPGp1bGllbi5ncmFsbEBhcm0uY29tPg0KPiANCj4gSSBkb24n
dCBoYXZlIHRvIGxvb2sgYXQgdGhpcyBwcm9wZXJseSBidXQgdGhpcyBsb29rcyBpcyB3cm9uZy4N
Cg0KTWF5IEkgYXNrIHdoeSBkb2VzIGl0IGxvb2sgd3Jvbmc/IE9uIEFybTY0LCB0aGlzIGNvZGUg
aXMgY2FsbGVkIGZyb20gYW4gDQpJUlEgZGlzYWJsZWQgY29udGV4dCAoc2VlIHRoZSBjaGVjayBp
biBmbHVzaF9zbXBfY2FsbF9mdW5jdGlvbl9xdWV1ZSkuDQoNClNvIGl0IHNlZW1zIHRvIG1lIHRo
YXQgaXQgbWFrZXMgc2Vuc2UgdG8gc3dpdGNoIHRvIGEgcmF3IHNwaW4gbG9jayBoZXJlLg0KSSB3
b3VsZCBiZSBoYXBweSB0byBpbXBsZW1lbnQgZGlmZmVyZW50bHkgaWYgeW91IGhhdmUgYSBiZXR0
ZXIgc29sdXRpb24gDQpoZXJlLg0KDQo+IFBsZWFzZSBDQyB0aGUgUlQgZGV2ZWxvcGVycyBpZiB5
b3UgcGxhbiBhbnkgY2hhbmdlcyB0aGF0IGFmZmVjdHMgcHJpbWFyeQ0KPiBvbmx5IHRoZSBSVCB0
cmVlLiBUaGlzIGNoYW5nZSBpcyBhIG5vcCBmb3IgdGhlICFSVCB0cmVlLg0KDQpTb3JyeSwgSSB3
YXMgbm90IHN1cmUgd2hldGhlciBDQ2luZyBsaW51eC1ydC11c2VycyB3YXMgZW5vdWdoIGhlcmUu
DQoNCj4gDQo+Pj4gICAgZHJpdmVycy90dHkvc3lzcnEuYyB8IDYgKysrLS0tDQo+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zeXNycS5jIGIvZHJpdmVycy90dHkvc3lzcnEuYw0KPj4+
IGluZGV4IDFmMDMwNzhlYzM1Mi4uODQ3MzU1N2M3YWIyIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZl
cnMvdHR5L3N5c3JxLmMNCj4+PiArKysgYi9kcml2ZXJzL3R0eS9zeXNycS5jDQo+Pj4gQEAgLTIw
OCw3ICsyMDgsNyBAQCBzdGF0aWMgc3RydWN0IHN5c3JxX2tleV9vcCBzeXNycV9zaG93bG9ja3Nf
b3AgPSB7DQo+Pj4gICAgI2VuZGlmDQo+Pj4gICAgI2lmZGVmIENPTkZJR19TTVANCj4+PiAtc3Rh
dGljIERFRklORV9TUElOTE9DSyhzaG93X2xvY2spOw0KPj4+ICtzdGF0aWMgREVGSU5FX1JBV19T
UElOTE9DSyhzaG93X2xvY2spOw0KPj4+ICAgIHN0YXRpYyB2b2lkIHNob3dhY3B1KHZvaWQgKmR1
bW15KQ0KPj4+ICAgIHsNCj4+PiBAQCAtMjE4LDEwICsyMTgsMTAgQEAgc3RhdGljIHZvaWQgc2hv
d2FjcHUodm9pZCAqZHVtbXkpDQo+Pj4gICAgCWlmIChpZGxlX2NwdShzbXBfcHJvY2Vzc29yX2lk
KCkpKQ0KPj4+ICAgIAkJcmV0dXJuOw0KPj4+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJnNob3dfbG9j
aywgZmxhZ3MpOw0KPj4+ICsJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZzaG93X2xvY2ssIGZsYWdz
KTsNCj4+PiAgICAJcHJfaW5mbygiQ1BVJWQ6XG4iLCBzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPj4+
ICAgIAlzaG93X3N0YWNrKE5VTEwsIE5VTEwpOw0KPj4+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmc2hvd19sb2NrLCBmbGFncyk7DQo+Pj4gKwlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
c2hvd19sb2NrLCBmbGFncyk7DQo+Pj4gICAgfQ0KPj4+ICAgIHN0YXRpYyB2b2lkIHN5c3JxX3No
b3dyZWdzX290aGVyY3B1cyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKmR1bW15KQ0KPj4+DQoNCkJlc3Qg
cmVnYXJkcywNCg0KLS0gDQpKdWxpZW4gR3JhbGwNCg==
