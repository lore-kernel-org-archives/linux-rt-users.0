From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
Date: Fri, 27 Nov 2009 20:43:00 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911272024280.24119@localhost.localdomain>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com> <200911210044.09962@blacky.localdomain> <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	rt-users <linux-rt-users@vger.kernel.org>
To: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:50733 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbZK0TnF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Nov 2009 14:43:05 -0500
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 20 Nov 2009, Leyendecker, Robert wrote:

> Here is what was in the log/messages - I assume this is what was
> sent to kernel.org.  Host B is reporting destination unreachables at
> time of freeze.  Hope this log is useful. I have the full log from
> start of boot I can zip it up if you would like. At the bottom you
> can see where it is rebooting due to power cycle.

> Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
> Nov 20 21:12:00 localhost kernel: caller is __schedule+0xe/0x7d4
> Nov 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
> Nov 20 21:12:00 localhost kernel: Call Trace:
> Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
> Nov 20 21:12:00 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
> Nov 20 21:12:00 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
> Nov 20 21:12:00 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
> Nov 20 21:12:00 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
> Nov 20 21:12:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19

Hmm, that comes from the low level code. We should have interrupts
disabled here, but I have a hard time to figure out the call path in
the ASM maze of entry_32.S. Still investigating.

Thanks,

	tglx

