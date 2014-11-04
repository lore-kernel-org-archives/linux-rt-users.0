From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: which kernel thread handles NMIs?
Date: Mon, 3 Nov 2014 20:35:45 -0500
Message-ID: <20141103203545.1ee168fd@gandalf.local.home>
References: <5457EEC3.5010506@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Chris Friesen <chris.friesen@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:40107 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750834AbaKDBfv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Nov 2014 20:35:51 -0500
In-Reply-To: <5457EEC3.5010506@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 3 Nov 2014 15:08:19 -0600
Chris Friesen <chris.friesen@windriver.com> wrote:

> We're running with the 3.4 kernel with RT patch, and we're trying to 
> debug some issues.
> 
> One of the issues is that the magic sysrq "l" command to show a stack 
> backtrace on all CPUs doesn't seem to work, though other magic sysrq 
> commands do work properly.

I actually have a series of patches that would make this work nicely on
-rt. I'm working on them now but they are for mainline, which means if
you want them you will need to backport the code. Shouldn't be too hard.

> 
> Looking at the code, for X86 it seems to call 
> apic->send_IPI_all(NMI_VECTOR);
> 
> Does anyone know what kernel thread would handle NMI_VECTOR?  I want to 
> make sure its priority is sufficiently high.
> 

Um, NMI is not a thread. It's a "Non-Maskable Interrupt". Which means
that nothing will stop it from coming in. This is determined by
hardware, and not a -rt vs mainline thing.

Your issue is that due to deadlocks that printk can cause, the -rt
patch has code to prevent printing from interrupt disabled
(including NMI) context, because some of the printk routines can sleep,
and we can't let that happen if interrupts are disabled.

As I said. I have patches that will place the sysrq-l data into a
temporary buffer and will print them out after all the NMIs have
finished. And this is done from a nice preemptable context.

You can look at my test code here:

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  rfc/seq-buf

As these may be a bit too complex to backport (the original code had
complaints, and I needed to do much more to get this acceptable), you
may want to look at the original RFC patches:

http://marc.info/?l=linux-kernel&m=140321402925869&w=2

These may be much easier to backport.

-- Steve
