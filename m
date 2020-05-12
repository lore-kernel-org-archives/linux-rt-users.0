Return-Path: <SRS0=+khU=62=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6159C54E4A
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B1C206D3
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 13:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mobileye.onmicrosoft.com header.i=@Mobileye.onmicrosoft.com header.b="vp9i1H7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELNlI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 May 2020 09:41:08 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:6036
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgELNlH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 May 2020 09:41:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFPGGzsHoEX1wph3qe1X+NOK9mgqOrs9DI3HyT/6XSjdseZU2yl0G9vcF1tgPxx3Vwf3TX2eF/GDPXqj08vLtX9gElH6ywj+qPhAV5vsCS/xoMSWdJ7PzqD4cyREcwzT350H3mnLXnI+y8PLatnElHJdU/dHTlO3exmhcFyrDqs4KnioPhAsoMh1iLsonogZ7wl1Lbk5ur9zi6d1kvr6Z3xUFJ6T7e1Rhydrcy8egb+UYc47BOVF0B0I4PXyvafdChDdbGtHK8qhXWJvMdD4h5chHdljYIRl8Wfa7w6yxbBI6hR2ZaCv6q7aoTSQ5vdtje1yDeA15tYacMEXJwcePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcAI7zydw8a4i4J5r1jl6mrSFvMtMAYU8RsJh9j9u7o=;
 b=IzNFKQejCSIB710xz60vIi2T0t09EGwZF3glzCt5/7ozgCpqyhtaRjn5MvlwWMvZd9cFZS9mgRyZ/wscftdMkiU68/CuUuSN3WvhcEzkTImsa+V7bETeY7sq14ChSLD1i1ZExiGYM45uS+lZFtLnmISJeDQ0yRLmOridDWzUgx3NdGYerJPGERMGeSqlJrL/J3xcrsMNmpqi+PW80dpcheUCq+BvSop24fc3HwzMfGQ+igaRAlOiIBYUrf3ER5NQXQ2oMinrZ833S8lyHae6uKfJltge8mx3iJzsNXexDEAF2sY0beOFutwkcvtcKSH0YvYFXpBbyaliokSeaoR3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Mobileye.onmicrosoft.com; s=selector2-Mobileye-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcAI7zydw8a4i4J5r1jl6mrSFvMtMAYU8RsJh9j9u7o=;
 b=vp9i1H7otiYvAAvS3+oBsLtT/kPjjLF8Roo7HZ3PxoDheJKDfEWEKmdH+cdI6/vBGqAxQGTERsZMlf7d618M7/q/vunbbCJZj2+ND/zlH8pca5vZY176N7aF+gYFkhWl1z023Ru20IjUFtVFSnjJrEC3AYVtZf7v7KEJ5SQ9v2U=
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com (2603:10a6:208:181::15)
 by AM0PR09MB4274.eurprd09.prod.outlook.com (2603:10a6:20b:169::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 13:41:04 +0000
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c]) by AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 13:41:03 +0000
From:   Elana Copperman <Elana.Copperman@mobileye.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Vladimir Kondratiev (Mobileye)" 
        <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
Subject: RE: cgroups CPU time management + PREEMPT_RT
Thread-Topic: cgroups CPU time management + PREEMPT_RT
Thread-Index: AdYkm/M/lU1yRRU5Sia9bqNtzqcgHQABswywAO9u+OsAADfTaQAAPKEAAAAUa8A=
Date:   Tue, 12 May 2020 13:41:03 +0000
Message-ID: <AM0PR09MB3794A35CEC4017897544E40999BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
References: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
        <AM0PR09MB3794E9CFE8BA31852B712DAD99A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
        <AM0PR09MB3794F5E857CB761859BBEF0B99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
        <AM0PR09MB3794A1DA3C38B31A4A16E9DD99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <20200512093612.416899e1@gandalf.local.home>
