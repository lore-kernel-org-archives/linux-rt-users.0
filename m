From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Tue, 19 May 2015 02:07:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505190207070.4225@nanos>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com> <20150506193803.GC32577@8074w.roxell.se> <CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com> <20150508000929.GE31914@8074w.roxell.se>
 <CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com> <20150514160733.GE13442@linutronix.de> <CAPyr0yL8xJt4bj7poLFrauR0wtfKB7nPg+uy4A+R0dTT-eM3Qw@mail.gmail.com> <CAF7YWnw08YK7ogAoLTYXusOvtGCxfDPJW0H+8LyWDzNi_CbR=w@mail.gmail.com>
 <20150518213835.GD4275@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gary Robertson <gary.robertson@linaro.org>,
	Ayyappa Ch <ayyappa.ch.linux@gmail.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	RT <linux-rt-users@vger.kernel.org>,
	Kevin Hilman <kevin.hilman@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51830 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbESAHo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 May 2015 20:07:44 -0400
In-Reply-To: <20150518213835.GD4275@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 18 May 2015, Sebastian Andrzej Siewior wrote:

> * Gary Robertson | 2015-05-18 08:23:16 [-0500]:
> 
> >I have been following this thread and was able to obtain a copy of the full
> >log from Anders.
> >My initial impression based upon the log entries is that the excessive
> >latencies did not occur during the fpsimd calls -
> >but the actual progress of an individual task is a bit difficult to follow
> >through the logs, so in my spare time
> >I started writing a parser to sort it into a format easier to follow.  I
> >hope to have it completed shortly.
> >This parser will sort the log first by CPU and then by thread so the cause
> >of the delay will be easier to see.
> 
> There is a smaller version of it at 
>     https://breakpoint.cc/arm64_simd_trace_cpu.txt
> 
> which contains only CPU0 around that "event. Here are a few pieces:
> |cyclicte-964     0....1.. 511965877us : __schedule <-schedule
> cyclictest goes away
> 
> |kworker/-353     0....111 511965906us : rt_spin_unlock <-process_one_work
> kworker is now active
> 
> |kworker/-353     0....112 511965954us : kernel_neon_begin_partial <-virt_efi_set_time
> |kworker/-353     0....112 511965955us : preempt_count_add <-kernel_neon_begin_partial
> and kworker invokes virt_efi_set_time which does the neon save thingy.
> 
> |kworker/-353     0d...212 511966764us : __handle_domain_irq <-gic_handle_irq
> now we have an interrupt comming.
> 
> |kworker/-353     0dn.h412 511966793us : task_woken_rt <-ttwu_do_wakeup
> it might be the timer for cyclictest wakeup it might not, however we
> have the N flag set and kworker has to go.
> 
> |kworker/-353     0dn..212 511966806us : rcu_sysidle_enter <-rcu_irq_exit
> |kworker/-353     0dn..212 511967108us : __handle_domain_irq <-gic_handle_irq
> |kworker/-353     0dn..212 511967109us : irq_enter <-__handle_domain_irq
> so we finished handling one irq and we contiunue with the next one? This
> goes on and on and on until finally after a while we have this:
> 
> |kworker/-353     0dn..212 512064373us : rcu_irq_exit <-irq_exit
> |kworker/-353     0dn..212 512064374us : rcu_sysidle_enter <-rcu_irq_exit
> |kworker/-353     0.n..212 512065116us : kernel_neon_end <-virt_efi_set_time
> |kworker/-353     0.n..212 512065116us : preempt_count_sub <-kernel_neon_end
> |kworker/-353     0.n..112 512065117us : __schedule <-preempt_schedule
> 
> and this time we were able to return from rcu_irq_exit and continue with
> virt_efi_set_time and finally switch the task. So yes, preemption was
> disabled during kernel_neon_{being|end} but we also received 81
> interrupt ("gic_handle_irq invocation") during that time. Why is that?

> |kworker/-353     0dn..212 512064373us : rcu_irq_exit <-irq_exit
> |kworker/-353     0dn..212 512064374us : rcu_sysidle_enter <-rcu_irq_exit

That's called from RCU_NONIDLE(). Go figure ...

Thanks,

	tglx


