Return-Path: <SRS0=ggjn=6V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE68FC38A2A
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 May 2020 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FFD20870
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 May 2020 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mobileye.onmicrosoft.com header.i=@Mobileye.onmicrosoft.com header.b="m+5K5DCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGTIZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 May 2020 15:08:25 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:50561
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbgEGTIY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 May 2020 15:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUenU94O+bdwnqlYionvtiq7j44qEz33W130EuprXYQ2c6tNjwAI8jWZ21QOB27H4zn0QpmfI6urDc1BGQ559k7Gd4HKKio0iDoj4T/MAb2qkJNGYdP061Y8UCJ09SggYkIiJQid3pGSEZg1waasIjMnx2oQX7bTYW5QmGK6zcObUqo1Px3CCoLGmeRV+KZ9hLAk1yRhcb9ZrASfWKnjcrN1yTkvYC1BzvZkJAQlcWbZPPPOsxrS1V6/IBD1oXwcUuN3O7AsAtK3+nKfluu7QVn8loEqMsUH0uVfRj8PMJFyRZr9dOA7BEkLnibOUenY7U3fTveI2XEYj2QB+Nzyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh5w2wmeyGPS4Ujmpx04eZZ+QtVqw7PIY2grsZvYnwc=;
 b=GIDgr5BmRZgqRF5fHK5MjQ9Cu58VCPqmorsl5O08SgJQ2g+bc3Q8ufZVKumSW+Xr4khTk5CEYtEKSzios8GaaMFykel/WyvnRP9iVuTvA5aE6vQle3T2iqn++2E6Vq+E6opt+79TLcPdZ8QS/0EQP13LkhaPNdAt2cW9kqCQHyBvKUxHXdqXl5USKfElmqgqKzu++okTVs3wc8XjBIgBIme/D3RbA/uxHGPi37lWynFIde1pSJwP+VtiNw+r/q+ixTVFkWhtaeMCF0GN2bruXadC1PRdAQ77SoQMQzY2KVnBi6YAfecvs1OkbPY+sVr41iCtyfDUd0aQvtbYlk02cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Mobileye.onmicrosoft.com; s=selector2-Mobileye-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh5w2wmeyGPS4Ujmpx04eZZ+QtVqw7PIY2grsZvYnwc=;
 b=m+5K5DChtqsz/QCIGFeWkWO1sdSUedjiddYw9twMNk5/Xx8z5SElDPFyfcXNEgAq+6RSDv5uF0ujtyZAA8l0LNS5P/cvcigMfCVzcl6LEcQpRjhNyn2Mo/+f9Xx9yelOGE0yeNnt0IUGhEd5rhCWjXcNcMj2emheiynLf0TPUGE=
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com (2603:10a6:208:181::15)
 by AM0PR09MB2259.eurprd09.prod.outlook.com (2603:10a6:208:e4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Thu, 7 May
 2020 19:08:21 +0000
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c]) by AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c%5]) with mapi id 15.20.2979.030; Thu, 7 May 2020
 19:08:21 +0000
From:   Elana Copperman <Elana.Copperman@mobileye.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Vladimir Kondratiev (Mobileye)" 
        <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
