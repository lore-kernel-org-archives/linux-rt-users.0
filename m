From: Stanislav Meduna <stano@meduna.org>
Subject: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
Date: Mon, 14 Apr 2014 21:24:54 +0200
Message-ID: <534C3606.7010206@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:33803 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbaDNTyg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Apr 2014 15:54:36 -0400
Received: from dial-95-105-163-217-orange.orange.sk ([95.105.163.217] helo=[127.0.0.1])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1WZmUz-0006qA-5b
	for linux-rt-users@vger.kernel.org; Mon, 14 Apr 2014 21:24:59 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

hunting another problem with AUART acting weirdly I got

BUG: spinlock trylock failure on UP on CPU#0, ksoftirqd/0/3
 lock: boot_tvec_bases+0x0/0x10a0, .magic: dead4ead, .owner: ksoftirqd/0/3, .owner_cpu: 0
CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 3.12.15-rt25-00371-gfec62f5-dirty #26
[<c00149ec>] (unwind_backtrace+0x0/0xf4) from [<c0012ab0>] (show_stack+0x10/0x14)
[<c0012ab0>] (show_stack+0x10/0x14) from [<c01a4b80>] (do_raw_spin_trylock+0x4c/0x58)
[<c01a4b80>] (do_raw_spin_trylock+0x4c/0x58) from [<c02ca0b4>] (_raw_spin_trylock+0x20/0x98)
[<c02ca0b4>] (_raw_spin_trylock+0x20/0x98) from [<c02c9654>] (rt_spin_trylock+0x14/0xd0)
[<c02c9654>] (rt_spin_trylock+0x14/0xd0) from [<c00285cc>] (run_local_timers+0x24/0x78)
[<c00285cc>] (run_local_timers+0x24/0x78) from [<c0028654>] (update_process_times+0x34/0x68)
[<c0028654>] (update_process_times+0x34/0x68) from [<c005f0ac>] (tick_sched_timer+0x58/0x22c)
[<c005f0ac>] (tick_sched_timer+0x58/0x22c) from [<c003f2f8>] (__run_hrtimer+0x7c/0x2a8)
[<c003f2f8>] (__run_hrtimer+0x7c/0x2a8) from [<c003f684>] (hrtimer_interrupt+0x104/0x30c)
[<c003f684>] (hrtimer_interrupt+0x104/0x30c) from [<c0230a84>] (mxs_timer_interrupt+0x20/0x2c)
[<c0230a84>] (mxs_timer_interrupt+0x20/0x2c) from [<c0051d1c>] (handle_irq_event_percpu+0x80/0x2f8)
[<c0051d1c>] (handle_irq_event_percpu+0x80/0x2f8) from [<c0051fd0>] (handle_irq_event+0x3c/0x5c)
[<c0051fd0>] (handle_irq_event+0x3c/0x5c) from [<c0054778>] (handle_level_irq+0x8c/0x118)
[<c0054778>] (handle_level_irq+0x8c/0x118) from [<c0051c8c>] (generic_handle_irq+0x28/0x30)
[<c0051c8c>] (generic_handle_irq+0x28/0x30) from [<c001009c>] (handle_IRQ+0x30/0x84)
[<c001009c>] (handle_IRQ+0x30/0x84) from [<c0013324>] (__irq_svc+0x44/0x88)
[<c0013324>] (__irq_svc+0x44/0x88) from [<c006a664>] (__try_to_take_rt_mutex+0x4/0x144)
[<c006a664>] (__try_to_take_rt_mutex+0x4/0x144) from [<00000000>] (  (null))


Linux nxt 3.12.15-rt25-00371-gfec62f5-dirty #26 PREEMPT RT Mon Apr 14 20:40:56 CEST 2014 armv5tejl GNU/Linux

This is on a Freescale i.MX28, 3.12.15-rt25 with patches that do not touch
anything related.


On a side note: is it possible that the newer ARM kernels have some
requirements regarding the compiler (I am using gcc 4.4.5)? I don't
understand what I am seeing in the AUART problem and it can be well
something regarding the optimization. However, I had no problems
running 3.4 built using the same compiler.

Thanks
-- 
                                                   Stano
