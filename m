From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] timer: really raise softirq if there is irq_work
 to do
Date: Fri, 31 Jan 2014 20:26:54 +0100
Message-ID: <52EBF8FE.3080608@linutronix.de>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>	<1391178845-15837-2-git-send-email-bigeasy@linutronix.de>	<20140131120757.594e24d6@gandalf.local.home>	<20140131174227.GN9012@linux.vnet.ibm.com> <20140131125719.73340f6e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org,
	paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56157 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567AbaAaT1D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jan 2014 14:27:03 -0500
In-Reply-To: <20140131125719.73340f6e@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/31/2014 06:57 PM, Steven Rostedt wrote:

> In vanilla Linux, irq_work_run() is called from update_process_times()
> when it is called from the timer interrupt. In -rt, there's reasons we

and in vanilla Linux some architectures (like x86 or sparc to name just
a few) overwrite arch_irq_work_raise() which means they provide
their "own" interrupt like callback. That means on those architectures
irq_work_run() gets invoked twice: once via update_process_times() and
via and once the custom interface.
So my question to the original inventor of this code: Peter, do we
really need that arch specific callback? Wouldn't one be enough? Is it
that critical that it can't wait to the next timer tick?

Sebastian

