Return-Path: <SRS0=ghNa=5X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B05C2BB1D
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E519220644
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 10:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ch.abb.com header.i=@ch.abb.com header.b="e6BOiZxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgDGKWG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:22:06 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:25758
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbgDGKWG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Apr 2020 06:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp7FJQQnjduYsMyxwLsiYtcNNQSg3gtXUGUJgTruI19kQKM85IUxFiak7wIFFsJ9OaT+cxD58YYxeMt9nq3Al5Rw29cHNFDz7HFH55WVKOAUv9D2Y7edOggLloT+OrL7wuInzLdrpGN+QwLLJyqkAJP9adDzgYX95VDMDjmRHvGru5FwS4Lw71ALZDTsS8qZU8zd3R6UZx7NcuRI7shdgoQ1Cwn1B8mi/wPmMHN24jSHMKDsnjUortHVs54XUrzivGujt/RTWrMWNCv3Wf8VSXbZHKGb7+vr5R12cfrGPRv6oy/Cr5JD1p2Fe/YWW2fel4JvsyBAFtD/TxwgmLMVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L47xWH5bK/cprac1D+6Dirnn+UQg2LOlWWa0cRTxEUg=;
 b=OcV16+ULxhzaut7GJ0LSpZ8E+TFLLcdOcenCU8FcAGdAgXjEeB+QEjse+VW0Ak4QbnhUIlGQJvrH9PoV2YZ6gOcRZZrZdvYAD4CPfrhBe4tFGpa0UC6rzUrsbvFnRwEAGpGxpp0/280Vd2IiM6xH+QTTel2oab3WL81eUzHoQeESlhifK3JnDNe5yO+Jd62dS6S3kchLxwt+241VVaaUdI0EFwPvC7kVcLOe9T4QB405cDQG07bXNOH9Wcj9TrYBf65Gkpfjewej7EVLK8V70gLEGyj42cnixtoudLQgYK01wKygPQIRP/c30nGgRKYMB0/WN4qXDnQZ37w68NVCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ch.abb.com; dmarc=pass action=none header.from=ch.abb.com;
 dkim=pass header.d=ch.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ch.abb.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L47xWH5bK/cprac1D+6Dirnn+UQg2LOlWWa0cRTxEUg=;
 b=e6BOiZxOVsjjtmGqNiIybuinOQwu4qqYg6+LZj8mdyP2o4oFUcwa6L/xGkBSkWzrwIq+NGMBqDfGGyLX94UnTieL4ShiWxwEctvhcaKUiT1RXzlTiCgpef1zFBg1o9/6FbDGYhWjS1E4Nn+f9OgjEGvLpan2hqHmUDqWrVJdhUY=
Received: from AM0PR06MB4196.eurprd06.prod.outlook.com (2603:10a6:208:74::19)
 by AM0PR06MB6228.eurprd06.prod.outlook.com (2603:10a6:208:179::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Tue, 7 Apr
 2020 10:22:03 +0000
Received: from AM0PR06MB4196.eurprd06.prod.outlook.com
 ([fe80::b4ee:a825:3f3f:f2c3]) by AM0PR06MB4196.eurprd06.prod.outlook.com
 ([fe80::b4ee:a825:3f3f:f2c3%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 10:22:03 +0000
From:   Andreas Hoefler <andreas.hoefler@ch.abb.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: pthread_mutex_timedlock can not be used with CLOCK_MONOTONIC?
Thread-Topic: pthread_mutex_timedlock can not be used with CLOCK_MONOTONIC?
Thread-Index: AdYMxmD4jBgaKjiBQ9+IXU0k2O0pgg==
Date:   Tue, 7 Apr 2020 10:22:03 +0000
Message-ID: <AM0PR06MB41964EB6F36427417BDB3F91CEC30@AM0PR06MB4196.eurprd06.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andreas.hoefler@ch.abb.com; 
x-originating-ip: [31.24.13.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b46bd127-337c-4511-441c-08d7dadd8419
x-ms-traffictypediagnostic: AM0PR06MB6228:
x-microsoft-antispam-prvs: <AM0PR06MB62282D29C60DB709788E5A75CEC30@AM0PR06MB6228.eurprd06.prod.outlook.com>
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB4196.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(81166006)(52536014)(66946007)(64756008)(2906002)(7696005)(66556008)(316002)(478600001)(6506007)(66476007)(76116006)(66446008)(6916009)(86362001)(81156014)(9686003)(186003)(33656002)(26005)(8676002)(55016002)(4744005)(71200400001)(44832011)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: ch.abb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGz5zvg+n6ngHSlCAB6tROsdySZ4VMqBMco0TdKDwxbMNUK0Cx3Z66ep53uk42mbnYJ8cw2wtDu7psTBaIFXJcp7o5QdtdKGJTHUcsTZkQyPPRoBeC/ZXoyV+y/Nf4++Tkcggrrh2w9A3dOMTC5NBwkLvfaey+jcwl5rur8VVKa1BObFtaIFjCHukHrC6P7Gx1TzjIk+ykrR9L3IFTz/OMX8JPZFOY8vjU1CiefBMkDyRHk6uibOGfc+VzvY9c/3yS4xRvc7VCeheqLxBmu8SyRFVfu5TqubGnIZM82loW83mGnU2v9vGT+5NlWUi+ReA0Ku5WYDE2Fbi4O5Ogr4xII/1oga7rP5h6P5u4BZ0zDQFu7KJR45WVBVNdJLwkAE2jMjZhSsnt8zRQjmvUV4bUb9HyWWCx6y2bNGkgVA3HVmZw3ROJXXkrClp9pSGek6
x-ms-exchange-antispam-messagedata: ogWXfAaojeLDmqgoCN7ewAhG3yyFLlQeR/eE/FIo7SlTxoX9ZLEbD3MvGLSaxyDXzsAMy+r3LnMpjiS+JFJQHpZlK+WOjCZHYr7L2nETZnoxtZJGHT20Q9/3oWVGuLKJjuAAzPsyDreFK1P9fOTJHg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ch.abb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46bd127-337c-4511-441c-08d7dadd8419
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 10:22:03.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytjTjNXVSCqudH6HtGPqNYJtY3G+LIoFPYHCyTyUF5pgTATisvYHxUyQZCJ8z1j/4zq4RhMOpu0A5QRa/vKM+iCX9qxQtv63owUOIuixyWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6228
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all

I have a question regarding pthread_mutex:

Currently I am utilizing the pthread library. Everything seems to work fine=
 with the exception of timeouts when attempting to set the CLOCK_REALTIME t=
o a different time. This will cause the timeout to trigger later/earlier th=
an expected depending on if you set the time forwards of backwards, changin=
g the time is done by settimeofday(...).
=A0
The first attempt of a solution was to use a different clock (CLOCK_MONOTON=
IC), which works fine when using conditional attributes (pthread_condattr_s=
etclock in combination with pthread_cond_init) but unfortunately there does=
 not seem to be a corresponding pthread_mutex_setclock(MISSING) for pthread=
_mutex_init.
=A0
Is there an good alternative for pthread or can the pthread library somehow=
 be utilized for this purpose?

4.19.79-rt28-g5baf382c8f #1 SMP PREEMPT RT Tue Mar 10 07:30:26 UTC 2020 arm=
v7l armv7l armv7l GNU/Linux

Any help is highly appreciated.

Thanx
Andy




