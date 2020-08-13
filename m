Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A15C433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 03:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B862E20768
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 03:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V49QSua1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHMDDw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:03:52 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:42240
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbgHMDDu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 23:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9XyYyemwiOM7SttEWTAs/cvNVMwlwA1VH3OIzbZVC6p+5fCc9HjZJ2O6grSxPPEOzrXaymY1jNOlFYVvECo/FsGGV6gzv/eYBnbxuigGAJ4Wj3WHu/e5HWS8MI88QJFItGtVOcQVHRSHmlAvzqjIv74Fiw82yrDfwilKzJ91m7m513mYljelVGS5XXZBaObqRIJ+9QMDcovZ84N+aTA1Kl9Gr8d9h9EOGAnLFcl670I2Y8TR5+1fuNeA5v21wCF3ALRV0TiWiCHZLH4hMdeHOCged6vBw7V6Q+LrNQ34BNCDQ5PueOKv1lFzZylCw6Qcx3HyHbcfyW5HPCOhhQAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLscaqRrm2LeDBt6Ws5XPqhwufiOKmtQcAbcFh+ywdk=;
 b=XZM4FgoEjzaFhKg8Rxm1ErGb3kxOVgcx4jZCzHp8zZ3ETZ/6rptwAlrIRkNQu21n5f7yoFhbUrf3xmIKPRW6rJEkh6MbZorzc6J8bbCcJZE8mU0uV6Xj5aF3+ZTPmzEYzL73DcIW4TG74UsKzcuyhjh2hRmz8dIoHUv+hcaJpmBW8mJE3y8lBlpQmR620LlNs6oBUlstA8Df4GNNllllF8LHpd8wekPzOFEeFgw5LuM7bxWswM/6RgB/xqk/ZC0mrE9WgZSoqvBreCRI/gcSe5IiqFefgDEh7s0gQuizF6rRv24zAiZFVEYm1LfCLxA5ShQP/0YhtMJxuohhqvUieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLscaqRrm2LeDBt6Ws5XPqhwufiOKmtQcAbcFh+ywdk=;
 b=V49QSua1krU1AwN9GxieYGveJ8Y7pdbeDBZ///Jz4xw1wqiEVb+VxtMVdFomIPoCFx2UA8x9Bb6LioVF/Zrnway5/ZMSUIfVxDOzDOfWEDYGSpczz/668eaa81g60TsJNYwSZjZzZVRKy3Rw0fjomOUTy4aJ85Iii4K1iXd1vqs=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR0402MB3441.eurprd04.prod.outlook.com (2603:10a6:208:1a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Thu, 13 Aug
 2020 03:03:47 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4%3]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 03:03:46 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     Jiafei Pan <jiafei.pan@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff
