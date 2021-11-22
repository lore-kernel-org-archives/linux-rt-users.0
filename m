Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7BC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Nov 2021 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhKVTyH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:54:07 -0500
Received: from mail-eopbgr10100.outbound.protection.outlook.com ([40.107.1.100]:38473
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230366AbhKVTyG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Nov 2021 14:54:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpzD0cbcrqxeWrElIMVbdnRxmZrXHRjZuykVdHJlf+XXzEP9QO9FX31vonk3qoKhrs/k+Wo1U5M/DTzsvlKO+Z+1eRrzudY+nfaKxawOaReus3PzK8bDueo4UleqLRiEb7kUMf+QEu/kqs0YOwb+oy4aY8lk85xz+z2E2P4Q+TA0DhkW1ilfvuYSxr1pO0/ZsruTdtjj7BBVCw1lbS78Dg/4npqWFwB+jL+IOkubXseFTCaLtmpeG0v5dbG22Zd1HsvrCaVFiA3Zfb5v4qgX9fJScsi58D3QPdwhQDUifN0FcORCJaUAbHRF10frSyoTm4hlagqvvmXs6goZcuaaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tRQVMse2m7Z794pNUwXPGFjgj7v0ES/7GPXjLLvJ2k=;
 b=H6lvO3Usw0Xpghe3WYrZQ4HMBF2vkfwHvpKRRemObbOfWmaxLANroqK+Vnpx9y5LCzUY/Ry+UUEh4CtwcsFbJaxpPmu56Y6gLHKEUVeyqqfH2cCeQsHb9muN0r/PQsaRzAesgV/lp+y1ojFoAUCwusRxj+/rTcmfqxK2pTWxi4cMyNRLwGg9tovClUDiQtcq7GcgFlTv4Bw3uZiOtqiZp0dz2yX6zs57wJVQ4QaxE/9boTxuadTeVxXpCzo3sH6fRsz8S5p4l9UJm4uem7+qd2+5oYyM3Ek+I/sKItt6T5kjTce91FoZgyZZMoN3pAkOkuQ+sWo2V+9Xf9cdRI9HqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tRQVMse2m7Z794pNUwXPGFjgj7v0ES/7GPXjLLvJ2k=;
 b=RsNuqfHB13WEA4KeJxbWBRUqGtuUNYLWuR1tm0GwOLiz6zFwQL1m/v8pLOOcpFncLP1pvjqRS7qixxTGO3hSRxJlz5EB1UEADGlMGXrJ4HSfIYo9uFHPTJV889e5JkbQ8HaXdL/oKTl1lCnI1IU+nGMim7rK+8tmGZPUkNUtR14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from DU2PR09MB5342.eurprd09.prod.outlook.com (2603:10a6:10:274::7)
 by DU2PR09MB5359.eurprd09.prod.outlook.com (2603:10a6:10:278::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 19:50:56 +0000
Received: from DU2PR09MB5342.eurprd09.prod.outlook.com
 ([fe80::59e6:bb5d:7781:7d1e]) by DU2PR09MB5342.eurprd09.prod.outlook.com
 ([fe80::59e6:bb5d:7781:7d1e%9]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 19:50:56 +0000
Date:   Mon, 22 Nov 2021 14:50:48 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211122195048.GB6166@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
 <20211007171929.hegwwqelf46skjyw@linutronix.de>
 <20211009164908.GA21269@zipoli.concurrent-rt.com>
 <20211116152534.122f8357@gandalf.local.home>
 <20211116210249.t3f6gw56iaow57mq@linutronix.de>
 <20211116163924.5d5a2ffd@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116163924.5d5a2ffd@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:408:4c::41) To DU2PR09MB5342.eurprd09.prod.outlook.com
 (2603:10a6:10:274::7)
MIME-Version: 1.0
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN8PR16CA0028.namprd16.prod.outlook.com (2603:10b6:408:4c::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend Transport; Mon, 22 Nov 2021 19:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 990674da-4020-4035-8bf7-08d9adf16527
X-MS-TrafficTypeDiagnostic: DU2PR09MB5359:
X-Microsoft-Antispam-PRVS: <DU2PR09MB5359F79AF83267DB0FF18C5AA09F9@DU2PR09MB5359.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42GH081vs+B48gEmxyPYTtDxP89FA1VHHqabToBKaZ1S8EDKgpG+6NYcLZRTyNz1DS3F4xoeGI8SMUTkBJtRRxx2wxNqFou///wmnjoksnSKaqcrN30eBXvwik/7S9f1nJSPB6rmq14iYYKgRHX5CTYVtYf7jdwKDLODm5nRCLFKX4TKcZxOgoaCsb4/lHCkohYB+MfClxUa/7pghdBhFjzVyLoEss3sx0Oe5dZsfA4bENhbmYWMHLHgi5m5jPK2gZfvsIfCb8VSuDCTRvDCAngjITsGZ5udENvBSG4cgGksusswwTSZTZD5kMHHfJ0pc1flr+F/RDVIJ3C4e8EXJBvOkEC0ak+JF2QGCJ4gSyvx+IaIGOsDNytFajl6aDcX7ZzLDMd7gh2zmpUWU2NGeBtQC4z68rG7jGoH7iYeRKscqMhUEG8o6br7grFvlAtqq3xYkCkvXHd9gyphO38kXfRA0P7lR1v04gMCcCmFZFYgLrLg3UVbwFtlX8WVROGtT1DCxJiimGYrzGfmqxsM9urKXae/fj0u6OXIUzIUfcBLtYltTjLzaTDcdKN6k2jRSiDPpSqEvozvRU2OUTPfW2gjvMvA+M7DPklWd5pd8B3iuJ+vUCUgWbDQGcIdS0TMGTpcwZV8cVMMM2t4W3VXQkuawyCs8JVgHtYTvTLlmIQTxaDrr/lC+none2cw2kNOhBs+7kCnnF49C6LXh7tmELuEI6maIIKK+XSdcpykVARUGlih/czA5oL1s0P7WmqkXKEWkMKiPIBfCoUmULRjoxEEmtsl7te68Djq7d0gvFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR09MB5342.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(33656002)(7696005)(1076003)(6666004)(53546011)(86362001)(54906003)(4326008)(5660300002)(6916009)(956004)(44832011)(66476007)(26005)(66556008)(8676002)(3450700001)(38350700002)(186003)(55016002)(508600001)(2906002)(66946007)(966005)(4001150100001)(8936002)(38100700002)(66574015)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hraWxRJRmtWdBWKToWZ2TRELrDtVCn+r0p/3c7J9fCAPHefHsqcygGZcZEje?=
 =?us-ascii?Q?IJTKLj2llewsP0jEGnuaXEI2Ia/Ayi5J3LLq+dqV0dTEnyqvHrkdThoERBrA?=
 =?us-ascii?Q?9P5DBEQPl5ZlfvXxfKGqS973KGz6crGMhnve9w+RcSG+f4Sk4UOWnin6TGm+?=
 =?us-ascii?Q?leNca/UtneRWqyx6jbD8MX34IuaF0iKl1vtG0YxcwL1IfNi0KcHSnQNfNeIm?=
 =?us-ascii?Q?grfj/hHr+f0X3cmwtOhSPb8cS6MukpPkTigezuU0JH+D3lnh+ghlufRcRCzS?=
 =?us-ascii?Q?84eYfAbedHS54Qu75iqxmT3ZgJIVQVBCaei6ZQEebLZ8qKgMnQpFo6AnxNlr?=
 =?us-ascii?Q?4eP2Z+h3LhZCpiFAMtOz0Tbr6IOy3cdREz4ay3KC9meoxHEoV2b586CTSjnU?=
 =?us-ascii?Q?8M6ALXaifsjI1u804hZWqKwWWTtwfVlX6yT3lEu+e1ScPDoikFIlFFicyE4W?=
 =?us-ascii?Q?RhNDNoJhi1f093OCQYmAsDo0/KlTk845tPHuAWZ12IuA5OQ14MPhCp3MAOAW?=
 =?us-ascii?Q?MNhNUkrROdUMIJYq3raLLl3A2ZZ5Ob/oa8o0mFhRfY3iHdwB3OFvEF5K81it?=
 =?us-ascii?Q?rtc9oKWaxPUNxx/n7YJU1QnKPpbZDQ56e2WEUplb7SJz+tVSqY/jt3i4C/ZG?=
 =?us-ascii?Q?svUy60paRXGuyb8DcXyyHMIjttYsiGefCKfyvh29GZT+qyfiSmqtphksXdYU?=
 =?us-ascii?Q?WrSS5+I6hb2P/lxPCRV2YfZIJtrrWec/Mcg0+HIDG1WPprutuwqlUpPy+5Xf?=
 =?us-ascii?Q?i7C7b+xc5+dgErpQaqgmfNSpAklu+wZSuhmL9oSBDWtzcRY+3P3F0ry+VuFR?=
 =?us-ascii?Q?IkY7+U1WIjW22zxE+V44Ss5kGD9RwcpDUBGsaLN1zotdx3hba8wty7i+rrFN?=
 =?us-ascii?Q?RlAw7835fYl7r1fHm8Z+0QmsYBMki6iX7ACVwn9wpwdV+VauddoNELEKHbX7?=
 =?us-ascii?Q?spWWl16MaS5+bBSp9e39K8geLzKna3/f1FP9sSimQQC4mFqvrIx8PRgudwwh?=
 =?us-ascii?Q?I9UwIwPh49uxe7IaVhAaNTSnRqvE9T7C6Q4vAPxBG4ODlK8eSLrnBenYZP9K?=
 =?us-ascii?Q?TKbyUUvbmkKkHlydGKywsuNEjhGb1O6l6u7LOvlzYuSUywaW11zzfHaxvYaY?=
 =?us-ascii?Q?ydA+Fa8HdepzOkw3U5Szn+Wv10gK6unoam3DMMxo/maoRLQ5iFVz9LjCAe0F?=
 =?us-ascii?Q?jLxiv6Jwf5X7MfwuRr9W+2HOeFrENJjoPQOUiT8cdpU6zLFFRHkT1xaMKJlq?=
 =?us-ascii?Q?HW+SHmWilC1vEGOK+4NyqR6X3TZ+PL6anxz6vjd0btQHzrnh4bwnHxtBU4Gx?=
 =?us-ascii?Q?pmNpSp/siXjfSa8l2tE+dM98cZ7WMATICMUn0Z6xBMH+fyme0CB8PgsfyrND?=
 =?us-ascii?Q?8YGal010eZdCYJuPzHamUfaCED3AfKJDOZgJ/qvhCLvkexNW2C3c58Ke6fMG?=
 =?us-ascii?Q?SmKC0RtKQh6sI0mTLYeRcWHknlMeMmPe6ug7+8uXcIsxleFjVrgvKBl1Xyff?=
 =?us-ascii?Q?oHUkBM8qmuZnKMXd4AQnDlkpA/e8AEZ9bLHeO8cPv/fymdIs/HzS4gGgJNnb?=
 =?us-ascii?Q?O3yggOt2r8iA7fMk0bpQqnQ/p6gzN9A0QqbYmjhooItBb8G2MAmUglKO0Bx+?=
 =?us-ascii?Q?02NNL9IBCDnQJK4Kei4tiDFJGDSLaxgF3cZyKEyzVaSNsQGhXvK7DcygVDPi?=
 =?us-ascii?Q?PYAIvw=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990674da-4020-4035-8bf7-08d9adf16527
X-MS-Exchange-CrossTenant-AuthSource: DU2PR09MB5342.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 19:50:56.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byyjPlaLlZb/e71etgrbKBPvuku1NrCOk9AUxb3RSYQsVtcmi81dVbA8jzLrTgEpY3NFViZgkF5DLflXjfgNCgt/+UCCks2tb3dT6zS+S0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5359
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Nov 16, 2021 at 04:39:24PM -0500, Steven Rostedt wrote:
> On Tue, 16 Nov 2021 22:02:49 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2021-11-16 15:25:34 [-0500], Steven Rostedt wrote:
> > > I'm looking to see what needs to be added to 5.10-rt. Is there a particular
> > > fix in one of the 5.x-rt trees (x > 10) that I can pull from? Or is this
> > > only an issue with 5.10 and below?  
> > 
> > I have this:
> >   https://lore.kernel.org/all/20211026114100.2593433-1-bigeasy@linutronix.de
> > 
> > pending vs upstream and I *think* more than just that one (2/9 from the
> > series) needs to be backported here. We do have 1/9 differently in 5.10,
> > not sure about 4/9.
> > I would love more feedback here from people and I tried to motivate Joe
> > to provide some. Clark was so nice to test these patches and provide
> > feedback. My i915 does not trigger all the code paths I'm touching
> > there.
> > 
> > If you think that 2/9 is obvious enough, please go ahead. If you start
> > touching that irq_work area then you might also want to pick
> >   810979682ccc9 ("irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.")
> >   b4c6f86ec2f64 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
> >   09089db79859c ("irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT")
> > 
> > which made their way into v5.16-rc1.
> >
> 
> I have a few boxes with i915, that maybe could help in testing.
> 
> I'll take a look.
> 
> -- Steve

Hi Steve, Sebastian,
I was on a no-Internet no-News vacation for the past week,
that is why I haven't responded.  Sorry.  In any case my
test stand suddenly started working, for no reason that I
can see, and so, for now, I have not been able to continue
my testing.

I will keep poking at it from time to time, see if I can
get the issue to come back.

Joe
