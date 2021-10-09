Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77CCC433F5
	for <linux-rt-users@archiver.kernel.org>; Sat,  9 Oct 2021 16:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9274760F4A
	for <linux-rt-users@archiver.kernel.org>; Sat,  9 Oct 2021 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhJIQvN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 9 Oct 2021 12:51:13 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:8348
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229624AbhJIQvN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 9 Oct 2021 12:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgLOSjOPvE0ZysqwWtWBVdfjddt0SpFBhgez9RoTjRw4MsFq12LBTNijtruZcMQS5DyQuUzKkq3QeMdFyPfBKhDLNRPpzpEMh+z1yo8bqzoowr4D4T3yJGYr3DbPduPz6nijLeCf0TryuTw8h15Df449jIcaghNbKcEg6PsnVLY+FJa3CWfBjBx031nXbaUCog2kiMcacfKWoB1wxl2NbBa74AyoMnCdBKnYkAXJZFJ4dk6BIh62nhyae2aAgbGIPS1mWR/bF1pbl7hjDQFJbooyqSn6S9IbTrp6G/zpV24ivZ4lcp5fWyu4ns1vhUrTWFhrpJcEBuM4jkJ9JvTjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJI/TA42sQ/r/5lhQoPDtsaVbpn/hBa3/4IVV6tcJik=;
 b=mvSglNtjlYMybLlaPiCsRZzjUSktERbZ9UVBkjvWT82X0HyS87GTkeSfMnI2olULNoxwJ4nAgowzWBV/6/hwFbLGGxqOYEPXxgIm7W/VzGeZnMudnk1eg4R8StW2V+aW8MYkMkAjwu9ZpOZ0f8qvrLJKd33+CnLQnXNuX1TDEigrgfdzdXcsdcO6jQ6qd0ame3qyhGE5RofHE5naGQomILTQmFkcdoQ8LGSKLYTXid/59Mt0+gp9u3NhaktWQb8jJQCuwWvWisAvpBb3cKrrVwMesuGspv+pnY7PcGybO3lDySATI8KVKEwdVYHDmUiDwJzUGufqfAtK4thhnuqPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJI/TA42sQ/r/5lhQoPDtsaVbpn/hBa3/4IVV6tcJik=;
 b=QM8PKaC8YZfPfu765sJYvBakoM0l4CtsedLSsSFQZzdGVKtG8UNfH6HaInFQh/58KU0DNJcV4ojvY1MDbauVRN2jEt46nhV8XDzqMn/CpzJxgrdb7VhnxxTPET/H/eyTlgtPd0qCG0KuCNH3+MJbRhfBSklJWC+A57j5zvvVpLc=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB1559.namprd11.prod.outlook.com (2603:10b6:910:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Sat, 9 Oct
 2021 16:49:14 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::45cf:c7fe:9a7f:219f]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::45cf:c7fe:9a7f:219f%12]) with mapi id 15.20.4587.025; Sat, 9 Oct 2021
 16:49:14 +0000
