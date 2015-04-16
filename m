From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3.18] ring-buffer: Mark irq_work as HARD_IRQ to
 prevent deadlocks
Date: Thu, 16 Apr 2015 11:10:41 -0400
Message-ID: <20150416111041.66043164@gandalf.local.home>
References: <552FC1FE.4020406@siemens.com>
	<552FC6B1.1040000@linutronix.de>
	<552FC72A.8060709@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:57682 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750715AbbDPPKp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 11:10:45 -0400
In-Reply-To: <552FC72A.8060709@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 16 Apr 2015 16:28:58 +0200
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 2015-04-16 16:26, Sebastian Andrzej Siewior wrote:
> > On 04/16/2015 04:06 PM, Jan Kiszka wrote:
> >> ftrace may trigger rb_wakeups while holding pi_lock which will also be
> >> requested via trace_...->...->ring_buffer_unlock_commit->...->
> >> irq_work_queue->raise_softirq->try_to_wake_up. This quickly causes
> >> deadlocks when trying to use ftrace under -rt.
> >>
> >> Resolve this by marking the ring buffer's irq_work as HARD_IRQ.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>
> >> I'm not yet sure if this doesn't push work into hard-irq context that
> >> is better not done there on -rt.
> > 
> > everything should be done in the soft-irq.
> > 
> >>
> >> I'm also not sure if there aren't more such cases, given that -rt turns
> >> the default irq_work wakeup policy around. But maybe we are lucky.
> > 
> > The only thing that is getting done in the hardirq is the FULL_NO_HZ
> > thingy. I would be _very_ glad if we could keep it that way.

tracing is special, even more so than NO_HZ_FULL, as it also traces
that as well (and even RCU). Tracing the kernel is like a debugger.
Ideally, it would not be part of the kernel, but just an external
observer. Without special hardware that is not the case, so we try to
be outside the main system as much as possible.


> 
> Then - to my current understanding - we need an NMI-safe trigger for
> soft-irq work. Is there anything like this existing already? Or can we
> still use the IPI-based kick without actually doing the work in hard-irq
> context?
> 

The reason why it uses irq_work() is because a simple wakeup can
deadlock the system if called by the tracing infrastructure (as we see
raise_softirq() does too).

But yeah, there's no real need to have the ring buffer irq work
handler run from hardirq context. The only requirement is that you can
not do the raise from the irq_work_queue call. If you want to have the
hardirq work handle do the raise softirq, that's fine. Perhaps that's
the solution? Have all irq_work_queue() always trigger the hard irq, but
the hard irq may just raise a softirq or it will call the handler
directly if IRQ_WORK_HARD_IRQ is set.

-- Steve
