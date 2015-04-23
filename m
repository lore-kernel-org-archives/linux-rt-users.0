From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 23 Apr 2015 09:14:35 +0200
Message-ID: <55389BDB.3060307@siemens.com>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>	 <5538915C.8010904@siemens.com> <1429772313.3419.38.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429772313.3419.38.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2015-04-23 08:58, Mike Galbraith wrote:
> On Thu, 2015-04-23 at 08:29 +0200, Jan Kiszka wrote:
>>
>>>  void irq_work_tick(void)
>>>  {
>>> -#ifdef CONFIG_PREEMPT_RT_FULL
>>> -       irq_work_run_list(this_cpu_ptr(&lazy_list));
>>> -#else
>>> -       struct llist_head *raised = &__get_cpu_var(raised_list);
>>> +       struct llist_head *raised = this_cpu_ptr(&raised_list);
>>>  
>>> -       if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
>>> +       if (!llist_empty(raised) && 
>>> (!arch_irq_work_has_interrupt() ||
>>> +           IS_ENABLED(CONFIG_PREEMPT_RT_FULL)))
>>
>> OK, that additional condition is addressing archs that don't have
>> irq_work support and fall back to the timer, right?
> 
> How will ever run if it is not run in either irq_work_run() or 
> irq_work_tick()?  There are two choices, we better pick one.

Ah, now I see it. Indeed.

OK, will run through your fix and suggestions and come up with a new
version.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
