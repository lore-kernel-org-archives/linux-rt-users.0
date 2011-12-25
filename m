From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.0.14-rt31 + 64 cores = very bad jitter == highly
 synchronized tick?
Date: Sun, 25 Dec 2011 08:31:59 +0100
Message-ID: <1324798319.9168.22.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:35338 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751049Ab1LYHcF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Dec 2011 02:32:05 -0500
In-Reply-To: <1324717569.5025.73.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-12-24 at 10:06 +0100, Mike Galbraith wrote:
> Greetings,
> 
> I'm trying to convince 3.0-rt to perform on a 64 core box, and having a
> devil of a time with the darn thing.  I have a wild theory that cores
> are much more closely synchronized in newer kernels, and that's causing
> massive QPI jabbering and xtime lock contention as cores bang
> cpupri_set() and ktime_get() in lockstep.

Seems not so wild a theory.

          <idle>-0     [055]  1285.013088: mwait_idle <-cpu_idle
          <idle>-0     [053]  1285.013860: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [043]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [053]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [044]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [043]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [061]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [054]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [038]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [053]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [044]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [043]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [008]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [032]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [051]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [024]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [054]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [038]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [053]  1285.013861: rcu_irq_enter <-irq_enter
          <idle>-0     [044]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [045]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [006]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [043]  1285.013861: rcu_irq_enter <-irq_enter
          <idle>-0     [029]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [014]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [032]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [042]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [031]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [051]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [024]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [054]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [015]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [027]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [038]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [044]  1285.013861: rcu_irq_enter <-irq_enter
          <idle>-0     [053]  1285.013861: rcu_exit_nohz <-rcu_irq_enter
          <idle>-0     [035]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [045]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [022]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [028]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [050]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [043]  1285.013861: rcu_exit_nohz <-rcu_irq_enter
          <idle>-0     [049]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [061]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [019]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [032]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [029]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [014]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [024]  1285.013861: irq_enter <-smp_apic_timer_interrupt
          <idle>-0     [042]  1285.013861: native_apic_mem_write <-smp_apic_timer_interrupt
          <idle>-0     [039]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <idle>-0     [026]  1285.013861: smp_apic_timer_interrupt <-apic_timer_interrupt
          <....snipage>

Guess I need to fight fire with fire.  Make ticks jitter a little
somehow, so they don't make itimer wakeup jitter a truckload when it
collides with tick that is busy colliding with zillion other ticks.

'course that helps the real problem (dram sucks) not one bit.

	-Mike

