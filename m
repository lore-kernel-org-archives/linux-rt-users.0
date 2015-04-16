From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RT 3.18] ring-buffer: Mark irq_work as HARD_IRQ to prevent
 deadlocks
Date: Thu, 16 Apr 2015 17:31:21 +0200
Message-ID: <552FD5C9.2080702@siemens.com>
References: <552FC1FE.4020406@siemens.com> <552FC6B1.1040000@linutronix.de> <552FC72A.8060709@siemens.com> <552FCDD3.2010804@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:41839 "EHLO thoth.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbbDPPb0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 11:31:26 -0400
In-Reply-To: <552FCDD3.2010804@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-04-16 16:57, Sebastian Andrzej Siewior wrote:
> On 04/16/2015 04:28 PM, Jan Kiszka wrote:
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
>>
>> Then - to my current understanding - we need an NMI-safe trigger for
>> soft-irq work. Is there anything like this existing already? Or can we
>> still use the IPI-based kick without actually doing the work in hard-irq
>> context?
> 
> But if you trigger it via IPI it will still run in hardirq context,
> right? Can you describe how run into this and try to think about it in
> a quiet moment. It it just enabling the function tracer and running it?

# trace-cmd record -e sched
/sys/kernel/debug/tracing/events/sched/filter
/sys/kernel/debug/tracing/events/*/sched/filter
Hit Ctrl^C to stop recording
^C

and you are dead(locked).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
