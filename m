Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E005C31E4B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEC72084E
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="o8cgXEg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfFNNxy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:53:54 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:31178
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbfFNNxy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 09:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector1-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAB4brZEe4f5KMxyjNjrnwApGR/7l5Ji6tbBXmZfpcQ=;
 b=o8cgXEg4h1zWhCu7UacvaA5i9/AQ7tUSoaFLaNIHs99USTAYhD/5Fp2DXLyf344t1XRgtY77ITMJY3SZMqOMzRpAuhvNQk4+b5E+sY5yCCnTvSD+jSz7yhnJuqqUqSwkG+CFs9QzE94DDiPkeEbLYtWGDbmnd4WFeffeyxbJMAI=
Received: from DM6PR11MB2570.namprd11.prod.outlook.com (20.176.99.12) by
 DM6PR11MB2892.namprd11.prod.outlook.com (20.177.216.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 13:53:52 +0000
Received: from DM6PR11MB2570.namprd11.prod.outlook.com
 ([fe80::91ec:580:13d5:fe72]) by DM6PR11MB2570.namprd11.prod.outlook.com
 ([fe80::91ec:580:13d5:fe72%7]) with mapi id 15.20.1987.013; Fri, 14 Jun 2019
 13:53:51 +0000
From:   Joe Korty <Joe.Korty@concurrent-rt.com>
To:     John Kacur <jkacur@redhat.com>
CC:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/1] *** Make licence explicit for ssdd ***
Thread-Topic: [PATCH 0/1] *** Make licence explicit for ssdd ***
Thread-Index: AQHVIriZXs8i2duj20q0/rQaaoSqZg==
Date:   Fri, 14 Jun 2019 13:53:51 +0000
Message-ID: <20190614135348.GA4343@zipoli.concurrent-rt.com>
References: <20190614113747.11565-1-jkacur@redhat.com>
In-Reply-To: <20190614113747.11565-1-jkacur@redhat.com>
Reply-To: Joe Korty <Joe.Korty@concurrent-rt.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:404:109::13) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:c6::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.220.59.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970f7ec2-7084-40bd-e2da-08d6f0cfbb73
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR11MB2892;
x-ms-traffictypediagnostic: DM6PR11MB2892:
x-microsoft-antispam-prvs: <DM6PR11MB28929B4E127694BA57A4988DA0EE0@DM6PR11MB2892.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(366004)(39840400004)(199004)(189003)(66476007)(72206003)(66946007)(54906003)(6512007)(66066001)(25786009)(6486002)(305945005)(53936002)(43066004)(86362001)(6916009)(81166006)(6246003)(2906002)(8676002)(102836004)(8936002)(81156014)(26005)(5660300002)(73956011)(4326008)(1076003)(71190400001)(71200400001)(6116002)(3846002)(4744005)(66556008)(3450700001)(7736002)(66446008)(386003)(476003)(44832011)(256004)(99286004)(486006)(52116002)(64756008)(508600001)(33656002)(316002)(6506007)(229853002)(6436002)(186003)(76176011)(11346002)(14454004)(446003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2892;H:DM6PR11MB2570.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YvORdKDBJeO7AopAGGsIunufstBAFR7FhLBnSutKh+fjc1iDZoLZknRTJ5UjL7w/AvSa8bH1+J+EQ3MMNiD5slR32uz/zoOx0mhWF8q7kKsBp2ekf+BHS+Hwi+uQLYDe4DQVE77KlHg7XOgiwRh/D3yhuF2tEaY06FBm7Mh3h2LZZXL0wywrWFvKnzXFnKC26ZVt5hDsY6qiBwu9JXsqI5A9X/fbSd/dnfYQNJhPs0zTtxf3c9qX+3mtO9kPSdYUJYwpTPC12LJxwmSQfDexrkzp8HDOlsxpP4YKXUiGOMHJEZAqgv6u5/8cCi8m5c6FGNCgu8F4Wpb32qKr+G36mPpntjaRrteLvYccrpMaBxTSl7nBpsXgE/86KwZxUjeS9CfQPodUyK8CblHrIqojG4MiC9PxPPoOAakS+kZYZF8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56636E7B563E474D99137E859BA7A71F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970f7ec2-7084-40bd-e2da-08d6f0cfbb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 13:53:51.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Joe.Korty@concurrent-rt.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2892
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jun 14, 2019 at 01:37:46PM +0200, John Kacur wrote:
> The default license for programs in the rt-tests suite is GPL version 2
>=20
> Joe, I would like to get your signed-off-by for this, or please let us
> know if this was not your intention.
>=20
> thanks
>=20
> John Kacur (1):
>   rt-tests: ssdd: Add Licence information to ssdd
>=20
>  src/ssdd/ssdd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> --=20
> 2.20.1

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