Subject: RE: cgroups CPU time management + PREEMPT_RT
Thread-Topic: cgroups CPU time management + PREEMPT_RT
Thread-Index: AdYkm/M/lU1yRRU5Sia9bqNtzqcgHQABswyw
Date:   Thu, 7 May 2020 19:08:21 +0000
Message-ID: <AM0PR09MB3794E9CFE8BA31852B712DAD99A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
References: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
In-Reply-To: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mobileye.com;
x-originating-ip: [134.191.232.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a117efe9-c551-4ff2-171d-08d7f2ba028e
x-ms-traffictypediagnostic: AM0PR09MB2259:
x-ld-processed: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa,ExtAddr
x-microsoft-antispam-prvs: <AM0PR09MB225963D04D512A76834ABEDF99A50@AM0PR09MB2259.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YmfUTeXxJYxH15sH0eKEGuRJErzjEjmHgjqIdB/Woe4F03rLcgG4SIWgXXsdPwIgIyCrTkSQuK0zWosfm9kiZgj3K+8d0hlSZcDCJqhSaFbuM4dZhfUaBcGfZ1KCq3rOuc3mzxcgsURbaW8+2AocL4Z+jZiR4H6Q5Gd8SiXOA/jglDmeSkgARgTKu2/O8LAGBBpHJFo8DMfZZC+3XBAXMPF+bQrQYmS+IJR7bQmVxrglQZr+To7hq35N8jFU/TiT5aVKCJ9nfBNzoQV3jZg4RapQCSTEfNJmCJ4Q3SU2QEgwnSLRRjOfACsTEE6HFdEDVs7/bladlGPgAoJtfHFNewRXl2gCGH8H8zbbEbEQcyq/iriIpRWtwU9uZzHKktXLHNKET1ycGVkAvmSMkzWV7azOCOe889TusjdpgXgslhEuHkgS01+lgw0+lcnRZ4l6qEjcI8Lkwf5KIprHZi1sHh4kgNKHKuSIw9ZNJlQEen3v7p5vc67PX6GA4unC/czqC9K6jK8A86wKrdaNjoy2iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB3794.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(136003)(346002)(376002)(366004)(33430700001)(52536014)(186003)(110136005)(26005)(66446008)(64756008)(66556008)(6506007)(86362001)(66476007)(66946007)(9686003)(2906002)(4744005)(7696005)(83280400001)(83310400001)(76116006)(83300400001)(33440700001)(83290400001)(8676002)(33656002)(55016002)(478600001)(83320400001)(8936002)(2940100002)(5660300002)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MCfkHytAM0yaj6ZDUNVpS74kxddFtz6LXbZXvhRJ3PkS72o3nlyRmDoIxAeugtsYkW/Ze3bT1ko7D1gEQWuFdO76f3zxJnBIkfKQiYMaZucpqKRfr3YsYztGRq7N1zWclllYjxar7oOdGPLvbzkSsbCY0Lm6tdeZxmpxiYZcsK2ANHsUroWaJ1hN2Y8xQpXwsaiOSH8PvU5jmbvRoDpuycce7CWddmZdw5TuPuMDIMAPBdJpOkO69fWYqql2fy6KIm/njyB9h0I2ncUaBxdS15aC9Du8/iCgGitlMC2Je7y1qx1dKAZ7ig4fsnutWVn0ZRjQntAZA4hOY2H/aMIdJvGtf2MYjLv342kpEPGUVzmlWf179LqIaetF6L+BbUF8AzTJeOB/iH+DfXjuQgE65s89PTEVVsYmCNz8RAitz7LWIFhmYVsZMQ2Mvw4AqwEBUMoYCdACcOvaoZJgNC2OVag36GjHLocErTJxLsTSAOS6pP5Y76/d5tNDWnoimafSvm+fCSHyUxMnC3kBfG/LEmaivZBIPIry7YRfwCwnzJINtInYtnZXBSiv1hRIyen2DG0TQEyaqXk2N03T9PVPJzzmTaBvabUhgTORjmVmRxMv8rLW8rKHBoYp11Kcd5WZHJKbS3NzPbuYqLixB0G9/r0bBoNZEEgyiakjr8woHmKQPTWHbzlOE9cC6aFxEFIz/50WJ8KmZ8Rc5BQc5PZiGNbv5UQuBo39eyv/CUnJjQmXVKXjtIa4LVq0aSLTr/d8M93ZdtwK8vEhayjPXGEFfz91hE9Ghd0ygQRt8lyLLXk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a117efe9-c551-4ff2-171d-08d7f2ba028e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 19:08:21.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5j1X1mIS7oITM4eQqpqv8ejfGqecv6fvIsnVQSUIpanfphfGhJaAD4ewgA5tlW61TdtQV0TaIm1mMcae5Yws7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2259
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
We are new to the mailing list, and new to PREEMPT_RT.
We are working on a project with a safety requirement to configure cgroups =
for resource management, as well as functional requirement for deployment o=
f PREEMPT_RT patch.
cgroups in general can be used in this context, in particular for managing =
resources such as memory; and even for managing CPU time for non-RT tasks.=
=A0=20
However, we do see a potential problem with RT tasks, and how the CPU contr=
oller would work with the RT scheduling.
There is some obvious concern here, and this seems to be backed by what I f=
ind online regarding this question.

Can you help us to clarify what is the current state of implementation, and=
 if there is any support for cgroup CPU controller configuration to work ef=
fectively with PREEMPT_RT for RT tasks?=A0=20
Thanks=20
Elana

