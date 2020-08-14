Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D7C433E3
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DBE20715
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 03:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rSYP0Ptm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHND3C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:29:02 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:54478
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbgHND3B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 23:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvqBhBdEV64xGvBctVzeZsXUjyQ3uiM/35BLJKsc6ilqKpe2CplsRmxkUXe3xpyvXmBS7vYL865E+PE/TwuCRgEZ+H4jWeKQ0bKmNQxlusQmgAzA0/e/UvI+DOI6DhUCuXkRuNDpySNF8uYwE8Bwv6C0MtnbeuwBH7ibXgVDLLPDVJWHir6hwB+uhHI0XOMmdgpdDD837HIt05McGr03J5wyXSnhCPtTgNJVkv0+4s4fKDXJt3mJPwAx90u0VITHQGENhnISTwqiACOCuwW70gc1JdcxybsSZTaU0PvAG1FWZ+6XAmMmdBQOvPCZ++fNakr3f9AMYnWywL7uJl6veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eR/Y7GURvsUm4RJmxqoTvO9r4C6clW5odAvQd14ldk=;
 b=FziOgmtHKXIL085SoeorWZmLRYvDStJxNZXz8i9HbuGNhKI3rByNgdyY93SB/3i60MwrR2AYnX/22RLW6v2JVoW9GTAR82zRxZEM25/AS55EdeBY6HHplDYrbzbHCx9nNNZnjLkVmoSx8es95pe88wYlt71znXTbm/DICxzIoNFvoWm3ve+qhYx0CMwz6IdrkQ1vAdWexvXx3ZDcOlMOwsH9QKCsOoAVm8pKnxF/zB2AmJ2UnWi40b1Pd0cgW1rJ2Jr4gQOnED2brQ+t7SM2GUyMyH9xFzzHVbdFvuUeaM9Erw69h+8VZj+d/6ztvFh7WWl6c9IqIqjOypBWSoxo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eR/Y7GURvsUm4RJmxqoTvO9r4C6clW5odAvQd14ldk=;
 b=rSYP0Ptmv2ztVjaImNltrtjEk+tfwg7LTokL7O1haDexKFDh5mAAOtJJZQ6nH4RimYeAedYGlXfstK0ccJ5KN1L3MVVayhQ9STWC3xzTa4+TfJySxgfKOGw4C16RSRM08w/LaH+9jCIoiMY3m2qS+oUu1r8R6ER6uL65e6MXuLo=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR04MB6212.eurprd04.prod.outlook.com (2603:10a6:208:148::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 03:28:58 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4%3]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 03:28:58 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: [PATCH] softirq: add irq off checking for
 __raise_softirq_irqoff
Thread-Topic: [EXT] Re: [PATCH] softirq: add irq off checking for
 __raise_softirq_irqoff
Thread-Index: AQHWa6gdrPnfNrtYpEW7p3l8OUGNa6k1ljAAgAFoBhA=
Date:   Fri, 14 Aug 2020 03:28:58 +0000
Message-ID: <AM0PR04MB47726683A69EE5ED162A1D328A400@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
 <20200813055822.GC3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200813055822.GC3982@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8a51dab-171b-4846-8075-08d840022e8d
x-ms-traffictypediagnostic: AM0PR04MB6212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6212CED5B99EC607DFF9B0238A400@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(86362001)(9686003)(54906003)(316002)(8936002)(5660300002)(7696005)(6916009)(52536014)(83380400001)(55016002)(186003)(26005)(6506007)(44832011)(71200400001)(66476007)(478600001)(66446008)(66556008)(66946007)(64756008)(2906002)(33656002)(4326008)(8676002)(76116006);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a51dab-171b-4846-8075-08d840022e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 03:28:58.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wecn0xeWSXyEg1AhaYcqahl9KUobTBEJBiNwxfQZmyqUPex5t/CsQPymUcjs8M50vezrviO9SvKpwn0036u+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, August 13, 2020 1:58 PM
>=20
> On Thu, Aug 06, 2020 at 12:07:29PM +0800, Jiafei Pan wrote:
> > __raise_softirq_irqoff will update per-CPU mask of pending softirqs,
> > it need to be called in irq disabled context in order to keep it
> > atomic operation, otherwise it will be interrupted by hardware
> > interrupt, and per-CPU softirqs pending mask will be corrupted, the
> > result is there will be unexpected issue, for example hrtimer soft irq
> > will be losed and soft hrtimer will never be expire and handled.
> >
> > Adding irqs disabled checking here to provide warning in irqs enabled
> > context.
> >
> > Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> > ---
> >  kernel/softirq.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c index
> > bf88d7f62433..11f61e54a3ae 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -481,6 +481,11 @@ void raise_softirq(unsigned int nr)
> >
> >  void __raise_softirq_irqoff(unsigned int nr)  {
> > +     /* This function can only be called in irq disabled context,
> > +      * otherwise or_softirq_pending will be interrupted by hardware
> > +      * interrupt, so that there will be unexpected issue.
> > +      */
>=20
> Comment style is wrong, also I'm not sure the comment is really helpfull.
[Jiafei Pan] Thanks for your comments, yes, function name already indicate =
the function
Should be called in irq off context, will remove the comment in next versio=
n.
>=20
> > +     WARN_ON_ONCE(!irqs_disabled());
>=20
>         lockdep_assert_irqs_disabled();
>=20
> >       trace_softirq_raise(nr);
> >       or_softirq_pending(1UL << nr);
> >  }
