From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 16:13:41 +0200
Message-ID: <20170619141341.m243ivutmwlzyhc4@linutronix.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
 <1497687277.6908.31.camel@gmx.de>
 <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
 <1497867291.19618.52.camel@gmx.de>
 <20170619100838.343faaee@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdFSONo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jun 2017 10:13:44 -0400
Content-Disposition: inline
In-Reply-To: <20170619100838.343faaee@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-19 10:08:38 [-0400], Steven Rostedt wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 30b24f774198..10e832da70b6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2284,7 +2284,7 @@ EXPORT_SYMBOL(wake_up_process);
> >   */
> >  int wake_up_lock_sleeper(struct task_struct *p)
> >  {
> > -       return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
> > +       return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
> >  }
> > 
> > ...appears to be inducing lost futex wakeups.
> 
> Hmm, it shouldn't affect futexes, as it's only called by rtmutex when
> waiter->savestate is true. And that should always be false for futex.

you still have sleeping locks like the hb-lock (which might matter in
case the task blocks on the lock and does not continue for some reason).

> -- Steve

Sebastian
