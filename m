Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDEEC433E1
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 04:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74DB20708
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 04:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="arLxz/Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgHNERZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:17:25 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:43143
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgHNERY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Aug 2020 00:17:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2MiIZgvChV+atjSriUQzc12qBJpuAPUh1HTuLDcFDKTYqWvI/V+d08COUbxtEyQ26SfS76x6mGdJIWCh9F8uMuIjpxdGXz7bHEGZzOEPojjKLBpXWJ1CNJzMGZrwHLabQJmjKYZJoEzzGrhYwU8/MgxD457L7wlombAuJLODAY1fV9VXQ3Znj14RdHtOUgv0cRLpulzoRJoxhvKt5/n+HIC7riWuqBKpLAddPRFXlHJBme9Tg6Oi6S6JwWRRNRMCs3ykGcAilAi/Optg/yMp7pCGKCRywd8VGGvHxqWPlI2s3MJpZ1g6Aw0PmnjV7NB0oVOhDsGaNhNd134wZmDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNIzHwoms5ymuJW8SJ65vCLgTZBFIHTctNu0hC8KzUg=;
 b=KMFczt6kY/kArah+cQp6UdMEc/O6cl3Qkw5clkrEysO9FAP5D6mOlW/VyGnkenJRRWffUhLQ1VOX98HmrA2nVMfWyicgd3xLRjMAhAQVXvSyyBvywFmwVvyKMF3T+doiyT+do0Ah4tqStlTJ2oHGHk2cHX1Qn7u5xPjiOFmWO6prG5EZNouUHg/tPo9vMJeme52/YkyFVSeKgLCXDWPing0B5Orli1e5YemIV2023zvu0NFgixX+X3fe9XxaFTNJDSvkTX3thrSkMo6UxvKPTBdwys6f7uoUJnNZJY55TcN9nLJx3pEXBj0RubviS6zlaR9Uy1hu8PlZpKlwymZpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNIzHwoms5ymuJW8SJ65vCLgTZBFIHTctNu0hC8KzUg=;
 b=arLxz/FqcK2WYEX/+5R8LsmG3IMveJcyMSyi1ezN7k6cXBdZtkx3T3mRjIUIQqLO0+JOKU8ArjN7j416FdFXuLPd8EA/B0VmyG3dRmWJSQpjJPrCdDuFpHpMiNepUL4rHBkgC33j2PP1rjiVl8gMz2aJ6TasM0kW1HhRcdNE65o=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR04MB6898.eurprd04.prod.outlook.com (2603:10a6:208:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 04:17:19 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4%3]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 04:17:19 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHWa6gdrPnfNrtYpEW7p3l8OUGNa6k1YJYQgADMBQCAAN9u0A==
Date:   Fri, 14 Aug 2020 04:17:19 +0000
Message-ID: <AM0PR04MB47728EEAE7457ADC1F29F47D8A400@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
        <AM0PR04MB4772B1B6D3391BAEAD4411808A430@AM0PR04MB4772.eurprd04.prod.outlook.com>
 <20200813105644.1eb6f2cd@oasis.local.home>
