From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 12:14:51 +0200
Message-ID: <1497867291.19618.52.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497687277.6908.31.camel@gmx.de>
         <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-06-19 at 10:52 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-06-17 10:14:37 [+0200], Mike Galbraith wrote:
> 
> > During that rebase, migrate_disable() was changed to no longer map to
> > preempt_disable() for nonrt, but some patches still assume it does.  It
> > now depends upon PREEMPT_COUNT, the RT workaround in futex.c induces
> > grumbling in nonrt builds with PREEMPT_COUNT enabled.
> 
> argh, right. It was planned to get it merged upstream but due to
> $reasons we never got that far. For that reason I would simply revert
> that change and let migrate_disable() map to preempt_disable() as it did
> earlier.

Ok, doesn't matter for RT testing.  What does matter, is that...

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30b24f774198..10e832da70b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2284,7 +2284,7 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-       return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+       return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
 }

...appears to be inducing lost futex wakeups.

Scratch that "appears", changing it to TASK_NORMAL just fixed my DL980
running otherwise absolutely pristine 4.9-rt21, after having double
verified that rt20 works fine.  Now to go back to 4.11/master/tip-rt,
make sure that the little bugger really really REALLY ain't fscking
with me for the sheer fun of it, futexes being made of pure evil :)

My testcase is to run futex_wait -n 4 in a modest sized loop.  Odd
thing is that it only reproduces on the DL980 if I let it use multiple
sockets, pin it to one, and all is peachy, (rather seems to be given)
whereas on desktop box, the hang is far more intermittent, but there.

	-Mike
