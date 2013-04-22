From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] Re: timerfd read does not return
Date: Mon, 22 Apr 2013 10:55:23 +0200
Message-ID: <5174FAFB.7010105@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <5171A0D0.8050100@meduna.org> <5174E842.4050408@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:34095 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab3DVIze (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Apr 2013 04:55:34 -0400
In-Reply-To: <5174E842.4050408@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 22.04.2013 09:35, Stanislav Meduna wrote:

> FWIW, the following patch seems to solve the issue for me.
> Unfortunately I have no idea whether this is a sane way to
> do and whether it solves or just masks or delays the issue,

Unfortunately it only delays it (funny how it crashes minutes
after I write to the list, after running for hours and hours
before), so please, disregard :(

The dumped call trace at the time the throttler kicks in this time

restore_all+0xf/0xf
irq_exit+0x6d/0x80
sub_preempt_count+0x36/0x50
irq_exit+0x6d/0x80
do_IRQ+0x48/0x94
__kunmap_atomic+0x50/0x60
handle_pte_fault+0x141/0xa00
trace_hardirqs_on_thunk+0xc/0x10
restore_all+0xf/0xf
handle_mm_fault+0x80/0xc0
rt_up_read+0x1d/0x30
do_page_fault+0x168/0x390
irq_exit+0x6d/0x80
irq_to_desc+0x14/0x20
handle_irq+0x1f/0x90
do_IRQ+0x3f/0x94
common_interrupt+0x2e/0x40
__kill_pgrp_info+0x5b/0x60
__put_user_8+0x11/0x19
timerfd_read+0x18e/0x2a0
wake_up_bit+0x60/0x60
vfs_read+0x9f/0x150
fget_light+0x87/0xe0
sys_timerfd_gettime+0x140/0x140
sys_read+0x42/0x70
syscall_call+0x7/0xb
init_memory_mapping+0x230/0x410

and again the last logged trace is sched_switch to the timer thread
and there is no softirq_exit from HRTIMER


Again __put_user_8 and then something signal-related. Note: I do not
(knowingly) use signals in my application, neither explicitly nor
pthread_cancel or something like that via glibc.

The problem does not manifest if I use timer_create instead
of timerfd (at least such version did run for 2,5 days without
a problem).

Regards
-- 
                                   Stano

