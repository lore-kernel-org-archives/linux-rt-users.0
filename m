Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE1C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677922226A
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbhAHJFu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:05:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbhAHJFt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 04:05:49 -0500
Date:   Fri, 8 Jan 2021 10:05:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610096707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MaElQDfr04xlJduyTIzoSs++m/PI2efjRiDSIc2KD4=;
        b=ldrTS58uYQVIr9fhrl2yjcvgoJuWYY2KoLTcmbeMlY5yVDEVSFHDlINHM7nm61TCd6qm1u
        yIfZFkQotgHcYPKBMi3OUrYYCj40QVYnDU88CxKnycIgi/CVio12DZHWJwPwEj6k95Tl6Z
        xu2jpppg43TDvf/u5S7UpaMhlyO6L1g19OYVtOdi9hKCUFYiwpzCB2QUSPuPpdc4YU5YBN
        b9By4JEFYdoou08m3pI5ZqbZs3ojjYrulip9X1v2cjF0Zo2ZEbAwxzkKdwXhVpKGs7mlko
        Z5jtjNBbHptd9OAB+ola4mUWoY49WVM8nhU6LQxwSeqQopzjvZPFxfxAuq4mxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610096707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MaElQDfr04xlJduyTIzoSs++m/PI2efjRiDSIc2KD4=;
        b=tX+sLUcg5HKBzerKfLw5hzvc2rTkxXBkE4YiqUXNLzyBzhq+jUxWvUPGrsAvsLO4Ww2G6E
        mh8OVEo4l/XNDdDg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Message-ID: <20210108090506.ijekysg6aenzno5t@linutronix.de>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
 <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
 <20210107152843.gyljmpctkwybfewh@linutronix.de>
 <AM6PR04MB5413F9490E9264273E22264FF1AE0@AM6PR04MB5413.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5413F9490E9264273E22264FF1AE0@AM6PR04MB5413.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-08 08:45:14 [+0000], Ran Wang wrote:
> Hi Sebastian, Peter
Hi,

> > I had a similar patch in -RT and dropped it in v5.10-rc7-rt16.
> > It was added because RT couldn't boot since creating the boot-threads didn't work before the ksoftirqd was up. This was fixed by commit
> >    26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")
> 
> I tried applying above commit to linux-5.6.y-rt, it could resolve my problem on LX2160ARDB, THANKS!

so in other words all this could have been avoided by using a supported
or maintained RT series. The v5.4 series has this patch, v5.6 isn't
maintained anymore so it is likely that there is more missing.

Sebastian
