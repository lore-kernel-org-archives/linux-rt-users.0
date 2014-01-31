From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] timer: really raise softirq if there is irq_work to
 do
Date: Fri, 31 Jan 2014 14:56:25 -0500
Message-ID: <20140131145625.51128a8b@gandalf.local.home>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>
	<1391178845-15837-2-git-send-email-bigeasy@linutronix.de>
	<20140131120757.594e24d6@gandalf.local.home>
	<20140131174227.GN9012@linux.vnet.ibm.com>
	<20140131125719.73340f6e@gandalf.local.home>
	<52EBF8FE.3080608@linutronix.de>
	<20140131143441.478f79ee@gandalf.local.home>
	<52EBFE1D.4020201@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, paulmck@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:32561 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752785AbaAaT41 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jan 2014 14:56:27 -0500
In-Reply-To: <52EBFE1D.4020201@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 31 Jan 2014 20:48:45 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > As I have worked on code that uses irq_work() I can say that we want
> > the arch specific interrupts. For those architectures that don't have
> > it will experience larger latencies for the work required. It's
> > basically, a "too bad" for them.
> 
> How "bad" is it? Is this something generic or just not getting
> perf events fast enough out? Most users don't seem to require small
> latencies.

I use it for waking up trace-cmd, and if it is too long, then it we can
miss lots of events. Same goes for perf.

Remember, irq_work can be triggered from NMI context. That means, if
the CPU is idle, it may be several seconds before that work happens.
That is WAY too long to wait.

Anyway, your suggestion to get rid of the arch code doesn't help. We
call the irq_work_run() from interrupt context whether there is work or
not, with or without removing the arch code. The only thing your
suggestion will do is to push the work from happening immediately to
happening on the timer tick (which may be several seconds later). I
don't see the savings.

-- Steve

