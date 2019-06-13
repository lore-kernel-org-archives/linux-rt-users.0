Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E5DC31E49
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F41D2080A
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="qJhmOfUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfFMQyC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:02 -0400
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:39904
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730069AbfFMC5N (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jun 2019 22:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOedVLC6fU8X8QNfUdRw+8M+lp0IdYj0tJJjZUzq8FU=;
 b=qJhmOfUS+2h5h1w9ZAq34PaBVmJlWF2iBr6HJQaHF0WrSWFlpbI12w3YEnM3SBG/4KToHp25qTwxAYWoH9jAMOVtqdHbp1a2y4kfIJKu/HUf7ueZhCHErskBlSNTnTrBM5quItLOkBS3n/lPaWw3lFwJesUUtrvQg72CHYe79fs=
Received: from BYAPR05MB5878.namprd05.prod.outlook.com (20.178.50.75) by
 BYAPR05MB6392.namprd05.prod.outlook.com (20.178.232.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.5; Thu, 13 Jun 2019 02:57:10 +0000
Received: from BYAPR05MB5878.namprd05.prod.outlook.com
 ([fe80::984c:33af:290b:c712]) by BYAPR05MB5878.namprd05.prod.outlook.com
 ([fe80::984c:33af:290b:c712%7]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 02:57:09 +0000
From:   Tiejun Chen <tiejunc@vmware.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: Real-time micro-conference proposal for Linux Plumbers 2019
Thread-Topic: Real-time micro-conference proposal for Linux Plumbers 2019
Thread-Index: AQHVAXzgmJ1jlyvGPkKtdSwqQOzUl6ZgqmNwgAHMCYCACDdc0IAAcUkAgC4EkEA=
Date:   Thu, 13 Jun 2019 02:57:09 +0000
Message-ID: <BYAPR05MB5878B6B2C3B604BB38126404C5EF0@BYAPR05MB5878.namprd05.prod.outlook.com>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <BYAPR05MB5878261BB896A489AA521A65C5320@BYAPR05MB5878.namprd05.prod.outlook.com>
 <02b2eb1e-b88b-3ade-1e0d-741bf92939b1@bristot.me>
 <BYAPR05MB5878B8AD281E40A522996975C5080@BYAPR05MB5878.namprd05.prod.outlook.com>
 <19fcfc0f-ea80-1e60-7fb6-f2e40ccca957@redhat.com>
In-Reply-To: <19fcfc0f-ea80-1e60-7fb6-f2e40ccca957@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tiejunc@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b641efd1-cc82-46fd-79ef-08d6efaad401
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6392;
x-ms-traffictypediagnostic: BYAPR05MB6392:
x-microsoft-antispam-prvs: <BYAPR05MB6392EF3355073B9C53ED4325C5EF0@BYAPR05MB6392.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(6506007)(26005)(102836004)(3846002)(486006)(6116002)(478600001)(7696005)(8936002)(8676002)(186003)(11346002)(476003)(81166006)(446003)(7736002)(74316002)(561944003)(33656002)(81156014)(305945005)(99286004)(2906002)(316002)(86362001)(76176011)(110136005)(2501003)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(73956011)(52536014)(68736007)(256004)(25786009)(66066001)(71190400001)(71200400001)(53936002)(14454004)(6246003)(55016002)(6436002)(229853002)(558084003)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6392;H:BYAPR05MB5878.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gP6A89LYLjoie//H5iHjkv9SdlHpD4/sFB1Yd5IBmj4liG5YdDUYmr6/N02ItONk1tjGfS/ew58Ltq+0QMVQiVA/2u4gKnl2WgBdlbK6knTfL7IgNhXgupu6D7KHfImh0/E5KpX0YFn9Ov4Cm58DNr32kzqOdswgXMko5xcTvr0RiGBWCVrVgD1xli7TGEbcrrrea0nbNFCWP1ty6in8/ZkGznHd+QDUyifo/4v7OvOpesFkF2z0u1IkpKuBoJg1vcUYgH9j/EJA/dVk9l4OFwP4z9SqwBqk4Ebad49fWm0gw6P84BgVySzM7qWXjqIGiJzZSzPg+wnScEkfdhTaUkLScvRCwU1A5jhcF1nZFQzX61YNO5CUQN3nL3yfOUOpa71HJsH03V5siN4W9XNhJirpEZHczlKCaS4k1vG6Qe8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b641efd1-cc82-46fd-79ef-08d6efaad401
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 02:57:09.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiejunc@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6392
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

RGFuaWVsLA0KDQpIYXZlIHlvdSBzdWJtaXR0ZWQgeW91ciBwcm9wb3NhbD8gSSBjYW5ub3QgZmlu
ZCBzdWNoIGEgUlQgTUMgdHJhY2sgdGhyb3VnaCBMUEMgMjAxOSB3ZWJzaXRlLg0KDQpUaGFua3MN
ClRpZWp1bg0KDQo=
