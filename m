From: Philipp Schrader <philipp@peloton-tech.com>
Subject: RCU splat on boot from an idle CPU
Date: Mon, 31 Aug 2015 17:46:40 -0700
Message-ID: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34147 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbIAAqm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 20:46:42 -0400
Received: by lbbtg9 with SMTP id tg9so70017780lbb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2015 17:46:40 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I've got a real-time kernel on a DRA7 evaluation module (EVM).
Very early in the boot process I get the following splat.

[    0.055073]
[    0.055076] ===============================
[    0.055079] [ INFO: suspicious RCU usage. ]
[    0.055084] 4.1.6+ #2 Not tainted
[    0.055086] -------------------------------
[    0.055090] include/trace/events/hist.h:31 suspicious
rcu_dereference_check() usage!
[    0.055093]
[    0.055093] other info that might help us debug this:
[    0.055093]
[    0.055097]
[    0.055097] RCU used illegally from idle CPU!
[    0.055097] rcu_scheduler_active = 1, debug_locks = 1
[    0.055100] RCU used illegally from extended quiescent state!
[    0.055104] no locks held by swapper/0/0.
[    0.055106]
[    0.055106] stack backtrace:
[    0.055112] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.6+ #2
[    0.055116] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.055130] [<c00196b8>] (unwind_backtrace) from [<c001515c>]
(show_stack+0x20/0x24)
[    0.055146] [<c001515c>] (show_stack) from [<c07bc408>]
(dump_stack+0x84/0xa0)
[    0.055160] [<c07bc408>] (dump_stack) from [<c009bc38>]
(lockdep_rcu_suspicious+0xb0/0x110)
[    0.055172] [<c009bc38>] (lockdep_rcu_suspicious) from [<c01246c4>]
(time_hardirqs_off+0x2b8/0x3c8)
[    0.055184] [<c01246c4>] (time_hardirqs_off) from [<c009a218>]
(trace_hardirqs_off_caller+0x2c/0xf4)
[    0.055194] [<c009a218>] (trace_hardirqs_off_caller) from
[<c009a2f4>] (trace_hardirqs_off+0x14/0x18)
[    0.055204] [<c009a2f4>] (trace_hardirqs_off) from [<c00c7ecc>]
(rcu_idle_enter+0x78/0xcc)
[    0.055213] [<c00c7ecc>] (rcu_idle_enter) from [<c0093eb0>]
(cpu_startup_entry+0x190/0x518)
[    0.055222] [<c0093eb0>] (cpu_startup_entry) from [<c07b95b4>]
(rest_init+0x13c/0x17c)
[    0.055231] [<c07b95b4>] (rest_init) from [<c0b32c74>]
(start_kernel+0x320/0x380)
[    0.055238] [<c0b32c74>] (start_kernel) from [<8000807c>] (0x8000807c)

I'm not sure how to debug this; I'm still reading up on RCUs. Pretty
nifty ideas.

Looking at include/trace/events/hist.h it appears line 31 is the end
of a TRACE_EVENT macro usage.
Does that mean the macro is using RCU improperly somehow?

Thanks,
Philipp
