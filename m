From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 12:44:59 +0200
Message-ID: <20170619104459.prmicsbbmljc6smb@linutronix.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
 <1497687277.6908.31.camel@gmx.de>
 <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
 <1497867291.19618.52.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbdFSKpC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jun 2017 06:45:02 -0400
Content-Disposition: inline
In-Reply-To: <1497867291.19618.52.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-19 12:14:51 [+0200], Mike Galbraith wrote:
> Ok, doesn't matter for RT testing.  What does matter, is that...
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 30b24f774198..10e832da70b6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2284,7 +2284,7 @@ EXPORT_SYMBOL(wake_up_process);
>   */
>  int wake_up_lock_sleeper(struct task_struct *p)
>  {
> -       return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
> +       return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
>  }
> 
> ...appears to be inducing lost futex wakeups.

has this something to do with "rtmutex: Fix lock stealing logic" ?

> Scratch that "appears", changing it to TASK_NORMAL just fixed my DL980
> running otherwise absolutely pristine 4.9-rt21, after having double
> verified that rt20 works fine.  Now to go back to 4.11/master/tip-rt,
> make sure that the little bugger really really REALLY ain't fscking
> with me for the sheer fun of it, futexes being made of pure evil :)

So v4.9-rt20 works fine but -rt21 starts to lose wakeups on DL980 in
general or just with "futex_wait -n 4" ?

> My testcase is to run futex_wait -n 4 in a modest sized loop.  Odd
> thing is that it only reproduces on the DL980 if I let it use multiple
> sockets, pin it to one, and all is peachy, (rather seems to be given)
> whereas on desktop box, the hang is far more intermittent, but there.

do I parse it right, as v4.9-rt21 (without the change above) works with
the testcase mentioned if you pin it to one socket but does not work if
you let it use multiple sockets.
And your desktop box hangs no matter what?

> 	-Mike

Sebastian
