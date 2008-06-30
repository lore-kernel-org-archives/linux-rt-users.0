From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/3] sched: newidle and RT wake-buddy fixes
Date: Mon, 30 Jun 2008 11:01:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806301100130.15090@gandalf.stny.rr.com>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com>
 <20080630131511.GA7506@elte.hu> <4868B841.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, peterz@infradead.org, npiggin@suse.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:55456 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYF3PBr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 11:01:47 -0400
In-Reply-To: <4868B841.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 30 Jun 2008, Gregory Haskins wrote:

>
> >>> On Mon, Jun 30, 2008 at  9:15 AM, in message <20080630131511.GA7506@elte.hu>,
> Ingo Molnar <mingo@elte.hu> wrote:
>
> > * Gregory Haskins <ghaskins@novell.com> wrote:
> >
> >> Hi Ingo,
> >>   The following patches apply to linux-tip/sched/devel and enhance the
> >> performance of the kernel (specifically in PREEMPT_RT, though they do
> >> not regress mainline performance as far as I can tell).  They offer
> >> somewhere between 50-100% speedups in netperf performance, depending
> >> on the test.
> >
> > -tip testing found this boot hang:
>
> Ok, I dug in a little bit here.  I haven't verified this out yet, but I think the problem is that
> your config is PREEMPT_VOLUNTARY which NOPs the preempt_disable() in schedule() that
> I rely on to allow the lock to be dropped.  (Doh!)

This means that there's a location somewhere that does a cond_resched?
Perhaps we should look to see what does that. And perhaps the
preempt_disable should not be allowing PREEMPT_VOLUNTARY to do scheduling
with cond_resched.

-- Steve

>
> One way I can fix this is to fixup the newidle() code to only play the irq dropping tricks
> ifdef CONFIG_PREEMPT == TRUE.  Does this sound reasonable, or is there a better way
> to address this?

