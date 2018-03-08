From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Date: Thu, 8 Mar 2018 18:41:03 +0100
Message-ID: <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-03-07 09:45:29 [-0600], Corey Minyard wrote:
> > I have no idea what is the wisest thing to do here. The obvious fix
> > would be to use the irqsafe() variant here and not drop the lock between
> > wake ups. That is essentially what swake_up_all_locked() does which I
> > need for the completions (and based on some testing most users have one
> > waiter except during PM and some crypto code).
> > It is probably no comparison to wake_up_q() (which does multiple wake
> > ups without a context switch) but then we did this before like that.
> > 
> > Preferably we would have a proper list_splice() and some magic in the
> > "early" dequeue part that works.
> > 
> 
> Maybe just modify the block code to run the swake_up_all() call in a
> workqueue
> or tasklet?  If you think that works, I'll create a patch, test it, and
> submit it if
> all goes well.

It will work but I don't think pushing this into workqueue/tasklet is a
good idea. You want to wakeup all waiters on waitqueue X (probably one
waiter) and instead there is one one wakeup + ctx-switch which does the
final wakeup.
But now I had an idea: swake_up_all() could iterate over list and
instead performing wakes it would just wake_q_add() the tasks. Drop the
lock and then wake_up_q(). So in case there is wakeup pending and the
task removed itself from the list then the task may observe a spurious
wakeup.

> Thanks,
> 
> -corey

Sebastian
