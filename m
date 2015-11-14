From: yjin <yanjiang.jin@windriver.com>
Subject: Re: [RT PATCH] sched: rt: fix two possible deadlocks in push_irq_work_func
Date: Sat, 14 Nov 2015 12:40:42 +0800
Message-ID: <5646BB4A.50307@windriver.com>
References: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com> <20151113232512.53df431f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <mingo@redhat.com>, <bigeasy@linutronix.de>,
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<jinyanjiang@gmail.com>, <stable-rt@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151113232512.53df431f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On 2015=E5=B9=B411=E6=9C=8814=E6=97=A5 12:25, Steven Rostedt wrote:
> On Sat, 14 Nov 2015 10:53:18 +0800
> <yanjiang.jin@windriver.com> wrote:
>
>> From: Yanjiang Jin <yanjiang.jin@windriver.com>
>>
>> This can only happen in RT kernel due to run_timer_softirq() calls
>> irq_work_tick() when CONFIG_PREEMPT_RT_FULL is enabled as below:
>>
>> static void run_timer_softirq(struct softirq_action *h)
>> {
>> ........
>> if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
>>          irq_work_tick();
>> endif
>> ........
>> }
>>
>> Use raw_spin_{un,}lock_irq{save,restore} in push_irq_work_func() to
>> prevent following potentially deadlock scenario:
> Ug. No, the real fix is that the irq work is to be run from hard
> interrupt context.
But if so, we shouldn't call irq_work_tick() in run_timer_softirq(), ri=
ght?

Thanks!
Yanjiang
> Moving the scheduling of high priority real-time
> tasks to ksoftirqd defeats the purpose. The question is, why is that
> irq work being run from thread context when it has the
> IRQ_WORK_HARD_IRQ flag set?
>
> -- Steve
>
