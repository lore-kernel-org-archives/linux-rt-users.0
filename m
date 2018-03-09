From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Date: Fri, 9 Mar 2018 16:02:42 -0600
Message-ID: <40965186-bf28-3973-7602-3595e89b6180@mvista.com>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309174605.GC4064@hirez.programming.kicks-ass.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/09/2018 11:46 AM, Peter Zijlstra wrote:
> On Fri, Mar 09, 2018 at 12:04:18PM +0100, Sebastian Andrzej Siewior wrote:
>> +void swake_add_all_wq(struct swait_queue_head *q, struct wake_q_head *wq)
>>   {
>>   	struct swait_queue *curr;
>>   
>>   	while (!list_empty(&q->task_list)) {
>>   
>>   		curr = list_first_entry(&q->task_list, typeof(*curr),
>>   					task_list);
>>   		list_del_init(&curr->task_list);
>> +		wake_q_add(wq, curr->task);
>>   	}
>>   }
>> +EXPORT_SYMBOL(swake_add_all_wq);
>>   
>>   void swake_up(struct swait_queue_head *q)
>>   {
>> @@ -66,25 +62,14 @@ EXPORT_SYMBOL(swake_up);
>>    */
>>   void swake_up_all(struct swait_queue_head *q)
>>   {
>> +	unsigned long flags;
>> +	DEFINE_WAKE_Q(wq);
>>   
>> +	raw_spin_lock_irqsave(&q->lock, flags);
>> +	swake_add_all_wq(q, &wq);
>> +	raw_spin_unlock_irqrestore(&q->lock, flags);
>>   
>> +	wake_up_q(&wq);
>>   }
>>   EXPORT_SYMBOL(swake_up_all);
> This is fundamentally wrong. The whole point of wake_up_all() is that
> _all_ is unbounded and should not ever land in a single critical
> section, be it IRQ or PREEMPT disabled. The above does both.

It seems to me to be better than what was there, certainly more efficient.

And if I understand this correctly it is unbounded when !RT, but it is 
bounded
on RT.

And I'm biased, because it should fix my problem :).

> Yes, wake_up_all() is crap, it is also fundamentally incompatible with
> in-*irq usage. Nothing to be done about that.
>
> So NAK on this.

So what would you suggest?  At this point getting rid of all the users of
wake_up_all() from interrupt context is not really an option, though as
an eventual goal it would be good.

-corey
