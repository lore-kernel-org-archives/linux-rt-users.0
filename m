From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 11:18:23 -0700
Message-ID: <1256235503.10735.32.camel@quadrophenia.thebigcorporation.com>
References: <20091022120832.4bfd29e2@torg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:33038 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbZJVSYe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 14:24:34 -0400
Received: by pxi1 with SMTP id 1so3294585pxi.33
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 11:24:38 -0700 (PDT)
In-Reply-To: <20091022120832.4bfd29e2@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-10-22 at 12:08 -0500, Clark Williams wrote:
> So, please read and critique the following:
> 
> Q. How does the Linux RT kernel improve "latency"?
> 
> A. The Linux RT patch modifies the behavior of 

> spinlocks and

simpler: "Kernel-level locking". Avoids "whats a spinlock?"

> interrupt handling, to increase the number of points where a
> preemption or reschedule may occur. This reduces the amount of time a
> high priority task must wait to be scheduled when it becomes ready to
> run, reducing event service time (or "latency"). 
> 
> Most spinlocks in the kernel are converted to a construct called an
> rtmutex, which has the property of *not* disabling interrupts while
> the lock is held and will sleep rather than spin.

Technically, not all spinlocks disable irqs.

maybe "property of *not* preventing task switching or suppressing
interrupt services on a particular CPU while..."

>  This means that
> interrupts will occur while rtmutexes are held and interrupt handling
> is a potential preemption point; on return from handling an interrupt,
> a scheduler check is made as to whether a higher priority thread needs
> to run.
> 
> The rtmutex locking construct also has a property known as "priority
> inheritance", which is a mechanism for avoiding a deadlock situation
> known as "priority inversion". In order to prevent a low priority
> thread that is holding a lock from preventing a higher priority thread
> from running, the low priority thread temporarily inherits the
> priority of the highest priority thread that is requesting the lock,
> which allows the low-priority thread to run until it completes its
> critical section and releases the lock. 
> 
> In addition to changing spinlocks, interrupts have been threaded,
> meaning that instead of handling interrupts in a special "interrupt
> context", each IRQ has a dedicated thread for running its
> ISRs. Interrupts go to a common handler and the handler schedules the
> appropriate thread to handle the interrupt. This means that sleeping
> spinlocks (rtmutexes) have a context to return to and that interrupt
> handling can be prioritized by assigning appropriate realtime
> priorities to the interrupt threads. 

Further, user-level processes may be prioritized above device-level
services, allowing computational load and I/O load to be dynamically
expedited, partitioned, or decoupled.



