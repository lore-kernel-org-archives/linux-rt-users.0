From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 13:31:28 +0200
Message-ID: <1497871888.19618.90.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497687277.6908.31.camel@gmx.de>
         <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
         <1497867291.19618.52.camel@gmx.de>
         <20170619104459.prmicsbbmljc6smb@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170619104459.prmicsbbmljc6smb@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-06-19 at 12:44 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-06-19 12:14:51 [+0200], Mike Galbraith wrote:
> > Ok, doesn't matter for RT testing.  What does matter, is that...
> > 
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
> has this something to do with "rtmutex: Fix lock stealing logic" ?

Nope.  The above is fallout of me being inspired me to stare, that
inspiration having come initially from seeing lost wakeup symptoms in
my desktop, telling me something has gone sour in rt-land, so a hunting
I did go.  I expected to find I had made a booboo in my trees, but
maybe not, as I found a suspiciously similar symptom to what I was
looking for in virgin source.

> > Scratch that "appears", changing it to TASK_NORMAL just fixed my DL980
> > running otherwise absolutely pristine 4.9-rt21, after having double
> > verified that rt20 works fine.  Now to go back to 4.11/master/tip-rt,
> > make sure that the little bugger really really REALLY ain't fscking
> > with me for the sheer fun of it, futexes being made of pure evil :)
> 
> So v4.9-rt20 works fine but -rt21 starts to lose wakeups on DL980 in
> general or just with "futex_wait -n 4" ?

-rt20 is verified to work fine, -rt21 starts hanging with futextest.
 The futex_wait -n 4 testcase was distilled out of seeing the full
futextest/run.sh hanging.  The only symptom I've _seen_ on the DL980 is
futextest hanging.  On the desktop, I've seen more, and may still, I'll
know when I see or don't see desktop gizmos occasionally go comatose.

> > My testcase is to run futex_wait -n 4 in a modest sized loop.  Odd
> > thing is that it only reproduces on the DL980 if I let it use multiple
> > sockets, pin it to one, and all is peachy, (rather seems to be given)
> > whereas on desktop box, the hang is far more intermittent, but there.
> 
> do I parse it right, as v4.9-rt21 (without the change above) works with
> the testcase mentioned if you pin it to one socket but does not work if
> you let it use multiple sockets.
> And your desktop box hangs no matter what?

No no, desktop box will reproduce, but not nearly as reliably as the 8
socket box does, but yes, it seems to work fine on the DL980 when
pinned to one socket.  I was testing 4.9-rt because hunt was in
progress when 4.11-rt was born.

	-Mike