Date:   Sat, 9 Oct 2021 12:49:08 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211009164908.GA21269@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
 <20211007171929.hegwwqelf46skjyw@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007171929.hegwwqelf46skjyw@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN1PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:408:e3::6) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN1PR14CA0001.namprd14.prod.outlook.com (2603:10b6:408:e3::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Sat, 9 Oct 2021 16:49:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3322e61c-0373-4964-dcd8-08d98b44b8b9
X-MS-TrafficTypeDiagnostic: CY4PR11MB1559:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1559EE2F17CC6BBB34515DC5A0B39@CY4PR11MB1559.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRI8NEeAIQDOvuD4XqUq8/R6Eja6NOoTf4qxow4eTJdjC9Pw8TX5lS6WnqyRNGHLaBNhJzgmi5R26Xc7ppNzfaMy/U+baCbZtrMqTjtu8JsxWzKg9ntawGI+nRHWvu1rT0gsa2KmLJLgi6MpQmTGqlVhgiry8JFSUAk450vaJh5bXodxqbMKcJ/Yh5hSz7XeiHHXpCwApB6i1bww9vj4bBWsZnHZdFP7bce2eDIF+GaA/1JYZiemiAgwFAIAZKKqfPAIVg7DWXuAhNo8vXyJsXjnGbONQfPCwrJQL52Cha4JblEBmDu4rtP3fJucnZUHitNV7aytImnI5q2KmFkXLvQd3Ha6JJbrUWP/7aDbZ9HQvpwsxWYMqG2p0LSR362x02ElBjNypjlJYBFPonSQ19iNBkJwKS2xp0XOmtqHeokUZr5WHHwJu7chItOtsSwrTaqiF1hWswyxCgqfPngRw3M+kyOg8tlqJDfK+FKT+I8B1+SSEmlccnezRHIDmC6L6Z0MsThT4GS9fJBHxdL6Ra5oFoUnT6lY5kazoPylNPZ03Jum160yrB1lpfS7oonWagI38Ww0gP9gHxiDr3YlHLga2Fwofy33awaVOOUO5/1hy2QbNLFBwYrZqM0DaC1HExu/Og7ez+K5pMDc5RQZom5HZcz//zTogO+z+A6XBOW+OGw4kB3AN51zjDtOchehuYeDHkkH9NgOy63K5rGzsq3gJKDVsTkVI19CKTW46aviGO7Cx3rKek78I1/chci3ZwGBCMttxa7URkLxnhu22prTMWe/ytrNNCeMEdl1rLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(346002)(39830400003)(26005)(956004)(38100700002)(7696005)(52116002)(2906002)(55016002)(44832011)(5660300002)(3450700001)(186003)(8676002)(316002)(1076003)(54906003)(66556008)(508600001)(966005)(6666004)(83380400001)(38350700002)(6916009)(8936002)(66946007)(66476007)(86362001)(33656002)(53546011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANCZK1U39C0Qla6+fPUoeO0KhdoTkzACENldBzJBhaxVT/lzjwhJvZLrzrAe?=
 =?us-ascii?Q?H8MLCG8hPrHwjp+Ov4grwFVfNBP9ipUWS5D+CoGJsl/JXgxxlaKXTppyxC3h?=
 =?us-ascii?Q?YHqNh+oEfc1qIcC3c/JS0NU+FeiHQjAs3Pe83a3BpdWUpincyAmnkdkPVPSf?=
 =?us-ascii?Q?Y4zMB4QvG+JF2SLiJAJEq75lCymGUSLlDM86cuedsMTJNZq+/qUApRnhgg0X?=
 =?us-ascii?Q?/ROkXVh5Bj0TaQu9k/yBRUdOx3DCLuf8nVPXnsml+mDXVGlKutBjVpsGUtGv?=
 =?us-ascii?Q?KmJLzAeiWV0ow7jk8GoBBjt1kHqTlGROHW1wc57wzdsu0jZ7KkaNaRvnHQxh?=
 =?us-ascii?Q?Ig02XHC3D/VT8VNtbVUWs4LNhhdgWe2egBu1pgiFedCO/22jMSSXvpNYlydC?=
 =?us-ascii?Q?wltZsBLCQM+UN5Vxd7hMsWmNut3Dcn0X85Whh0rrZ8zqk96rCkYoomfhEByx?=
 =?us-ascii?Q?4XYqAXZnv04Mp/2Gc9Q+eLauqpLT/SU30gKmZpOMyV3qxDBlAIbIg3l66Oyk?=
 =?us-ascii?Q?2w6wussUklzixII/pmBwQweKY7NU4m2Ru1XYI/4N9xJGCjIFRZitbzuQhYZQ?=
 =?us-ascii?Q?9MZ3gEkFFptz18uu80x6E/A85yPiSoi3B378f+dXPr+pj7vJx+xb8JCXwFJx?=
 =?us-ascii?Q?6wpuQZ9xHkbTC9YzhzR9FzuFLVUEEZt81ZYNr2DSiziyOMr1mf5eoA9aieQ8?=
 =?us-ascii?Q?e0xwvrvU2h18MEzdp9zvkt62yD/Fr6ofFKfNKTjhm0QUqpD19Notpq8hrP8X?=
 =?us-ascii?Q?W0xwZNDvvAegiodaO16SKjCCudwVmaY619OlQBo0m8EkpKMRxM0HsNAgA+ht?=
 =?us-ascii?Q?P1mK2ekSVDVmPDsbfcQOcnjk+HoAluSPoCaWYLZvpUuxTr1o6Aqqg4/zaBdO?=
 =?us-ascii?Q?wvFEEi1po0yS7Y33gstMCXtKxW3gv6dkAPPfyWFM7pJc/16gN8ongttFXjZS?=
 =?us-ascii?Q?wDs+VAyVUbVVE+Er96lK1NgCG8/paFfaMOMhX4bfpnuRGjI9NCzC9xpZWE+d?=
 =?us-ascii?Q?scbtm2+G+r9d8Zb22v/EzXUPCKApH5iiyE2NpN3gyynO/lLfIxladCTvX2EI?=
 =?us-ascii?Q?mhP53aBp657T8A9HBNJwIa/NlpVLvPvIZ7uWDRE/+TrP+e3tVD8uuwA4qujN?=
 =?us-ascii?Q?2L1GlPYmjIdQlUHjLYa9FH+mEAISq/wJQZvxAJMGwJ2VOfz1FlYKOXaAyMLT?=
 =?us-ascii?Q?4bnC8X/OCnI2irB5nwSVJwqNPiANoMwJX8lBWdn6Z14Tp+LAx70oTWn74nv9?=
 =?us-ascii?Q?1FYe7wKqSpf6HuKghHCRWHomar+A6LHRY5cq0GgOr2Cvu23UNPWB38iBHrd0?=
 =?us-ascii?Q?2a01NJqEEqTwiUGHgV4YzdCQ?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3322e61c-0373-4964-dcd8-08d98b44b8b9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2021 16:49:13.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM7CyVVhjCOc3g4cSyMxSWeQCTZwTt2tWI/aKpgRQPaU2bBD+cMV+UZmpJvn3Hx2G95YwZaTNncnOejGeOySUVu85fCfBMuUexV7q3os584=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1559
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Oct 07, 2021 at 07:19:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-10-07 12:59:28 [-0400], Joe Korty wrote:
> > Convert IRQ blocking in intel_breadcrumbs_park() to a local lock.
> > 
> > Affects 5.10-rt and all later releases, up to and including when
> > rt was merged into mainline.
> 
> RT was merged into mainline? Nobody tells me anything anymore??? 
> 
> > This problem has been reported in two other linux-rt-users postings,
> >   
> >    [PREEMPT_RT] i915: fix PREEMPT_RT locking splats (Clark Williams)
> >    [linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts enabled (Jun Miao)
> > 
> > Neither of these submit the obvious solution, nor,
> > AFAICT, has either yet been acted on.  So I muddy the
> > waters further by submitting this, a third fix.
> 
> 5.12 is longer maintained. Could you please take the latest devel tree
> for testing and participate in
>   https://lore.kernel.org/all/20211005150046.1000285-1-bigeasy@linutronix.de/
> 
> If anything I would prefer those patches backported into v5.10 if it is
> affected.


Hi Sebastian,
Please add my 'Tested-by' to the below patch.  

   [linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts enabled (Jun Miao)

What was tested was a backport to 5.10-rt.  One reject
was encountered, trivially resolved.  No other adjustments
were made.

My regression tests of last night all passed without any
of the usual lockdep splats occuring.  Prior to this,
I could be assured of a large enough flood of splats to
overwhelm the kernel log.

My test stand is a Supermicro C7Z170-SQ.  This is tthe
only system I have on which I could trigger the problem.

I could not find this patch in the 5.12-rt or the 5.15-rt
tree, so I fetched a copy out of the linux-rt-users
archives, and backported that.

Tested-by: Joe Korty <joe.korty@concurrent-rt.com>