Thread-Topic: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff
Thread-Index: AQHWa6gdrPnfNrtYpEW7p3l8OUGNa6k1YJYQ
Date:   Thu, 13 Aug 2020 03:03:46 +0000
Message-ID: <AM0PR04MB4772B1B6D3391BAEAD4411808A430@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
In-Reply-To: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd12a398-837a-4840-5b85-08d83f357edc
x-ms-traffictypediagnostic: AM0PR0402MB3441:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB3441108374408C403229E2A38A430@AM0PR0402MB3441.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5F+OXgHJjOIkwxdq3ypFjC9UYYofPzG/I/MtV0O2GBvNsu8hhrIZe2ciyLUUpmQIBKLURvsBfJCiw0tbbXOVCHrLa69kVq5dreNGgrn+m8eBv2T4LwlQpcscj5mYR2t2q9ydw0vcLzJxjPXrs1I7tic/XffnxEZybFcZGMy/2vVL23SwrtlmSTWL6FOFzkktKSJMB3o6A/H4IPfZhNpeSZIuXbhgnU0PhdJR7taJoWn4qHitzR2K5V8TePuLPrn4tgBuOujTgSlvZ7PRchpJDeaz8wrc9oAur9RFFxNsCo71G+gCr2oCZRij+GYvV6WlPUbQH6pznjFxkHpRuQfJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(110136005)(316002)(64756008)(8936002)(66446008)(66476007)(8676002)(66946007)(76116006)(71200400001)(66556008)(4326008)(54906003)(53546011)(86362001)(52536014)(7696005)(33656002)(2906002)(83380400001)(478600001)(55016002)(44832011)(186003)(9686003)(6506007)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FOa6kYynldgqn+V2fuvv69YndPOIpMNOpOPN/Ytaas2fYZFqJPB8VbbqQpolWiCtoXh3aiK4KItm+mYOrEQDbDzlxNEJ0mydyX4NDd9fkMT6wvKglgOgvvgxuiy92PHEkZt1ZTstoQEr9knMnoU1yKKnBFC0UKH1c4zCbypXiK1BuvqWhW2yfs2CZwMw6tji3CVFXKLhYtw/G0koV5Zr/SJZRPNMzTEv7D1Waid0A88p8XG449yot8iMiHl2o3rjpIcR0RUcjoq05qGXuVZZjU3Vvbu8YVdcUh+Kb7zmEr5IYzvoVA/gLCrS8TH4330F+cSr4EU5em+i1o1DMaJaB/vh2oqwQlvnN8yVZH3CmI9A22/MwumpMCorNVWKafzAX+QHGSFyLdKVJsRjB7tS+nGe/2DR8jgQB5lei3ZgzrxdOnexvSWER0Lf1m/Q98LMp+8EbpNioJYtmDQb/O8CCAcLO3IGRuXpSYqPVYrSW8El2vUZyER9B5fSH6rT6K8hqFMZEICO0bQTweXTJnhRTBnoQl0Xx6IbMpPjcaod8+0siJaQPdZSkvN28MnfCOXA2URgCQkprWQbFZgSm6Axf1bkVX6GfzvCe3ooV9B0WzyOxfrNK0SVNW4CoJn0ze0oUa8aQic5YGNo0FetpPj8/g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd12a398-837a-4840-5b85-08d83f357edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 03:03:46.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +k3qJv3LyQrWMc53kn7J2UsWmQgB0UKtp7a/RrIzYGq2kDntjKJd1ImNnTzgdkO/ZZjzY9XOF+Ug5qBsi7WuTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3441
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Any comments? Thanks.

@Steven Rostedt, I thinks irq off checking is necessary especially for Pree=
mpt-RT kernel, because some context may be changed from irq off to irq on w=
hen enable Preempt RT, I once met a issue that hrtimer soft irq is lost whe=
n enabled Preempt RT, finally I found napi_schedule_irqoff is called in har=
dware interrupt handler, there maybe no issue for non RT kernel, but for Pr=
eempt RT, interrupt is threaded, so irq is on in interrupt handler, the res=
ult is __raise_softirq_irqoff is called in irq on context, so that per-CPU =
softirq masking is corrupted because of the process of updating of soft irq=
 masking is interrupted and not a atomic operation , and then caused hrtime=
r soft irq is lost. So I think adding irq status checking in __raise_softir=
q_irqoff can report such issue directly and help us to find the root cause =
of such issue.

I know that there may be performance impaction to add extra checking here, =
if it is the case, how about to include it in some debug configuration item=
s? Such as CONFIG_DEBUG_PREEMPT or other debug items?

Best Regards,
Jiafei.

-----Original Message-----
From: Jiafei Pan <Jiafei.Pan@nxp.com>=20
Sent: Thursday, August 6, 2020 12:07 PM
To: peterz@infradead.org; mingo@kernel.org; tglx@linutronix.de; rostedt@goo=
dmis.org; romain.perier@gmail.com; will@kernel.org
Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org; Jiafei Pa=
n <jiafei.pan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Vladimir Oltean <vladi=
mir.oltean@nxp.com>; Jiafei Pan <jiafei.pan@nxp.com>
Subject: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff

__raise_softirq_irqoff will update per-CPU mask of pending softirqs, it nee=
d to be called in irq disabled context in order to keep it atomic operation=
, otherwise it will be interrupted by hardware interrupt, and per-CPU softi=
rqs pending mask will be corrupted, the result is there will be unexpected =
issue, for example hrtimer soft irq will be losed and soft hrtimer will nev=
er be expire and handled.

Adding irqs disabled checking here to provide warning in irqs enabled conte=
xt.

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
---
 kernel/softirq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c index bf88d7f62433..11f61e=
54a3ae 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -481,6 +481,11 @@ void raise_softirq(unsigned int nr)
=20
 void __raise_softirq_irqoff(unsigned int nr)  {
+	/* This function can only be called in irq disabled context,
+	 * otherwise or_softirq_pending will be interrupted by hardware
+	 * interrupt, so that there will be unexpected issue.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
 	trace_softirq_raise(nr);
 	or_softirq_pending(1UL << nr);
 }
--
2.17.1

