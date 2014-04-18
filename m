From: Stanislav Meduna <stano@meduna.org>
Subject: tracing: BUG: sleeping function called from invalid context
Date: Fri, 18 Apr 2014 22:36:40 +0200
Message-ID: <53518CD8.4020706@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:40698 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbaDRUgv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Apr 2014 16:36:51 -0400
Received: from dial-95-105-163-217-orange.orange.sk ([95.105.163.217] helo=[127.0.0.1])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1WbFWd-0000SG-8Z
	for linux-rt-users@vger.kernel.org; Fri, 18 Apr 2014 22:36:47 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

tracing the irqsoff latency - not sure what exactly was that,
maybe tracing_on, maybe current_tracer:

BUG: sleeping function called from invalid context at /home/stano/Kernels/linux-3.12-rt/kernel/rtmutex.c:673
in_atomic(): 1, irqs_disabled(): 0, pid: 607, name: bash
3 locks held by bash/607:
 #0:  (sb_writers#8){......}, at: [<c00de6f4>] vfs_write+0x1cc/0x1d0
 #1:  (trace_types_lock){......}, at: [<c0087764>] tracing_set_tracer+0x1c/0x2ac
 #2:  (&buffer->mutex#2){......}, at: [<c0080220>] ring_buffer_resize+0xac/0x3dc
Preemption disabled at:[<  (null)>]   (null)

CPU: 0 PID: 607 Comm: bash Not tainted 3.12.15-rt25+ #124
[<c0015210>] (unwind_backtrace+0x0/0xfc) from [<c0013030>] (show_stack+0x18/0x1c)
[<c0013030>] (show_stack+0x18/0x1c) from [<c02f7010>] (rt_spin_lock+0x28/0x68)
[<c02f7010>] (rt_spin_lock+0x28/0x68) from [<c00aa468>] (free_hot_cold_page+0x84/0x3b8)
[<c00aa468>] (free_hot_cold_page+0x84/0x3b8) from [<c007cb2c>] (free_buffer_page+0x14/0x20)
[<c007cb2c>] (free_buffer_page+0x14/0x20) from [<c00800bc>] (rb_update_pages+0x280/0x338)
[<c00800bc>] (rb_update_pages+0x280/0x338) from [<c00804a0>] (ring_buffer_resize+0x32c/0x3dc)
[<c00804a0>] (ring_buffer_resize+0x32c/0x3dc) from [<c0087530>] (free_snapshot+0x18/0x38)
[<c0087530>] (free_snapshot+0x18/0x38) from [<c00879c4>] (tracing_set_tracer+0x27c/0x2ac)
[<c00879c4>] (tracing_set_tracer+0x27c/0x2ac) from [<c0087a4c>] (tracing_set_trace_write+0x58/0x114)
[<c0087a4c>] (tracing_set_trace_write+0x58/0x114) from [<c00de5f4>] (vfs_write+0xcc/0x1d0)
[<c00de5f4>] (vfs_write+0xcc/0x1d0) from [<c00de7d8>] (SyS_write+0x4c/0x78)
[<c00de7d8>] (SyS_write+0x4c/0x78) from [<c000f4a0>] (ret_fast_syscall+0x0/0x44)

Thanks
-- 
                                                 Stano
