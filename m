From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Date: Mon, 26 Mar 2018 11:35:15 -0400
Message-ID: <20180326113515.720e7fb3@gandalf.local.home>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
        <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
        <20180323172131.GA2670@zipoli.concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Julia Cartwright <julia@ni.com>, <bigeasy@linutronix.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: joe.korty@concurrent-rt.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323172131.GA2670@zipoli.concurrent-rt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 23 Mar 2018 13:21:31 -0400
joe.korty@concurrent-rt.com wrote:

> My understanding is, in standard Linux and in rt, setting
> task state to anything other than TASK_RUNNING in of itself
> blocks preemption.

That is clearly false. The only thing that blocks preemption with a
CONFIG_PREEMPT kernel is preempt_disable() and local_irq*() disabling.

(Note spin_locks call preempt_disable in non RT).

Otherwise, nothing will stop preemption.

>  A preemption is not really needed here
> as it is expected that there is a schedule() written in that
> will shortly be executed.  And if a 'involuntary schedule'
> (ie, preemption) were allowed to occur between the task
> state set and the schedule(), that would change the task
> state back to TASK_RUNNING, which would cause the schedule
> to NOP.  Thus we risk not having paused long enough here
> for the condition we were waiting for to become true.

That is also incorrect. As Julia mentioned, a preemption keeps the
state of the task.

-- Steve
