Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8B8C04AB4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E1220881
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="pttrLVBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENN0y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 09:26:54 -0400
Received: from mail-eopbgr800051.outbound.protection.outlook.com ([40.107.80.51]:63936
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfENN0x (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 09:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQjVb8NF9MFnSPZ6WGsf7EvOIvxyOv5KeAqxOJTq/CE=;
 b=pttrLVBaTWLYb7hespHhm+ODeDanmn8XJtpK+wtYHyieV3kv56heFuNK6cKK5woIRny/4vcAyBk3sY+m4biJ79lPg3WOX3uQDU6nk3FdhfGfSsfttDAlcWpYSQgFfz7sRDjP9YukNTrC9a0MaBubo2VzvwbizWL15ZkZnMy5rP8=
Received: from BYAPR05MB5878.namprd05.prod.outlook.com (20.178.50.75) by
 BYAPR05MB5927.namprd05.prod.outlook.com (20.178.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.5; Tue, 14 May 2019 13:26:50 +0000
Received: from BYAPR05MB5878.namprd05.prod.outlook.com
 ([fe80::3ce1:1649:c3b2:9328]) by BYAPR05MB5878.namprd05.prod.outlook.com
 ([fe80::3ce1:1649:c3b2:9328%7]) with mapi id 15.20.1900.010; Tue, 14 May 2019
 13:26:50 +0000
From:   Tiejun Chen <tiejunc@vmware.com>
To:     Daniel Bristot de Oliveira <daniel@bristot.me>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: Real-time micro-conference proposal for Linux Plumbers 2019
Thread-Topic: Real-time micro-conference proposal for Linux Plumbers 2019
Thread-Index: AQHVAXzgmJ1jlyvGPkKtdSwqQOzUl6ZgqmNwgAHMCYCACDdc0A==
Date:   Tue, 14 May 2019 13:26:50 +0000
Message-ID: <BYAPR05MB5878B8AD281E40A522996975C5080@BYAPR05MB5878.namprd05.prod.outlook.com>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <BYAPR05MB5878261BB896A489AA521A65C5320@BYAPR05MB5878.namprd05.prod.outlook.com>
 <02b2eb1e-b88b-3ade-1e0d-741bf92939b1@bristot.me>
In-Reply-To: <02b2eb1e-b88b-3ade-1e0d-741bf92939b1@bristot.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tiejunc@vmware.com; 
x-originating-ip: [50.204.119.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd13d8e4-fb42-493a-b91d-08d6d86fd29f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5927;
x-ms-traffictypediagnostic: BYAPR05MB5927:
x-microsoft-antispam-prvs: <BYAPR05MB5927744129A93369C7EC9D4CC5080@BYAPR05MB5927.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(13464003)(189003)(199004)(68736007)(25786009)(66066001)(33656002)(71200400001)(71190400001)(486006)(55016002)(229853002)(256004)(14454004)(9686003)(316002)(6436002)(561944003)(2906002)(478600001)(446003)(476003)(11346002)(413944005)(305945005)(8676002)(81156014)(81166006)(53546011)(6506007)(76176011)(7736002)(99286004)(102836004)(7696005)(8936002)(53936002)(6246003)(5660300002)(110136005)(2501003)(73956011)(76116006)(86362001)(66446008)(66946007)(66476007)(66556008)(64756008)(26005)(52536014)(74316002)(186003)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5927;H:BYAPR05MB5878.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Acp1mymIhxx1K8HCzbo8RrKc/g0+DhTEiIZvw5MUCpL7fcoBSi3GL5aQU+h8O/2Bbd+U2q+bkOSZ9mExFqUmjET1Hmz57LiztMdTwWD0/mfwXXXpMtG3g3aQpQr3HIdoQwSMI32L7FBmnkE3VAiiNgpkPksc92RHn2JXF9DUpiqhoXG+w+nks9q3JHA5fHjsq21cgJYETVZnTbbhLU/WUF5V28jKdJTG4PNF1ktXtEVbjc4RpqHI7giLO25ujsc4IcN3C/Q54kD/Q9HrEiiAsplaTnD6xT7buc0PzaCC+C5dr3/A/2NajIJHu6WgmD7MjtwqRnsvIhaJJIcZCsOKcmFXOuJT6ObyMdSuNPWE9O7TOwEPbodfGX44UQvNnEVoJON+FCi1YJ+x/IkP+B+piXPp7zmX3qioH3QTcxNsDgc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd13d8e4-fb42-493a-b91d-08d6d86fd29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 13:26:50.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5927
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

RGVhciBEYW5pZWwsDQoNCk5vdCBwcmV0dHkgc3VyZSBpZiBJIHdpbGwgYmUgdGhlcmUgY3VycmVu
dGx5IGJ1dCBJIHdpbGwgdHJ5IG15IGJlc3QuIEkgd2lsbCB3b3JrIG9uIHRoZSBwcmVwYXJhdGlv
biBvZiB0aGVzZSB0b3BpY3MuDQoNClRoYW5rcw0KVGllanVuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJyaXN0b3QgZGUgT2xpdmVpcmEgPGRhbmllbEBi
cmlzdG90Lm1lPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDksIDIwMTkgMTI6NTYgQU0NCj4gVG86
IFRpZWp1biBDaGVuIDx0aWVqdW5jQHZtd2FyZS5jb20+OyBEYW5pZWwgQnJpc3RvdCBkZSBPbGl2
ZWlyYQ0KPiA8YnJpc3RvdEByZWRoYXQuY29tPjsgbGludXgtcnQtdXNlcnNAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBSZWFsLXRpbWUgbWljcm8tY29uZmVyZW5jZSBwcm9wb3NhbCBm
b3IgTGludXggUGx1bWJlcnMgMjAxOQ0KPiANCj4gSGkgVGllanVuIQ0KPiANCj4gT24gNS84LzE5
IDY6MzcgQU0sIFRpZWp1biBDaGVuIHdyb3RlOg0KPiA+IEhpIERhbmllbCwNCj4gPg0KPiA+IEkg
aG9wZSB3ZSBjYW4gZGlzY3VzcyBpZi1ob3cgUHJlZW1wdC1SVCBrZXJuZWwgY2FuIGJlIHR1bmVk
IHRvIGJlbmVmaXQNCj4gY29udGFpbmVyL2RvY2tlci4gSXQgd291bGQgaW52b2x2ZSBhbnkgcG90
ZW50aWFsIG5ldyBpbnRlcmZhY2VzLCB0b29scy91dGlsaXRpZXMsIGV0YywNCj4gYW5kIGhvdyB0
byBtYWtlIFByZWVtcHQtUlQgd29yayB2ZXJ5IHdlbGwgd2l0aCBzb21lIExpbnV4IHNlY3VyZSBm
ZWF0dXJlcy4NCj4gQWN0dWFsbHkgSSB0cmllZCB0byBkaXNjdXNzIHRoaXMgbGFzdCB5ZWFyIGJ1
dCBmb3Igc29tZSByZWFzb25zIEkgZGlkIGF0dGVuZCByZWFsLXRpbWUNCj4gbWljcm8tY29uZmVy
ZW5jZSAyMDE4LCB1bmZvcnR1bmF0ZWx5LiBJIGhvcGUgd2UgY2FuIGhhdmUgc3VjaCBhIHRvcGlj
IGFuZCBJJ2QNCj4gbGlrZSB0byB3b3JrIG9uIHRoYXQgYXMgd2VsbC4NCj4gDQo+IFllYWgsIHRo
aXMgaXMgYSBob3QgdG9waWMhIEFyZSB5b3UgcGxhbm5pbmcgdG8gYXR0ZW5kIHRvIFBsdW1iZXIg
dGhpcyB5ZWFyPyBJZiBzbywNCj4gd291bGQgeW91IG1pbmQgdG8gcHJlcGFyZSAzIG9yIDQgc2xp
ZGVzIGludHJvZHVjaW5nIHRoZSBwcm9ibGVtIHRvICJ3YXJtLXVwIg0KPiB0aGUgZGlzY3Vzc2lv
biBhdCB0aGUgTUM/DQo+IA0KPiBUaGFua3MhDQo+IA0KPiAtLSBEYW5pZWwNCj4gDQo+ID4NCj4g
PiBUaGFua3MNCj4gPiBUaWVqdW4NCg==
