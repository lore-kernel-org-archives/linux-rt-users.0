From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: Regarding interrupt task latency
Date: Fri, 24 Sep 2010 17:56:13 -0600
Message-ID: <4C9D025D0200005A00072B6D@soto.provo.novell.com>
References: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
 <4C9BB2F80200005A00072A37@soto.provo.novell.com>
 <AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Sri Ram Vemulpali" <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sri,

>>> On 9/24/2010 at 12:42 AM, in message
<AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>, Sri Ram
Vemulpali <sri.ram.gmu06@gmail.com> wrote: 
> Hi Gregory,
> 
>   Thanks for the explanation. I got a grasp of what you said.
> 
>   So, the whole preempt rt is made preemptible, even in the interrupt 
> context.
>   the IRQ now executes as thread, so that it can be preempted.
> 
>   Now the question is, usually this interrupt task latency

Can you be more specific as to which interrupt task latency you are referring to?

> occurs when
> IRQ thread finishes
>   and sets need_resch. So this is checked in the locks, so that long
> critical section
>   determines when to schedule, which is non-deterministic.
> 
>   why do not we eliminate this by calling schedule immediately after
> IRQ thread context.

I think there is some confusion here.  The "after" in any thread context is already a schedule(), so I am not clear on what you are proposing we need to eliminate.

If the irq-thread is the highest priority task, it will run to completion and then naturally schedule() as part of its "sleep" logic (such as joining a wait-queue).  The scheduler will immediately elect the next highest RUNNING task (or idle, if none are available) as a result of the irq-thread going to sleep (there is no latency here, assuming you correctly prioritized the threads).

Likewise, if the irq-thread is suddenly _not_ the highest priority, it will be preempted ASAP.  This will happen either immediately as soon as the higher task enters RUNNING, or at the conclusion of any critical section that the irq-thread may have entered.  Since -rt eliminates most critical sections (and makes the few that remain very short), this usually means the former.

>   I think there can be a solution. If such solution exists we will not
> have two kinds of patches
>   "low latency" and "preempt" patches of RT.
> 
>   Can you please explain, is there any reason or bottle neck to
> implement solution to call schedule
>   immediately after IRQ thread context.

I assert we already _do_.  If you think otherwise, please clarify the scenario that concerns you.

Kind Regards,
-Greg


