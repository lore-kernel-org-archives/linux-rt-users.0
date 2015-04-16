From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RT 3.18] ring-buffer: Mark irq_work as HARD_IRQ to prevent
 deadlocks
Date: Thu, 16 Apr 2015 17:29:35 +0200
Message-ID: <552FD55F.8000105@siemens.com>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>	<552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:40697 "EHLO thoth.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbbDPP3n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 11:29:43 -0400
In-Reply-To: <20150416111041.66043164@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-04-16 17:10, Steven Rostedt wrote:
> On Thu, 16 Apr 2015 16:28:58 +0200
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 2015-04-16 16:26, Sebastian Andrzej Siewior wrote:
>>> On 04/16/2015 04:06 PM, Jan Kiszka wrote:
>>>> ftrace may trigger rb_wakeups while holding pi_lock which will also be
>>>> requested via trace_...->...->ring_buffer_unlock_commit->...->
>>>> irq_work_queue->raise_softirq->try_to_wake_up. This quickly causes
>>>> deadlocks when trying to use ftrace under -rt.
>>>>
>>>> Resolve this by marking the ring buffer's irq_work as HARD_IRQ.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> I'm not yet sure if this doesn't push work into hard-irq context that
>>>> is better not done there on -rt.
>>>
>>> everything should be done in the soft-irq.
>>>
>>>>
>>>> I'm also not sure if there aren't more such cases, given that -rt turns
>>>> the default irq_work wakeup policy around. But maybe we are lucky.
>>>
>>> The only thing that is getting done in the hardirq is the FULL_NO_HZ
>>> thingy. I would be _very_ glad if we could keep it that way.
> 
> tracing is special, even more so than NO_HZ_FULL, as it also traces
> that as well (and even RCU). Tracing the kernel is like a debugger.
> Ideally, it would not be part of the kernel, but just an external
> observer. Without special hardware that is not the case, so we try to
> be outside the main system as much as possible.
> 
> 
>>
>> Then - to my current understanding - we need an NMI-safe trigger for
>> soft-irq work. Is there anything like this existing already? Or can we
>> still use the IPI-based kick without actually doing the work in hard-irq
>> context?
>>
> 
> The reason why it uses irq_work() is because a simple wakeup can
> deadlock the system if called by the tracing infrastructure (as we see
> raise_softirq() does too).
> 
> But yeah, there's no real need to have the ring buffer irq work
> handler run from hardirq context. The only requirement is that you can
> not do the raise from the irq_work_queue call. If you want to have the
> hardirq work handle do the raise softirq, that's fine. Perhaps that's
> the solution? Have all irq_work_queue() always trigger the hard irq, but
> the hard irq may just raise a softirq or it will call the handler
> directly if IRQ_WORK_HARD_IRQ is set.

I'll play with that.

My patch is definitely not OK. It causes

[  380.372579] BUG: scheduling while atomic: trace-cmd/2149/0x00010004
...
[  380.372604] Call Trace:
[  380.372610]  <IRQ>  [<ffffffff81607694>] dump_stack+0x50/0x9f
[  380.372613]  [<ffffffff8160413c>] __schedule_bug+0x59/0x69
[  380.372615]  [<ffffffff8160a1d5>] __schedule+0x675/0x800
[  380.372617]  [<ffffffff8160a394>] schedule+0x34/0xa0
[  380.372619]  [<ffffffff8160bf7d>] rt_spin_lock_slowlock+0xcd/0x290
[  380.372621]  [<ffffffff8160d8b5>] rt_spin_lock+0x25/0x30
[  380.372623]  [<ffffffff8108fe39>] __wake_up+0x29/0x60
[  380.372626]  [<ffffffff81106960>] rb_wake_up_waiters+0x40/0x50
[  380.372628]  [<ffffffff8112cdbf>] irq_work_run_list+0x3f/0x60
[  380.372630]  [<ffffffff8112cdf9>] irq_work_run+0x19/0x20
[  380.372632]  [<ffffffff81008409>] smp_trace_irq_work_interrupt+0x39/0x120
[  380.372633]  [<ffffffff8160f8ef>] trace_irq_work_interrupt+0x6f/0x80
[  380.372636]  <EOI>  [<ffffffff8103d66d>] ? native_apic_msr_write+0x2d/0x30
[  380.372637]  [<ffffffff8103d53d>] x2apic_send_IPI_self+0x1d/0x20
[  380.372638]  [<ffffffff8100851e>] arch_irq_work_raise+0x2e/0x40
[  380.372639]  [<ffffffff8112d025>] irq_work_queue+0xc5/0xf0
[  380.372641]  [<ffffffff81107d8a>] ring_buffer_unlock_commit+0x14a/0x2e0
[  380.372643]  [<ffffffff8110f894>] trace_buffer_unlock_commit+0x24/0x60
[  380.372644]  [<ffffffff8111f9da>] ftrace_event_buffer_commit+0x8a/0xc0
[  380.372647]  [<ffffffff811c58de>] ftrace_raw_event_writeback_dirty_inode_template+0x8e/0xc0
[  380.372648]  [<ffffffff811c8b21>] __mark_inode_dirty+0x1d1/0x310
[  380.372650]  [<ffffffff811d0ec8>] generic_write_end+0x78/0xb0
[  380.372658]  [<ffffffffa021c42b>] ext4_da_write_end+0x10b/0x2f0 [ext4]
[  380.372661]  [<ffffffff8116335e>] ? pagefault_enable+0x1e/0x20
[  380.372662]  [<ffffffff8113c337>] generic_perform_write+0x107/0x1b0
[  380.372664]  [<ffffffff8113e49f>] __generic_file_write_iter+0x15f/0x350
[  380.372668]  [<ffffffffa0210c91>] ext4_file_write_iter+0x101/0x3d0 [ext4]
[  380.372670]  [<ffffffff8118f59b>] ? __kmalloc+0x16b/0x250
[  380.372672]  [<ffffffff811ca96e>] ? iter_file_splice_write+0x8e/0x430
[  380.372673]  [<ffffffff811ca96e>] ? iter_file_splice_write+0x8e/0x430
[  380.372674]  [<ffffffff811cab35>] iter_file_splice_write+0x255/0x430
[  380.372676]  [<ffffffff811cc474>] SyS_splice+0x214/0x760
[  380.372677]  [<ffffffff81011fe7>] ? syscall_trace_enter_phase2+0xa7/0x1e0
[  380.372679]  [<ffffffff8160e266>] tracesys_phase2+0xd4/0xd9

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