In-Reply-To: <20200813105644.1eb6f2cd@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9038b64-2334-4bc5-aed9-08d84008ef52
x-ms-traffictypediagnostic: AM0PR04MB6898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68983AE48477A755FFE279618A400@AM0PR04MB6898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbC9grVfG2SEtZoXWkVEavlLQWjn1YWcZ97YuhyyFHivHHdAEW2UOQmZTl4LzMWNWjvtX8RL0lhaszd5LZbzNEFgULlKPqP3VH7CLLsxXRKXMhHB5ZdWlN9/z5zRb83k4wBDxgKnwm8veS5WNv0YX0NZqIFX4cXE3ckyB9pQJzrxK7th9Flb3+/PebDDjB7a8Rgj4pZJOeQG/AW/h26X50+5XRve4NB5M6qWZufyGiGK2vmdjw4gCKVun/sMACF9N+WpJ7KcsR2OSiSLxzP2hZqQDXChpKFYu4MMdJ0HDhWU+25aEvnSKas5bV+Xy5f8DtIb4s8B/tMt1j8HV3sy9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(71200400001)(7696005)(26005)(9686003)(44832011)(8936002)(8676002)(6916009)(83380400001)(86362001)(186003)(478600001)(52536014)(33656002)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(55016002)(4326008)(6506007)(54906003)(316002)(53546011)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dX4NalV65Xs6nrFMbaeMWbIgi/Ffd9TrydYqjQ0IafK1VcJEsfDpiOaP3KwuaAEm6mXuA/zZKPjTYUmab3bOk5PFAz9qtXHq+VkuSImHc5C3SjCtXKWNcHsC9PQNZSXSHxEyub47NQ23afaRy8BONZawiN04muZx7qiWgZUjhDnRoM8ZBvS1wlDhU9g/E6ALv/zhArh+WQtKu2PFuLUokvrhKnXGlHD0KhNf9s09IsLGPlbxgiBbljz9TsixBCf+UdvVP7RR3vVRCO3ipd19hsPH2QFJf5lQUCYPJno49/wAauHHLZVeM6JC0wKAWdNK4zaLVprUICj+b8pTBt2dE8vtVuqJZtH1ysUhF8tvfRGnvFFMHSdbynzRlHTBMZuyLnFEhznd7vkCxuj19wkK91miE6bC6RpFfGdNNkpDZV4T4+40v4fzKqb2WB0HnrxHvjkpmwnb7r/oXsN0mJ+Qk9KYFU1Mm2fOQHw8t8smTIeCVqwyjYNVLYL/T5OAeB+tN1JiW/g+s/JIEJ8ufvr0cePDS5rCl69wwXZ5/Vj5Jr4n25MEBrXAC/0EEYKfwav6+BR4zYJ3Lbcf4rf/TKles+v+XsMjueFq+JOMD7wZ7X0T3K9lrmTVbb3UCeBAvakSzj/7nO+y+FhJf9/OfKesew==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9038b64-2334-4bc5-aed9-08d84008ef52
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 04:17:19.0665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HX8UUanWhVomwwOi5EdcPOWBiKhAUDCJ+uSZDdobgqB8zenlQxa4f9DgDgYsuVrlFWhUr0vrshtUOg1x6Ocleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> From: Steven Rostedt <rostedt@goodmis.org>
> Sent: Thursday, August 13, 2020 10:57 PM
>=20
> On Thu, 13 Aug 2020 03:03:46 +0000
> Jiafei Pan <jiafei.pan@nxp.com> wrote:
>=20
> > Any comments? Thanks.
> >
> > @Steven Rostedt, I thinks irq off checking is necessary especially
>=20
> This is probably more for Thomas Gleixner.
>=20
> > for Preempt-RT kernel, because some context may be changed from irq
> > off to irq on when enable Preempt RT, I once met a issue that hrtimer
> > soft irq is lost when enabled Preempt RT, finally I found
> > napi_schedule_irqoff is called in hardware interrupt handler, there
> > maybe no issue for non RT kernel, but for Preempt RT, interrupt is
> > threaded, so irq is on in interrupt handler, the result is
> > __raise_softirq_irqoff is called in irq on context, so that per-CPU
> > softirq masking is corrupted because of the process of updating of
> > soft irq masking is interrupted and not a atomic operation , and then
> > caused hrtimer soft irq is lost. So I think adding irq status checking
> > in __raise_softirq_irqoff can report such issue directly and help us
> > to find the root cause of such issue.
> >
> > I know that there may be performance impaction to add extra checking
> > here, if it is the case, how about to include it in some debug
> > configuration items? Such as CONFIG_DEBUG_PREEMPT or other debug
> > items?
> >
>=20
>=20
> > Best Regards,
> > Jiafei.
> >
> > -----Original Message-----
> > From: Jiafei Pan <Jiafei.Pan@nxp.com>
> > Sent: Thursday, August 6, 2020 12:07 PM
> > To: peterz@infradead.org; mingo@kernel.org; tglx@linutronix.de;
> > rostedt@goodmis.org; romain.perier@gmail.com; will@kernel.org
> > Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org;
> > Jiafei Pan <jiafei.pan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Vladimir
> > Oltean <vladimir.oltean@nxp.com>; Jiafei Pan <jiafei.pan@nxp.com>
> > Subject: [PATCH] softirq: add irq off checking for
> > __raise_softirq_irqoff
> >
> > __raise_softirq_irqoff will update per-CPU mask of pending softirqs, it=
 need
> to be called in irq disabled context in order to keep it atomic operation=
,
> otherwise it will be interrupted by hardware interrupt, and per-CPU softi=
rqs
> pending mask will be corrupted, the result is there will be unexpected is=
sue,
> for example hrtimer soft irq will be losed and soft hrtimer will never be=
 expire
> and handled.
>=20
> Please wrap your change logs.
[Jiafei Pan] Thanks, will update it.
>=20
> >
> > Adding irqs disabled checking here to provide warning in irqs enabled
> context.
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
> > +     WARN_ON_ONCE(!irqs_disabled());
>=20
> Perhaps: lockdep_assert_irqs_disabled() is more appropriate, and doesn't =
add
> extra overhead on production systems.
>=20
> -- Steve
[Jiafei Pan] Thanks, will update it.
>=20
>=20
> >       trace_softirq_raise(nr);
> >       or_softirq_pending(1UL << nr);
> >  }
> > --
> > 2.17.1

