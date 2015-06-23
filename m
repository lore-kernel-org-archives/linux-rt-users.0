From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH][RT][RFC] irq_work: Have non HARD_IRQ irq work just run
 from ticks
Date: Tue, 23 Jun 2015 16:12:29 +0200
Message-ID: <5589694D.4040504@siemens.com>
References: <20150622150959.44055b32@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150622150959.44055b32@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2015-06-22 21:09, Steven Rostedt wrote:
> With PREEMPT_RT, the irq work callbacks are called from the softirq
> thread, unless the HARD_IRQ flag is set for the irq work. When an irq
> work item is added without the HARD_IRQ flag set, and without the LAZY
> flag set, an interrupt is raised, and that interrupt will wake up the
> softirq thread to run the irq work like it would do without PREEMPT_RT.
> 
> The current logic in irq_work_queue() will not raise the interrupt when
> the first irq work item added has the LAZY flag set. But if another
> irq work item is added without the LAZY flag set, and without the
> HARD_IRQ item set, the interrupt is not raised because the interrupt is
> only raised when the list was empty before adding the current irq work
> item.
> 
> This means that if an irq work item is added with the LAZY flag set, it
> will not raise the interrupt and that work item will have to wait till
> the next timer tick (which in computer terms is a long way away). Now
> if in the mean time, another irq work item is added without the LAZY
> flag set, and without the HARD_IRQ flag set (meaning it wants to run
> from the softirq), the interrupt will still not be raised. This is
> because the interrupt is only raised when the first item of the list is
> added. Future items added will not raise the interrupt. This makes the
> raising of the irq work callback non deterministic. Rather ironic
> considering this only happens when PREEMPT_RT is enabled.
> 
> 
> I have several ideas on how to fix this.
> 
> 1) Add another list (softirq_list), and add to it if PREEMPT_RT is
> enabled and the flag doesn't have either LAZY or HARD_IRQ flags set.
> This is what would be checked in the interrupt irq work callback
> instead of the lazy_list.
> 
> 2) Raise the interrupt whenever a first item is added to a list (lazy
> or otherwise) when PREEMPT_RT is enabled, and have the lazy with the
> non lazy handled by softirq.
> 
> 3) Only raise the hard interrupt when something is added to the
> raised_list. That is, for PREEMPT_RT, that would only be irq work that
> has the HARD_IRQ flag set. All other irq_work will be done when the
> tick happens. To keep things deterministic, the irq_work_run() no
> longer checks the lazy_list and is the same as the vanilla kernel.
> 
> 
> I'm thinking that ideally, #1 is the best choice. #2 has the issue
> where something may add itself as lazy, really expecting to be done
> from the next timer tick, but then happen from a "sooner" softirq.
> Although, I doubt that will really be an issue.
> 
> #3 (this patch), is something that I discussed with Sebastian, and he
> said that nothing should break if we wait at most 10ms for the next
> tick.
> 
> My concern here, is that the ipi call function (sending an irq work
> from another CPU without the HARD_IRQ flag set), on a NO_HZ cpu, may
> not wake it up to run it. Although, I'm not sure there's anything that
> uses cross CPU irq work without setting HARD_IRQ. I can add back the
> check to wake up the softirq, but then we make the timing of irq_work
> non deterministic again. Is that an issue?
> 
> But here's the patch presented to you as an RFC. I can write up #1 too
> if people think that would be the better solution.
> 
> Oh, and then there's #4, which is to do nothing. Just let irq work come
> in non deterministic, and that may not hurt anything either.

You could change upstream to be non-deterministic as well - then no one
could complain about PREEMPT-RT falling behind the stock kernel here. ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