In-Reply-To: <20200512093612.416899e1@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=mobileye.com;
x-originating-ip: [134.191.232.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d70c52-440d-4d2b-ce07-08d7f67a1d9d
x-ms-traffictypediagnostic: AM0PR09MB4274:
x-ld-processed: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa,ExtAddr
x-microsoft-antispam-prvs: <AM0PR09MB4274F4CDB5861F9EF0C1F71C99BE0@AM0PR09MB4274.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 475pXzAXvB2Vy0BOhhc4K2Fw0UcPLtrQLV6ppGl8pYYzIR3T9A6Roznu52WB9QhwC0hqPwQtIpQk7+ITBaMKaedKU3/P5OilyHTCqkahmn+qbDgxmd4s1SrvoOopWDsog9e0VX53JtT0v52S3luxwaADtckjAZEkZAB2Fzb4dj82YcSYSdq5pJC0oTCW+XTAvqU1+VL8Ffb6Z9C61AycHaKBw6o77sMpX9k2mCNhZqyF+BOUgJjEEJhw8XFEmRuG04GviYR2RKA5x+0Pf1K5t/bHDrixHmfuLRr6lfIFIjoe3iZGfaflHfYyxlVX211CQ+JPedhO8mfrRNgs6cJ3p2ESv/ewRvsAE0uudJ1aQHUe4ueKXzCHrI/hXrUUir2ct6JAYhq2HzeSfbxqhfipd/lB9JSzN8oni8afsPw8157Xw/XFmFgbJXLuHA/sskokUH5AL5PDIF7yM+27ywiSBCVOsn/Gif4TXY2HOt1+JF8KmXexen0N437maMBvGltBN+VxpkIZnW5p4MbOXkO9EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB3794.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(39850400004)(376002)(366004)(33430700001)(66556008)(64756008)(52536014)(76116006)(71200400001)(66446008)(66476007)(9686003)(33440700001)(8676002)(2906002)(8936002)(7696005)(55016002)(66946007)(5660300002)(86362001)(186003)(26005)(33656002)(478600001)(316002)(6916009)(6506007)(4326008)(53546011)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /YoU6ypkGWdobtRIeqUS0dun2+91WsdSYEvGp7YOBqDm+1FJoyWiRMbmaDsJmuExz39mR1f2vQjnS+CC//a/nfJ/IY+jdQiJrbF/r7Hheu5O8iYc2QuuHDLOGkzlsj0Qb7v8q/PfUZaIFHrUeiuxAfw2fygPMbDb3WUeDmOCrx0OMVUPorbGf9feqRNlVqSUlUYqMoIDxlRyQmqYg01esUoVdaaU56RXFSqFR0TiPP0+ifWL0DXkmfvfG7MUosy+MSgps4T39bkPtR6xYcWvxoakkYzU3+6ExhB4NUtWv3oa4MCs82H4PzuGo+ioHQ2G5p+6RfoZV0hOp3LdVok0Lx1vo1gUbGJg1QQw1ZRqVHqQtPPVnrwCe8GCNNl1kAnvXcbZp7JYaF6XOIvF4xIHv3jA7taWhtK2nLbzsHHHA6ZGyrpQVnBeszIH264jip5uuNZ160SpxDc12u7jGNKUFnpXiBWtZoZwZrcIzZcHgXB0WnFBF5f5URQIpaC0gxE7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d70c52-440d-4d2b-ce07-08d7f67a1d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 13:41:03.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyFpsVGcYP3F2OUtbVhryfXbBQaQE4kXR5bbCLNQDbaCazjJdt4uAxRXu5C71vciIGeU4rXYPSwJa50N1Tt+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4274
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTdGV2ZW4gUm9zdGVkdCA8cm9z
dGVkdEBnb29kbWlzLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBNYXkgMTIsIDIwMjAgNDozNiBQTQ0K
VG86IEVsYW5hIENvcHBlcm1hbiA8RWxhbmEuQ29wcGVybWFuQG1vYmlsZXllLmNvbT4NCkNjOiBs
aW51eC1ydC11c2VycyA8bGludXgtcnQtdXNlcnNAdmdlci5rZXJuZWwub3JnPjsgVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBWbGFkaW1pciBLb25kcmF0aWV2IChNb2JpbGV5
ZSkgPDYzZGM0YjVkLWM0NjctNGJmYi1iY2U1LTc0NDg1OTA3Yzg1MEBpbnRlbC5tYWlsLm9ubWlj
cm9zb2Z0LmNvbT4NClN1YmplY3Q6IFJlOiBjZ3JvdXBzIENQVSB0aW1lIG1hbmFnZW1lbnQgKyBQ
UkVFTVBUX1JUDQoNCk9uIFR1ZSwgMTIgTWF5IDIwMjAgMTM6MzA6MjcgKzAwMDANCkVsYW5hIENv
cHBlcm1hbiA8RWxhbmEuQ29wcGVybWFuQG1vYmlsZXllLmNvbT4gd3JvdGU6DQoNCj4gSGksIGNh
biB5b3UgaGVscCB0byBjbGFyaWZ5IGlmIHRoZXJlIGlzIGFueSBpbXBsZW1lbnRhdGlvbiBzdXBw
b3J0IG9yIA0KPiBldmlkZW5jZSBvbiBjb25maWd1cmluZyBjZ3JvdXBzIENQVSB0aW1lIGFsbG9j
YXRpb25zIGZvciBSVCB0YXNrcyBpbiANCj4gY29uanVuY3Rpb24gd2l0aCB0aGUgUFJFRU1QVF9S
VCBwYXRjaD8NCg0KV2hhdCBleGFjdGx5IGFyZSB5b3UgdHJ5aW5nIHRvIGRvIHdpdGggY2dyb3Vw
cyBDUFUgdGltZSBhbGxvY2F0aW9ucywgYW5kIHdoYXQgaXMgdGhlIHByb2JsZW0geW91IGFyZSBz
ZWVpbmcgd2l0aCB0aGUgUFJFRU1QVF9SVCBwYXRjaCB3aXRoIHRoZW0/DQoNCkknbSBhc3N1bWlu
ZyB5b3UgYXJlIHVzaW5nIHRoZSA1LjYtcnQga2VybmVsLg0KDQo+PiBObywgd2UgYXJlIHVzaW5n
IHZlcnNpb24gNC4xOS43MiArIFBSRUVNUFRfUlQgcGF0Y2gNCj4+IFdlIGFyZSBzdGlsbCBpbiBk
ZXNpZ24gc3RhZ2UuICBKdXN0IHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyB0byByZWNvbmNpbGUg
dGhlIHJlcXVpcmVtZW50cy4NCj4+IEN1cnJlbnRseSB3ZSBhY3R1YWxseSBzZWUgbm8ganVzdGlm
aWNhdGlvbiBmb3IgdXNpbmcgY2dyb3VwcyBDUFUgdGltZSBhbGxvY2F0aW9ucyBmb3IgUlQgdGFz
a3MsIHVubGVzcyB5b3UgaGF2ZSBzb21lIHNwZWNpZmljIHN1cHBvcnQgaW4gbW9yZSByZWNlbnQg
dmVyc2lvbnMgb2YgdGhlIHBhdGNoIG9yIGtlcm5lbA0KDQoNCi0tIFN0ZXZlDQoNCg0KPiANCj4g
T3IgYXJlIHRoZSB0d28gcmVxdWlyZW1lbnRzIGNvbnRyYWRpY3RvcnkgaW4gZXNzZW5jZSBhbmQg
bm90IGpvaW50bHkgDQo+IGZlYXNpYmxlPw0KPiANCj4gVGhhbmtzDQo+IA0KPiBFbGFuYSBhbmQg
VmxhZGltaXINCj4gDQo+IA0KPiANCj4gDQo+IEZyb206IEVsYW5hIENvcHBlcm1hbg0KPiANCj4g
U2VudDogVGh1cnNkYXksIE1heSA3LCAyMDIwIDEwOjA4IFBNDQo+IA0KPiBUbzogbGludXgtcnQt
dXNlcnMgPGxpbnV4LXJ0LXVzZXJzQHZnZXIua2VybmVsLm9yZz47IFZsYWRpbWlyIA0KPiBLb25k
cmF0aWV2DQo+IChNb2JpbGV5ZSkNCj4gPDYzZGM0YjVkLWM0NjctNGJmYi1iY2U1LTc0NDg1OTA3
Yzg1MEBpbnRlbC5tYWlsLm9ubWljcm9zb2Z0LmNvbT4NCj4gDQo+IFN1YmplY3Q6IFJFOiBjZ3Jv
dXBzIENQVSB0aW1lIG1hbmFnZW1lbnQgKyBQUkVFTVBUX1JUDQo+IA0KPiDCoA0KPiANCj4gDQo+
IEhpLA0KPiANCj4gV2UgYXJlIG5ldyB0byB0aGUgbWFpbGluZyBsaXN0LCBhbmQgbmV3IHRvIFBS
RUVNUFRfUlQuDQo+IA0KPiBXZSBhcmUgd29ya2luZyBvbiBhIHByb2plY3Qgd2l0aCBhIHNhZmV0
eSByZXF1aXJlbWVudCB0byBjb25maWd1cmUgDQo+IGNncm91cHMgZm9yIHJlc291cmNlIG1hbmFn
ZW1lbnQsIGFzIHdlbGwgYXMgZnVuY3Rpb25hbCByZXF1aXJlbWVudCBmb3IgDQo+IGRlcGxveW1l
bnQgb2YgUFJFRU1QVF9SVCBwYXRjaC4NCj4gDQo+IGNncm91cHMgaW4gZ2VuZXJhbCBjYW4gYmUg
dXNlZCBpbiB0aGlzIGNvbnRleHQsIGluIHBhcnRpY3VsYXIgZm9yIA0KPiBtYW5hZ2luZyByZXNv
dXJjZXMgc3VjaCBhcyBtZW1vcnk7IGFuZCBldmVuIGZvciBtYW5hZ2luZyBDUFUgdGltZSBmb3Ig
DQo+IG5vbi1SVCB0YXNrcy4NCj4gDQo+IA0KPiBIb3dldmVyLCB3ZSBkbyBzZWUgYSBwb3RlbnRp
YWwgcHJvYmxlbSB3aXRoIFJUIHRhc2tzLCBhbmQgaG93IHRoZSBDUFUgDQo+IGNvbnRyb2xsZXIg
d291bGQgd29yayB3aXRoIHRoZSBSVCBzY2hlZHVsaW5nLg0KPiANCj4gVGhlcmUgaXMgc29tZSBv
YnZpb3VzIGNvbmNlcm4gaGVyZSwgYW5kIHRoaXMgc2VlbXMgdG8gYmUgYmFja2VkIGJ5IA0KPiB3
aGF0IEkgZmluZCBvbmxpbmUgcmVnYXJkaW5nIHRoaXMgcXVlc3Rpb24uDQo+IA0KPiANCj4gDQo+
IENhbiB5b3UgaGVscCB1cyB0byBjbGFyaWZ5IHdoYXQgaXMgdGhlIGN1cnJlbnQgc3RhdGUgb2Yg
DQo+IGltcGxlbWVudGF0aW9uLCBhbmQgaWYgdGhlcmUgaXMgYW55IHN1cHBvcnQgZm9yIGNncm91
cCBDUFUgY29udHJvbGxlciANCj4gY29uZmlndXJhdGlvbiB0byB3b3JrIGVmZmVjdGl2ZWx5IHdp
dGggUFJFRU1QVF9SVCBmb3IgUlQgdGFza3M/DQo+IA0KPiANCj4gVGhhbmtzDQo+IA0KPiBFbGFu
YQ0KPiANCj4gDQo+IA0KPiANCj4gDQoNCg==
