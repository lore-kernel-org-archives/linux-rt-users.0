Return-Path: <SRS0=Jzjp=TI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B6C04A6B
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 May 2019 04:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B0020850
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 May 2019 04:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KyKp5Loq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfEHEh7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 May 2019 00:37:59 -0400
Received: from mail-eopbgr740052.outbound.protection.outlook.com ([40.107.74.52]:28800
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfEHEh6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 May 2019 00:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYhCGY98k2hFK4fOCnxMiKtMomS2U/0Rf134ObbEi9A=;
 b=KyKp5Loqv8KpGC0lFBotMRBtlDH9/J6iUvrCZstgrDEuVnRBqLIOjNU3ZCCsbST2X47nmgzDROQL833oq36C5Rm7ipI69n2WGeZhwjMFECtdqgKWLh2oXEu+KErIPpmjk+1vnwgz3JYMw/1h8BGJ7zBcE43Nr6a6/Gg8XvhO/FA=
Received: from BYAPR05MB5878.namprd05.prod.outlook.com (20.178.50.75) by
 BYAPR05MB6200.namprd05.prod.outlook.com (20.178.55.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.10; Wed, 8 May 2019 04:37:53 +0000
Received: from BYAPR05MB5878.namprd05.prod.outlook.com
 ([fe80::3ce1:1649:c3b2:9328]) by BYAPR05MB5878.namprd05.prod.outlook.com
 ([fe80::3ce1:1649:c3b2:9328%7]) with mapi id 15.20.1878.019; Wed, 8 May 2019
 04:37:53 +0000
From:   Tiejun Chen <tiejunc@vmware.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: Real-time micro-conference proposal for Linux Plumbers 2019
Thread-Topic: Real-time micro-conference proposal for Linux Plumbers 2019
Thread-Index: AQHVAXzgmJ1jlyvGPkKtdSwqQOzUl6ZgqmNw
Date:   Wed, 8 May 2019 04:37:53 +0000
Message-ID: <BYAPR05MB5878261BB896A489AA521A65C5320@BYAPR05MB5878.namprd05.prod.outlook.com>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
In-Reply-To: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tiejunc@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28f52cda-b8fb-473a-5aec-08d6d36eef4e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6200;
x-ms-traffictypediagnostic: BYAPR05MB6200:
x-microsoft-antispam-prvs: <BYAPR05MB62002B7A465FF080EEAEE7BEC5320@BYAPR05MB6200.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(53754006)(13464003)(33656002)(76176011)(8936002)(7696005)(6506007)(53546011)(9686003)(110136005)(99286004)(86362001)(2501003)(55016002)(53936002)(6246003)(52536014)(316002)(74316002)(6436002)(229853002)(7736002)(561944003)(5660300002)(25786009)(76116006)(66946007)(66066001)(81156014)(8676002)(81166006)(66476007)(66556008)(66446008)(73956011)(68736007)(64756008)(14454004)(102836004)(2906002)(14444005)(6116002)(3846002)(478600001)(476003)(486006)(446003)(11346002)(71190400001)(71200400001)(305945005)(26005)(186003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6200;H:BYAPR05MB5878.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7kjgQm3u8e1nCfwxYbS07dkSp61opPNFQaby2/oLUWNgdG8cUmQ95KWsbuH7wPxZqnVrXnNI/ZpBu+4ButJqNJNOlkeor63FGYnKuTO4+zczGoVsfzndFym+3jZgqt5S000FkfWG9jFIOEPHsgf4f0BosCDNiRxu73u0vasy2aRKK+mBiHyAFw4+rBMflkfHtDFP79/aRO2MuYZdYfmS0/jaQN3H+u8baA/mYyADsEMdzVxBA0rxLthUTU4GiokelR8U6LSNt25jlWVeh6RNwTfOwrl+EglLQh7eGAs3zZXivWCAzqH7bPRGVMmqSV/AsqKd9KLjWiQ5fvvzlTJN7F6RyiWoBnXbSxvigW3ChNCYaJVZsv37f2Qmyh5mVE7QsPjqcTi+fUl2wpBo4/0WSyoGmv7GDGA/EmMpuIua8JE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f52cda-b8fb-473a-5aec-08d6d36eef4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 04:37:53.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6200
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgRGFuaWVsLA0KDQpJIGhvcGUgd2UgY2FuIGRpc2N1c3MgaWYtaG93IFByZWVtcHQtUlQga2Vy
bmVsIGNhbiBiZSB0dW5lZCB0byBiZW5lZml0IGNvbnRhaW5lci9kb2NrZXIuIEl0IHdvdWxkIGlu
dm9sdmUgYW55IHBvdGVudGlhbCBuZXcgaW50ZXJmYWNlcywgdG9vbHMvdXRpbGl0aWVzLCBldGMs
IGFuZCBob3cgdG8gbWFrZSBQcmVlbXB0LVJUIHdvcmsgdmVyeSB3ZWxsIHdpdGggc29tZSBMaW51
eCBzZWN1cmUgZmVhdHVyZXMuICBBY3R1YWxseSBJIHRyaWVkIHRvIGRpc2N1c3MgdGhpcyBsYXN0
IHllYXIgYnV0IGZvciBzb21lIHJlYXNvbnMgSSBkaWQgYXR0ZW5kIHJlYWwtdGltZSBtaWNyby1j
b25mZXJlbmNlIDIwMTgsIHVuZm9ydHVuYXRlbHkuIEkgaG9wZSB3ZSBjYW4gaGF2ZSBzdWNoIGEg
dG9waWMgYW5kIEknZCBsaWtlIHRvIHdvcmsgb24gdGhhdCBhcyB3ZWxsLg0KDQpUaGFua3MNClRp
ZWp1bg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LXJ0LXVz
ZXJzLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcnQtdXNlcnMtDQo+IG93bmVyQHZnZXIu
a2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIERhbmllbCBCcmlzdG90IGRlIE9saXZlaXJhDQo+IFNl
bnQ6IEZyaWRheSwgTWF5IDMsIDIwMTkgMjo1MyBQTQ0KPiBUbzogbGludXgtcnQtdXNlcnNAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlYWwtdGltZSBtaWNyby1jb25mZXJlbmNlIHByb3Bv
c2FsIGZvciBMaW51eCBQbHVtYmVycyAyMDE5DQo+IA0KPiBIaSBhbGwhDQo+IA0KPiBMYXN0IHll
YXIgd2UgaGFkIGEgdmVyeSBmdW4gYW5kIHByb2R1Y3RpdmUgcmVhbC10aW1lIG1pY3JvLWNvbmZl
cmVuY2UgYXQgdGhlDQo+IExpbnV4IFBsdW1iZXJzIENvbmZlcmVuY2UsIHNvIHRoZSBpZGVhIGlz
IHRvIHJlcGVhdCBpdCB0aGlzIHllYXIhDQo+IA0KPiBBcmUgeW91IGludGVyZXN0ZWQgaW4gcGFy
dGljaXBhdGluZz8gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24gb2YgdG9waWM/IExldCB1cw0K
PiBrbm93IQ0KPiANCj4gVGhpcyBpcyB0aGUgY3VycmVudCBwcm9wb3NhbCBvZiBtaWNyby1jb25m
ZXJlbmNlLCB3ZSBjYW4gc3RpbGwgZWRpdCBpdCBhbmQgYWRkIHlvdXINCj4gdGhvdWdodHMuDQo+
IA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT0gUFJPUE9TQUwNCj4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09IFNpbmNlIDIwMDQgYSBwcm9qZWN0IGhhcyBpbXByb3ZlZCB0aGUNCj4g
UmVhbC10aW1lIGFuZCBsb3ctbGF0ZW5jeSBmZWF0dXJlcyBmb3IgTGludXguIFRoaXMgcHJvamVj
dCBoYXMgYmVjb21lIGtub3cgYXMNCj4gUFJFRU1QVF9SVCwgZm9ybWFsbHkgdGhlIHJlYWwtdGlt
ZSBwYXRjaC4NCj4gT3ZlciB0aGUgcGFzdCBkZWNhZGUsIG1hbnkgcGFydHMgb2YgdGhlIFBSRUVN
UFQgUlQgYmVjYW1lIHBhcnQgb2YgdGhlIG9mZmljaWFsDQo+IExpbnV4IGNvZGUgYmFzZS4gRXhh
bXBsZXMgb2Ygd2hhdCBjYW1lIGZyb20gUFJFRU1QVF9SVCBpbmNsdWRlOiBSZWFsLXRpbWUNCj4g
bXV0ZXhlcywgaGlnaC1yZXNvbHV0aW9uIHRpbWVycywgbG9ja2RlcCwgZnRyYWNlLCBSVCBzY2hl
ZHVsaW5nLA0KPiBTQ0hFRF9ERUFETElORSwgUkNVX1BSRUVNUFQsIGdlbmVyaWMgaW50ZXJydXB0
cywgcHJpb3JpdHkgaW5oZXJpdGFuY2UgZnV0ZXhlcywNCj4gdGhyZWFkZWQgaW50ZXJydXB0IGhh
bmRsZXJzIGFuZCBtb3JlLiBUaGUgbnVtYmVyIG9mIHBhdGNoZXMgdGhhdCBuZWVkcw0KPiBpbnRl
Z3JhdGlvbiBoYXMgYmVlbiByZWR1Y2VkIG9uIHRoZSBsYXN0IHllYXJzLCBhbmQgdGhlIHBpZWNl
cyBsZWZ0IGFyZSBub3cgbWF0dXJlDQo+IGVub3VnaCB0byBtYWtlIGl0cyB3YXkgaW50byBtYWlu
bGluZSBMaW51eC4gVGhpcyB5ZWFyIGNvdWxkIHBvc3NpYmx5IGJlIHRoZSB5ZWFyDQo+IFBSRUVN
UFRfUlQgaXMgbWVyZ2VkICh0bSkhDQo+IA0KPiBJbiB0aGUgZmluYWwgbGFwIG9mIHRoaXMgcmFj
ZSwgdGhlIGxhc3QgcGF0Y2hlcyBhcmUgb24gdGhlIHdheSB0byBiZSBtZXJnZWQsIGJ1dA0KPiB0
aGVyZSBhcmUgc3RpbGwgc29tZSBwaWVjZXMgbWlzc2luZy4gV2hlbiB0aGUgbWVyZ2Ugb2NjdXJz
LCB0aGUgcHJlZW1wdC1ydCB3aWxsDQo+IHN0YXJ0IHRvIGZvbGxvdyBhIG5ldyBwYWNlOiB0aGUg
TGludXMgb25lLiBTbywgaXQgaXMgcG9zc2libGUgdG8gcmFpc2UgdGhlIGZvbGxvd2luZw0KPiBk
aXNjdXNzaW9uczoNCj4gDQo+ICAgMSkgVGhlIHN0YXR1cyBvZiB0aGUgbWVyZ2UsIGFuZCBob3cg
Y2FuIHdlIHJlc29sdmUgdGhlIGxhc3QgaXNzdWVzIHRoYXQgYmxvY2sgdGhlDQo+IG1lcmdlOw0K
PiAgIDIpIEhvdyBjYW4gd2UgaW1wcm92ZSB0aGUgdGVzdGluZyBvZiB0aGUgLXJ0LCB0byBmb2xs
b3cgdGhlIHByb2JsZW1zIHJhaXNlZCBhcw0KPiBMaW51cyB0cmVlIGFkdmFuY2VzOw0KPiAgIDMp
IFdoYXQncyBuZXh0Pw0KPiANCj4gUG9zc2libGUgdG9waWNzOg0KPiAgICAtIFN0YXR1cyBvZiB0
aGUgUFJFRU1QVF9SVCBNZXJnZQ0KPiANCj4gICAgLSBNZXJnZSAtIHdoYXQgaXMgbWlzc2luZyBh
bmQgd2hvIGNhbiBoZWxwPw0KPiANCj4gICAgLSBIb3cgZG8gd2UgdGVhY2ggdGhlIHJlc3Qgb2Yg
dGhlIGtlcm5lbCBkZXZlbG9wZXJzIGhvdyBub3QgdG8gYnJlYWsNCj4gICAgICBQUkVFTVBUX1JU
Pw0KPiANCj4gICAgLSBTdGFibGUgbWFpbnRhaW5lcnMgdG9vbHMgZGlzY3Vzc2lvbiAmIGltcHJv
dmVtZW50cy4NCj4gDQo+ICAgIC0gSW50ZXJydXB0IHRocmVhZHMgYXJlIFJUIGFuZCBhcmUgbm90
IHByb3RlY3RlZCBieSB0aGUgUlQgVGhyb3R0bGluZy4NCj4gICAgICBIb3cgY2FuIHdlIHByZXZl
bnQgaW50ZXJydXB0IHRocmVhZCBzdGFydmF0aW9uIGZyb20gYSByb2d1ZSBSVCB0YXNrPw0KPiAN
Cj4gICAgLSBJbXByb3ZlbWVudHMgb24gZnVsbCBDUFUgaXNvbGF0aW9uDQo+IA0KPiAgICAtIE5l
d2VyIG1ldGhvZHMgbGlrZSBwcm94eSBleGVjdXRpb24sIGhpZXJhcmNoaWNhbCBzY2hlZHVsZXI/
DQo+IA0KPiAgICAtIFdoYXQgdG9vbHMgY2FuIHdlIGFkZCBpbnRvIHRvb2xzLyB0aGF0IG90aGVy
IGtlcm5lbCBkZXZlbG9wZXJzIGNhbiB1c2UgdG8NCj4gICAgICB0ZXN0IGFuZCBsZWFybiBhYm91
dCBQUkVFTU1QVF9SVD8NCj4gDQo+ICAgIC0gV2hhdCB0ZXN0cyBjYW4gd2UgYWRkIGludG8gdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHM/DQo+IA0KPiAgICAtIE5ldyB0b29scyBmb3IgdGltaW5nIHJl
Z3Jlc3Npb24gdGVzdCwgZS5nLiBsb2NraW5nLCBvdmVyaGVhZHMuLi4NCj4gDQo+ICAgIC0gV2hh
dCBrZXJuZWwgYm9vdCBzZWxmLXRlc3RzIGNhbiBiZSBhZGRlZD8NCj4gDQo+ICAgIC0gRGlzY3Vz
cyB2YXJpb3VzIHR5cGVzIG9mIGZhaWx1cmVzIHRoYXQgY2FuIGhhcHBlbiB3aXRoIFBSRUVNUFRf
UlQNCj4gICAgICB0aGF0IG5vcm1hbGx5IHdvdWxkIG5vdCBoYXBwZW4gaW4gdGhlIHZhbmlsbGEg
a2VybmVsLCBlLmcsIHdpdGggbG9ja2RlcCwNCj4gICAgICBwcmVlbXB0aW9uIG1vZGVsLg0KPiAN
Cj4gSSB3aWxsIHN1Z2dlc3QgdGhlIGNvbnRpbnVhdGlvbiBvZiB0aGUgZGlzY3Vzc2lvbnMgb2Yg
dGhlIHRvcGljcyBJIHByZXNlbnRlZCBsYXN0IHllYXIsDQo+IGJhc2VkIGluIHRoZSByZXN1bHRz
IG9mIHRoZSB3b3JrIEkgZGlkIHRoaXMgeWVhciAoc3BvaWxlcjogSSBhbSBkb2luZyBtb2RlbA0K
PiB2ZXJpZmljYXRpb24gaW4gdGhlIGtlcm5lbCwgYW5kIGl0IGlzIHZlcnkgZWZmaWNpZW50ISku
DQo+IA0KPiBQYXVsIGFscmVhZHkgdG9sZCB0aGF0IGhlIGNvdWxkIHRhbGsgYWJvdXQgb25nb2lu
ZyB3b3JrIHRvIG1ha2UgUkNVJ3MgZm9yd2FyZA0KPiBwcm9ncmVzcyBiZSBtb3JlIHJvYnVzdCBp
biBvdmVybG9hZGVkIGNsb3VkIGRlcGxveW1lbnRzLiBUaGVyZSB3aWxsIGJlIHNvbWUNCj4gY29u
bmVjdGlvbiB0byByZWFsLXRpbWUgcmVzcG9uc2UgaW52b2x2aW5nIHJjdV9wb2xsIGFuZCB0aGUg
aW5mYW1vdXMgUkNVDQo+IGt0aHJlYWQgcHJpb3JpdHkhDQo+IA0KPiBUaGUgY29udGludWF0aW9u
IG9mIHRoZSBkaXNjdXNzaW9uIG9mIHRvcGljcyBmcm9tIGxhc3QgeWVhcidzIG1pY3JvLWNvbmZl
cmVuY2UsDQo+IGluY2x1ZGluZyB0aGUgZGV2ZWxvcG1lbnQgZG9uZSBkdXJpbmcgdGhpcyAoYWxt
b3N0KSB5ZWFyLCBhcmUgYWxzbyB3ZWxjb21lIQ0KPiANCj4gLS0gRGFuaWVsDQo=
