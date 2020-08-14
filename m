Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA3C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 02:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244552078B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 02:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sQwBHpBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHNCVb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:21:31 -0400
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:61229
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbgHNCV3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 22:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqDTgXSkBxR0WauuaphhiNasgdRrql8GGfbj4GMASY4ItG0jFBhDloSfR6EAoz1hUqSg4ctWI1oleE6NPwt2OHjGp/tW948WBWhKafKJZFfF6jnzY89X4IR4D/JlBqx0yuyXF/WieiVb46YOSKGMG98I16IRMyYypzUO8chozMG3v/G3l2McKYl+yu0ekf6I71TGOesalBXf2cWfSaCcyFMIvc6x4S2evmR0+SZv27zhCihFIKiL3QvjUDR/PEQsVbvqVwzI8P0rV99DF/Xm1oQQufSKIu5NMDlvm608tcWH7p8uhGslG2Ba+fDol+mVg5z0dEmpOm5IPIim3Kxqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gfp+knbTQwzLrBn7hqZu/ywdhELwSAFwOwGGnDC2w8=;
 b=OwwRxmqshLZx6LvcBIFxAJibWdiWmfjbmX2tivcmJAj4hok7v/83Y1tHHVPiPAWnQdF+LnhQidegzC+czSS3PtVYpDUU8wcFJj9yKuaIZKGnjeZpE1vVW9KeUyDBr2N2hOA/PDeJq9+2YCpMPoaSE8xkKiTSpkFJ/rHg6SWZTGIezGBDQM3plJGG6kK9q3Vt0Z7+xqqKImkLdM8R0ZUD/53wM10Ow51FLb6C1wLLBXWnl0aez8c4E4RMO54Qe8uTVgTzI9xOfSQbXHfcZw0tJVS1W0GLXArKECZtWexwrJNFnY/9GTqW9VLmOJ6csbuO1b4fwLN/cQ5IoQK8pKzUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gfp+knbTQwzLrBn7hqZu/ywdhELwSAFwOwGGnDC2w8=;
 b=sQwBHpBLOJPXDfUPCtyOjQmMKcgGfAwtUDXiOIkuhq4WsK3grnXnEhj14d1aMh3YfZaF9MYK1BHqVtdh+A5fOR6/27DXvyB+5nK8Vathg3pj//3Tr7i6TUbCDMQNJIv2HnmCO3u8PtFbr6C+Yn8JTDFvsQevwbEkLi0vb1gat/0=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM4PR0401MB2402.eurprd04.prod.outlook.com (2603:10a6:200:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 02:21:25 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4%3]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 02:21:25 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
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
Thread-Index: AQHWa6gdrPnfNrtYpEW7p3l8OUGNa6k1YJYQgADMBQCAAL3KYA==
Date:   Fri, 14 Aug 2020 02:21:25 +0000
Message-ID: <AM0PR04MB4772BDE0787FD18E8E6A48C28A400@AM0PR04MB4772.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: be2c1992-9268-44a9-0985-08d83ff8beb2
x-ms-traffictypediagnostic: AM4PR0401MB2402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR0401MB2402C41378C31ED5531F7AB28A400@AM4PR0401MB2402.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxVAhDEcQO8Vp+ML8xpEOxatj5JVMSPA5niKAa5F3XuZgfUM8/pTKKfu23NhYZsIBNTU8Qbvqj3mYExpZ60Qy0WvuvGNJXXWlow7kksV+AkxLZpK2mb0esBx4lho17SpEbQI70EcGInshCsdqkQZfKyB6h6G/MBJUrCatH5/EI23bEkXN1olixQbMNczwpOGvVMqEisxn7booOywpaabrYD0hNnUqB2pP0LUWXjU4VUHhq++jQX9M2yaBhPvS3VOV6dzkiLXCEEFnCFQ/86NT+N5QnaRh4FT4jH7SE5gK2eJIY24qixm9AMtNzB2/OwSvLnnBP6efiPhliAtzZGMYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(8936002)(2906002)(52536014)(83380400001)(8676002)(478600001)(33656002)(55016002)(9686003)(53546011)(6506007)(316002)(54906003)(66556008)(64756008)(66446008)(76116006)(7696005)(186003)(5660300002)(66946007)(26005)(71200400001)(4326008)(44832011)(86362001)(110136005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +ypFkW2juZ5QANA/DO3yrK7iSsdTEF33yEGnPUaiELK0GgKusPAhHTWMtiinRtvOD5cFVDAUqBCT1kiI92c9Y213VF3KjR31w8cCXU9UTrmsJFxYGwUaBf0Giw6XTqM45UsCyFLZycCVq3z5Kv/1bTowXzo2IlvdTybbs3s8zA1BqjeIfb+tIMoVnpXARAxsyTavTyOGbDWtmcNic5I+ICTnfN//baOZhAn7MGX1wPiKkaZfO6EznM8e+Jof+rcP/KwF9eLhZjvjejcRV9ClRT+MNyFqDTXJMUu/QKTLSQvHeX1AmmlXw+UkXtEwyedTcIaRtBUgILRNVITQw1AP1rDKlRdaEgwgHKtK1XrH+74KpxD56476fowBRkbNA8RJ+LLqMjbt2L6V3JF79squ93ytO1SM+iALMYrN7guuIxPaL/z/307kh4A8+x9TLf4EY0wxLfNz8L847BJmBdhl3LdBPDeXCAC4O6Ofu5NIm+y2Bc9K3fWfHlSDPaAkkDIZR+nd1Cg05EAjbSAHrDtdk9ewXP3RrjyU9h3iOjfKHXnkcPXe2VyevgLUfgXxQQw6+AtwQaF2KTkq+Sbc9/mTo5S2aSN1EmPQcFfHdTxcZ/Q8aita9l+5Y0wxKH5hr2ZjlzotfmLgKuy7m4HtMwQc8g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2c1992-9268-44a9-0985-08d83ff8beb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 02:21:25.6303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20tLIU5P4Rrk/lcJkTEJjmmA6eLCyAMOsO+Bf2ADcT2SufA6xLdS8TODjZhl/PglrAR091PUYRuOTlVhn00rtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2402
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On Thu, 13 Aug 2020 03:03:46 +0000
Jiafei Pan <jiafei.pan@nxp.com> wrote:

> Any comments? Thanks.
>
> @Steven Rostedt, I thinks irq off checking is necessary especially

> This is probably more for Thomas Gleixner.
Thanks Steven.
@Thomas Gleixner, would you please review the patch? thanks.
Jiafei.
> for Preempt-RT kernel, because some context may be changed from irq=20
> off to irq on when enable Preempt RT, I once met a issue that hrtimer=20
> soft irq is lost when enabled Preempt RT, finally I found=20
> napi_schedule_irqoff is called in hardware interrupt handler, there=20
> maybe no issue for non RT kernel, but for Preempt RT, interrupt is=20
> threaded, so irq is on in interrupt handler, the result is=20
> __raise_softirq_irqoff is called in irq on context, so that per-CPU=20
> softirq masking is corrupted because of the process of updating of=20
> soft irq masking is interrupted and not a atomic operation , and then=20
> caused hrtimer soft irq is lost. So I think adding irq status checking=20
> in __raise_softirq_irqoff can report such issue directly and help us=20
> to find the root cause of such issue.
>
> I know that there may be performance impaction to add extra checking=20
> here, if it is the case, how about to include it in some debug=20
> configuration items? Such as CONFIG_DEBUG_PREEMPT or other debug=20
> items?
>


> Best Regards,
> Jiafei.
>
> -----Original Message-----
> From: Jiafei Pan <Jiafei.Pan@nxp.com>
> Sent: Thursday, August 6, 2020 12:07 PM
> To: peterz@infradead.org; mingo@kernel.org; tglx@linutronix.de;=20
> rostedt@goodmis.org; romain.perier@gmail.com; will@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org;=20
> Jiafei Pan <jiafei.pan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Vladimir=20
> Oltean <vladimir.oltean@nxp.com>; Jiafei Pan <jiafei.pan@nxp.com>
> Subject: [PATCH] softirq: add irq off checking for=20
> __raise_softirq_irqoff
>
> __raise_softirq_irqoff will update per-CPU mask of pending softirqs, it n=
eed to be called in irq disabled context in order to keep it atomic operati=
on, otherwise it will be interrupted by hardware interrupt, and per-CPU sof=
tirqs pending mask will be corrupted, the result is there will be unexpecte=
d issue, for example hrtimer soft irq will be losed and soft hrtimer will n=
ever be expire and handled.

Please wrap your change logs.

>
> Adding irqs disabled checking here to provide warning in irqs enabled con=
text.
>
> Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> ---
>  kernel/softirq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c index=20
> bf88d7f62433..11f61e54a3ae 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -481,6 +481,11 @@ void raise_softirq(unsigned int nr)
>
>  void __raise_softirq_irqoff(unsigned int nr)  {
> +     /* This function can only be called in irq disabled context,
> +      * otherwise or_softirq_pending will be interrupted by hardware
> +      * interrupt, so that there will be unexpected issue.
> +      */
> +     WARN_ON_ONCE(!irqs_disabled());

Perhaps: lockdep_assert_irqs_disabled() is more appropriate, and doesn't ad=
d extra overhead on production systems.

-- Steve


>       trace_softirq_raise(nr);
>       or_softirq_pending(1UL << nr);
>  }
> --
> 2.17.1

