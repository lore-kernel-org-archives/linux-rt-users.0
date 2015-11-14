From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT PATCH] sched: rt: fix two possible deadlocks in
 push_irq_work_func
Date: Fri, 13 Nov 2015 23:25:12 -0500
Message-ID: <20151113232512.53df431f@gandalf.local.home>
References: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <mingo@redhat.com>, <bigeasy@linutronix.de>,
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<jinyanjiang@gmail.com>, <stable-rt@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: <yanjiang.jin@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 14 Nov 2015 10:53:18 +0800
<yanjiang.jin@windriver.com> wrote:

> From: Yanjiang Jin <yanjiang.jin@windriver.com>
> 
> This can only happen in RT kernel due to run_timer_softirq() calls
> irq_work_tick() when CONFIG_PREEMPT_RT_FULL is enabled as below:
> 
> static void run_timer_softirq(struct softirq_action *h)
> {
> ........
> if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
>         irq_work_tick();
> endif
> ........
> }
> 
> Use raw_spin_{un,}lock_irq{save,restore} in push_irq_work_func() to
> prevent following potentially deadlock scenario:

Ug. No, the real fix is that the irq work is to be run from hard
interrupt context. Moving the scheduling of high priority real-time
tasks to ksoftirqd defeats the purpose. The question is, why is that
irq work being run from thread context when it has the
IRQ_WORK_HARD_IRQ flag set?

-- Steve
