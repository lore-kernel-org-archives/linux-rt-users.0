Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BF1C35646
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9C20722
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 17:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgBURyV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:54:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46424 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBURyV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 12:54:21 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j5CVH-0007Va-IY; Fri, 21 Feb 2020 18:54:19 +0100
Date:   Fri, 21 Feb 2020 18:54:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Kansky, Jan E." <jan.kansky@cfa.harvard.edu>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Debugging unexpected latency on a new Xeon W C422 system
Message-ID: <20200221175419.dxffmypqol5g7vip@linutronix.de>
References: <CAGF5Q78rz5ULUgcH5Kv_GCLj+-aLfBaV9J0XGHKo6k+hvrjDiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGF5Q78rz5ULUgcH5Kv_GCLj+-aLfBaV9J0XGHKo6k+hvrjDiQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-20 11:56:23 [-0500], Kansky, Jan E. wrote:
> For both kernels, I run cyclictest:
> ./cyclictest -p 98 --smp -b 600  -f -m

you could use the -b option to stop the trace once you hit the 2ms
latency.

> The trace results show that the unexpected large latency seems to
> occur in the following ways:
> 
> llvmpipe-9436    3d...... 4901974us!: switch_fpu_return
> <-prepare_exit_to_usermode
> llvmpipe-9436    3d...... 4902845us : smp_apic_timer_interrupt
> <-apic_timer_interrupt

It is sometimes hard to read with the additional line feed.
However, this is probably okay because you return to user space and come
back later after a timer interrupt.

> or
> 
>     Xorg-8825    3....... 4905576us!: kfree <-__audit_syscall_exit
>   <idle>-0       2d...1.. 4905876us : smp_apic_timer_interrupt
> <-apic_timer_interrupt
> 
> or
>   <idle>-0       2d...1.. 4905910us!: mwait_idle <-default_idle_call
>   <idle>-0       0d...1.. 4906049us : smp_apic_timer_interrupt
> <-apic_timer_interrupt
> 
> or
> 
> llvmpipe-9435    1d...... 4917323us!: rcu_irq_exit <-irq_exit
> llvmpipe-9438    3d...... 4917845us : smp_apic_timer_interrupt
> <-apic_timer_interrupt

The number before the d is the CPU number. So if you kfree() on CPU3
follwed by smp_apic_timer_interrupt() on CPU2 there is no need to worry.
Same for the other two examples. You need to see what happens after that
gap.

> I do see NMIs occurring on the system, although not all latency events
> seem to correlate with an increment in the NMI counter in
> /proc/interrupts.

perf may be responsible for some of them or the "hardware watchdog". If
you suspect that the BIOS is doing something, there is the
CONFIG_HWLAT_TRACER to proof it.

> I would greatly appreciate any advice on what I should do to trace the
> problem with this new system.  I can send my .config files if needed.
> CONFIG_PREEMPT_RT_FULL=y is set.
> 
> Thanks!
> Jan

Sebastian
