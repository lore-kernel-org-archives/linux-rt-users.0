Return-Path: <SRS0=lwXo=XE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950AAC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Sep 2019 07:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B62F21479
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Sep 2019 07:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ch.abb.com header.i=@ch.abb.com header.b="D6IBt0jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfIIHPb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:15:31 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:21590
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbfIIHPa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Sep 2019 03:15:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fca97H2gnLXkEdIi9f/fWx6jURAIvhUDgKlzy0hmF9JulEUX5yyO7sU2VU0zJaAG0r8AVBQovJNGqt91F/hjAh2XiBHy5BmUqnjR9Y96S08dsADc5j77OtNEJrlzwCErnAqAaDIqVzNIPByLsoZhnv3TqBmbH/TWBjldSZp2cmp0WFFW+v2XXa1csXxy9JbOwN0hx+YPRAzoUm5MTkp/y6yz8sHoItlVUeecY54VUKkjyk0oOV+xZCdvkzljuBwNTllYysqnxsffyPhHCKiJzbpcLWuclyYxNMHERKJCQdZ8JUE8w8Y+0FDrAGK001OjY4762VIi/N3tTTYEoQX4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFEotMUjChCohvluJY9ofBwMe8r8yJQ2LPqJazrppQk=;
 b=RquWlQgE4bKcrqvzg/aVzepidGWObke6KPU5l0DmzGMYdwAe8vxW+DleaVBxEE8+fepdqEaQ0FUK8OOmqJOeCAe5HK7pGdb6Uw9ocC8xc5cIdmZsnlXHtqcMZy70BfFNkKyNOHbINhOoxzeL6qRGo1D3nuO1Yj5kkYPNkmLzp3w1vsrIWTvYyoiEqGJRFxVz5XMP/QGfBOXjiIrt90WgO3hTguwwsPVh2MZ0gbllQRA8pznjoA7Sgj7X8ugYSDOhSif0xw1UpcafuAb/gpWt9DB6JZZ8zA90QnvM/neI40gZUP6i1lMV640c7A8V/iPLn5OpjgGflzAONIvGVSu6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ch.abb.com; dmarc=pass action=none header.from=ch.abb.com;
 dkim=pass header.d=ch.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ch.abb.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFEotMUjChCohvluJY9ofBwMe8r8yJQ2LPqJazrppQk=;
 b=D6IBt0jNfYLJ4Zlpz1e09Fhc3TJKPC2F6/wnGH2eibuHqotFdhgpvdpXHhmq/AdyjMQpGI2EkQICH3XkhQDordpFDFPU9vKHQV2yjr6niwHVzwdhKwBZ503LiiJN2iG9T1E06upHg9TDydXyjWb3KQ4ZfxOK1g7Dry0c/pqhvtk=
Received: from VI1PR06MB4462.eurprd06.prod.outlook.com (20.177.52.147) by
 VI1PR06MB5679.eurprd06.prod.outlook.com (20.177.202.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Mon, 9 Sep 2019 07:15:26 +0000
Received: from VI1PR06MB4462.eurprd06.prod.outlook.com
 ([fe80::a1b3:d59:ecb0:9897]) by VI1PR06MB4462.eurprd06.prod.outlook.com
 ([fe80::a1b3:d59:ecb0:9897%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 07:15:26 +0000
From:   Andreas Hoefler <andreas.hoefler@ch.abb.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: FW: netdev_budget_usecs setting below 1 jiffie leads to run
 everything in ksoftirqd
Thread-Topic: netdev_budget_usecs setting below 1 jiffie leads to run
 everything in ksoftirqd
Thread-Index: AdVmWY2x3A6uvpRkQUSUI1NLhrXgdgAhEHMA
Date:   Mon, 9 Sep 2019 07:15:26 +0000
Message-ID: <VI1PR06MB4462841C1BBE301CE41E17FECEB70@VI1PR06MB4462.eurprd06.prod.outlook.com>
References: <VI1PR06MB4462E7D2C5BDA4E8CF66D234CEB40@VI1PR06MB4462.eurprd06.prod.outlook.com>
In-Reply-To: <VI1PR06MB4462E7D2C5BDA4E8CF66D234CEB40@VI1PR06MB4462.eurprd06.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andreas.hoefler@ch.abb.com; 
x-originating-ip: [80.75.192.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3015d5f6-ede9-45d5-b134-08d734f57d2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR06MB5679;
x-ms-traffictypediagnostic: VI1PR06MB5679:
x-microsoft-antispam-prvs: <VI1PR06MB567931761D16097DB01FA274CEB70@VI1PR06MB5679.eurprd06.prod.outlook.com>
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(53754006)(6506007)(66066001)(486006)(5640700003)(6436002)(2501003)(14454004)(229853002)(316002)(14444005)(2473003)(9686003)(2351001)(55016002)(6916009)(76176011)(74316002)(8936002)(81166006)(81156014)(33656002)(52536014)(8676002)(7696005)(446003)(4744005)(186003)(5660300002)(86362001)(2906002)(476003)(25786009)(478600001)(256004)(102836004)(66446008)(64756008)(66556008)(66476007)(66946007)(71200400001)(76116006)(71190400001)(11346002)(99286004)(7736002)(53936002)(26005)(44832011)(6116002)(3846002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB5679;H:VI1PR06MB4462.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: ch.abb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1AsO1IHbKwWi8uGVM+3OY8bzhZGoB09JwDAneXQ6zdp4a4Kj8OdueC6u9MDqP2c9F+zqfAOmTMlz3fTZ35znddKIVy4TkdFYKS72lkyOg+QfpducIA3U9rVdMZRBs+1N+qpfsNpOXCr74Q9XoTuxigTU5vA6Tp/RwZbYF9DVjeWowvXbmnge5FVmUbxQ/W6PV3uh5FZ7c2PyRtUzrdPSiz3qoZNA/GdsEwBogShIq1tPVkrahFRVI7MFD2OEkU+j7jsFfPPIlrD7Lif2Ags0SKErosz8rL6Cror05D+X+F3n2S+LjYApXTdCefu3CHvTJZXVAjy9cg7UTr8ZZODTdeSKINMctfbvyFD2/KGx9zID6AK69WvTNeNgvnock4USqHYEnm7Mb3lUdIHX2kIlZ3RY4aOapN2eVKFwR1g4rTs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ch.abb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3015d5f6-ede9-45d5-b134-08d734f57d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 07:15:26.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVQsWonNcetU4/3vAafUcH3fcSEp7ea5yp1vMx74p1fWQ8jz1T2nis27lPdXR8PACwSxOz3dH+L5Nh2vpqCiH0nTgFEWjJPvnIc3+LNqlUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5679
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all

On 4.14.79-rt47 I have the issue, that when I check /proc/net/softnet_stat =
during receiving 4000 packets per second on the gmac (TI Sitara), the third=
 column (nr of times it ran out of budget) counts up like crazy. The netdev=
_budget as well as the netdev_budget_usecs are left at default. Although as=
 soon as I increase the netdev_budget_usecs to 10001 (HZ is 100), the count=
er stops.
As far as I know, the usecs_to_jiffies(netdev_budget_usecs) used for the ti=
me_limit in net_rx_action() will round up to one jiffie with my default set=
ting, meaning 10ms or am I missing something here?

Thx
Andy



