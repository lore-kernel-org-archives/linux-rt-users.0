From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Mon, 13 Apr 2015 11:43:36 +0200
Message-ID: <552B8FC8.90906@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>	 <20150410141552.GC3057@linutronix.de> <1428758159.10417.13.camel@gmail.com> <1428759368.10417.25.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428759368.10417.25.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/11/2015 03:36 PM, Mike Galbraith wrote:
> On Sat, 2015-04-11 at 15:15 +0200, Mike Galbraith wrote:
>>
>> @@ -117,10 +113,8 @@ bool irq_work_queue(struct irq_work *wor
>>         if (work->flags & IRQ_WORK_HARD_IRQ) {
>>                 if (llist_add(&work->llnode, 
>> this_cpu_ptr(&hirq_work_list)))
>>                         arch_irq_work_raise();
>> -       } else {
>> -               if (llist_add(&work->llnode, 
>> this_cpu_ptr(&lazy_list)))
>> -                       arch_irq_work_raise();
>> -       }
>> +       } /* for lazy_list we have the timer irq */
>>
>> If we don't queue work without IRQ_WORK_HARD_IRQ set, how does it 
>> run?
>>
>> Anyway, box did not livelock, nor did it with that bit reverted.
> 
> Well, not reverted, I actually queued and maybe poked softirq, but 
> didn't check whether anything was being queued or not, only caring for 
> the nonce whether box went catatonic or kept on working.
> 
> @@ -118,8 +115,9 @@ bool irq_work_queue(struct irq_work *wor
>                 if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
>                         arch_irq_work_raise();
>         } else {
> -               if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
> -                       arch_irq_work_raise();
> +               if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
> +                   tick_nohz_tick_stopped())
> +                       raise_softirq(TIMER_SOFTIRQ);

This sounds like a good idea actually. Thanks.

Sebastian
