From: Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] fix might sleep oops in irq affinity callback hook
Date: Thu, 22 Aug 2013 15:01:03 -0400
Message-ID: <20130822190103.GA3198@tsunami.ccur.com>
References: <20130820175918.GA18125@tsunami.ccur.com>
 <20130821155347.GB16913@linutronix.de>
 <20130821210928.GA14467@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:59020 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752631Ab3HVTBR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Aug 2013 15:01:17 -0400
Content-Disposition: inline
In-Reply-To: <20130821210928.GA14467@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 21, 2013 at 05:09:28PM -0400, Joe Korty wrote:
> On Wed, Aug 21, 2013 at 11:53:47AM -0400, Sebastian Andrzej Siewior wrote:
> > Joe could you please test this one? In 3.10 we have one user of
> > __irq_set_affinity_locked() and we might get more.
> 
> Hi Sebastian,
> I backported the patch to 3.6.11.6-rt38 and added a few printk's so that
> when daemon started I would see that and when each affinity hook was
> executed I would see that too.
> 
> The system came up and the printk for daemon start showed up near where
> the sfc driver started, but no affinity action printk appeared.  Thus
> the patch as written does not seem to work.


Hi Sebastian,
Today I intrumented both the nort and rt paths through the
affinity hook logic, and built and booted both nort and
rt kernels.  Here is what I found:

For the nort kernel, each time I change the affinity of
one of the SFC driver IRQs listed in /proc/interrupts,
I get a notice in dmesg that the SFC callback was invoked.

For the rt kernel, I get the message only for the first
time the affinity for some SFC IRQ is changed.  Subsequent
changes of the _same_ IRQ do not have the callback invoked.
If I go and change some other SFC IRQ that will also invoke
the callback the first time only.

   finny# echo 1 >/proc/irq/46/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   finny# echo 1 >/proc/irq/46/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   finny# echo 1 >/proc/irq/46/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   finny# echo 2 >/proc/irq/46/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   finny# echo 2 >/proc/irq/47/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   genirq: NOTIFIER CALLED ...
   finny# echo 2 >/proc/irq/47/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   genirq: NOTIFIER CALLED ...
   finny# echo 1 >/proc/irq/47/smp_affinity; dmesg | fgrep genirq
   genirq: set_affinity_thread STARTED
   genirq: NOTIFIER CALLED ...
   genirq: NOTIFIER CALLED ...


Regards,
Joe
