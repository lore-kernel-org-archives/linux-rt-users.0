From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Fri, 23 Jun 2017 14:48:16 +0200
Message-ID: <20170623124816.2lc6tb3h5rggwnw7@linutronix.de>
References: <1497687277.6908.31.camel@gmx.de>
 <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
 <1497867291.19618.52.camel@gmx.de>
 <20170619100838.343faaee@gandalf.local.home>
 <20170619141341.m243ivutmwlzyhc4@linutronix.de>
 <20170619104131.05fdc76f@gandalf.local.home>
 <1497889784.15817.17.camel@gmx.de>
 <1497944706.5454.7.camel@gmx.de>
 <20170622163453.iymm3ctqv2a76k6k@linutronix.de>
 <1498152607.5559.19.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498152607.5559.19.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-22 19:30:07 [+0200], Mike Galbraith wrote:
> On Thu, 2017-06-22 at 18:34 +0200, Sebastian Andrzej Siewior wrote:
> > On 2017-06-20 09:45:06 [+0200], Mike Galbraith wrote:
> > > See ! and ?
> > 
> > See see.
> > What about this:
> 
> I'll give it a go, likely during the weekend.

It survived >1d on my AMD-A10 box. I am adding this description:

|If a task is queued as a sleeper for a wakeup and never goes to
|schedule() (because it just obtained the lock) then it will receive a
|spurious wake up which is not "bad", it is considered. Until that wake
|up happens this task can no be enqueued for any wake ups handled by the
|WAKE_Q infrastructure (because a task can only be enqueued once). This
|wouldn't be bad if we would use the same wakeup mechanism for the wake
|up of sleepers as we do for "normal" wake ups. But we don't…
|
|So.
|   T1			T2		T3
|   spin_lock(x)				spin_unlock(x);
|   					wake_q_add(q1, T1)
|   spin_unlock(x)
|   set_state(TASK_INTERRUPTIBLE)
|   if (!condition)
|	schedule()
|			condition = true
|			wake_q_add(q2, T1)
|			// T1 not added, still enqueued
|			wake_up_q(q2)
|					wake_up_q_sleeper(q1)
|					// T1 not woken up, wrong task state
|
|In order to solve this race this patch adds a wake_q_node for the
|sleeper case.

and consider this closed unless I hear from you different things :)

Sebastian
