From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Mon, 11 May 2015 20:15:06 -0400
Message-ID: <20150511201506.29a5c3e2@gandalf.local.home>
References: <55245FC8.9090509@osadl.org>
	<5526AE86.7030708@linutronix.de>
	<20150410123634.GA3057@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:52276 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751917AbbELAPJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 May 2015 20:15:09 -0400
In-Reply-To: <20150410123634.GA3057@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 10 Apr 2015 14:36:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> Subject: [PATCH] kernel/irq_work: fix no_hz deadlock
> 
> Invoking NO_HZ's irq_work callback from timer irq is not working very
> well if the callback decides to invoke hrtimer_cancel():
> 
> |hrtimer_try_to_cancel+0x55/0x5f
> |hrtimer_cancel+0x16/0x28
> |tick_nohz_restart+0x17/0x72
> |__tick_nohz_full_check+0x8e/0x93
> |nohz_full_kick_work_func+0xe/0x10
> |irq_work_run_list+0x39/0x57
> |irq_work_tick+0x60/0x67
> |update_process_times+0x57/0x67
> |tick_sched_handle+0x4a/0x59
> |tick_sched_timer+0x3b/0x64
> |__run_hrtimer+0x7a/0x149
> |hrtimer_interrupt+0x1cc/0x2c5
> 
> and here we deadlock while waiting for the lock which we are holding.
> To fix this I'm doing the same thing that upstream is doing: is the
> irq_work dedicated IRQ and use it only for what is marked as "hirq"
> which should only be the FULL_NO_HZ related work.

I'm backporting this to the stable releases, and I'm a bit worried
about the above comment. The new Scheduler IPI code uses work queues and
requires it to be done in a hard irq.

-- Steve
