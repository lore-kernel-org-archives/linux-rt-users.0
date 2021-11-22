Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C368C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Nov 2021 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhKVUgE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:36:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhKVUgD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Nov 2021 15:36:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B0260FBF;
        Mon, 22 Nov 2021 20:32:55 +0000 (UTC)
Date:   Mon, 22 Nov 2021 15:32:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211122153254.1f10e34a@gandalf.local.home>
In-Reply-To: <20211122195048.GB6166@zipoli.concurrent-rt.com>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
        <20211007171929.hegwwqelf46skjyw@linutronix.de>
        <20211009164908.GA21269@zipoli.concurrent-rt.com>
        <20211116152534.122f8357@gandalf.local.home>
        <20211116210249.t3f6gw56iaow57mq@linutronix.de>
        <20211116163924.5d5a2ffd@gandalf.local.home>
        <20211122195048.GB6166@zipoli.concurrent-rt.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 22 Nov 2021 14:50:48 -0500
Joe Korty <joe.korty@concurrent-rt.com> wrote:

> On Tue, Nov 16, 2021 at 04:39:24PM -0500, Steven Rostedt wrote:
> > On Tue, 16 Nov 2021 22:02:49 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > On 2021-11-16 15:25:34 [-0500], Steven Rostedt wrote:  
> > > > I'm looking to see what needs to be added to 5.10-rt. Is there a particular
> > > > fix in one of the 5.x-rt trees (x > 10) that I can pull from? Or is this
> > > > only an issue with 5.10 and below?    
> > > 
> > > I have this:
> > >   https://lore.kernel.org/all/20211026114100.2593433-1-bigeasy@linutronix.de
> > > 
> > > pending vs upstream and I *think* more than just that one (2/9 from the
> > > series) needs to be backported here. We do have 1/9 differently in 5.10,
> > > not sure about 4/9.
> > > I would love more feedback here from people and I tried to motivate Joe
> > > to provide some. Clark was so nice to test these patches and provide
> > > feedback. My i915 does not trigger all the code paths I'm touching
> > > there.
> > > 
> > > If you think that 2/9 is obvious enough, please go ahead. If you start
> > > touching that irq_work area then you might also want to pick
> > >   810979682ccc9 ("irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.")
> > >   b4c6f86ec2f64 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
> > >   09089db79859c ("irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT")
> > > 
> > > which made their way into v5.16-rc1.
> > >  
> > 
> > I have a few boxes with i915, that maybe could help in testing.
> > 
> > I'll take a look.
> > 
> > -- Steve  
> 
> Hi Steve, Sebastian,
> I was on a no-Internet no-News vacation for the past week,
> that is why I haven't responded.  Sorry.  In any case my
> test stand suddenly started working, for no reason that I
> can see, and so, for now, I have not been able to continue
> my testing.
> 
> I will keep poking at it from time to time, see if I can
> get the issue to come back.
>

I just finished testing 5.10-rt-rc2 with Sebastian's patch 2/9. I'll post
the new rc of it and then release it.

Thanks,

-- Steve

