From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Date: Fri, 9 Mar 2018 18:46:05 +0100
Message-ID: <20180309174605.GC4064@hirez.programming.kicks-ass.net>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309110418.lwtennjqwqcxh422@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Mar 09, 2018 at 12:04:18PM +0100, Sebastian Andrzej Siewior wrote:
> +void swake_add_all_wq(struct swait_queue_head *q, struct wake_q_head *wq)
>  {
>  	struct swait_queue *curr;
>  
>  	while (!list_empty(&q->task_list)) {
>  
>  		curr = list_first_entry(&q->task_list, typeof(*curr),
>  					task_list);
>  		list_del_init(&curr->task_list);
> +		wake_q_add(wq, curr->task);
>  	}
>  }
> +EXPORT_SYMBOL(swake_add_all_wq);
>  
>  void swake_up(struct swait_queue_head *q)
>  {
> @@ -66,25 +62,14 @@ EXPORT_SYMBOL(swake_up);
>   */
>  void swake_up_all(struct swait_queue_head *q)
>  {
> +	unsigned long flags;
> +	DEFINE_WAKE_Q(wq);
>  
> +	raw_spin_lock_irqsave(&q->lock, flags);
> +	swake_add_all_wq(q, &wq);
> +	raw_spin_unlock_irqrestore(&q->lock, flags);
>  
> +	wake_up_q(&wq);
>  }
>  EXPORT_SYMBOL(swake_up_all);

This is fundamentally wrong. The whole point of wake_up_all() is that
_all_ is unbounded and should not ever land in a single critical
section, be it IRQ or PREEMPT disabled. The above does both.

Yes, wake_up_all() is crap, it is also fundamentally incompatible with
in-*irq usage. Nothing to be done about that.

So NAK on this.
