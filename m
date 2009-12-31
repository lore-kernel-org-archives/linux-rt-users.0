From: Bryan Donlan <bdonlan@gmail.com>
Subject: Lockup with "BUG: using smp_processor_id() in preemptible"
Date: Thu, 31 Dec 2009 11:21:35 -0500
Message-ID: <3e8340490912310821i625daf3bu6024f6644d2789a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:56471 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZLaQV4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Dec 2009 11:21:56 -0500
Received: by ewy19 with SMTP id 19so4755640ewy.21
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Dec 2009 08:21:55 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

With 2.6.31.6-rt19, I have an application which reliably triggers a
system freeze on a dual-processor system. Prior to the lockup, there's
this spam in logs:

Dec 29 14:48:07 Ubuntu kernel: [  346.332026] BUG: using
smp_processor_id() in preemptible [00000000] code: SmartTool/4191
Dec 29 14:48:07 Ubuntu kernel: [  346.332205] caller is __schedule+0x13/0xa70
Dec 29 14:48:07 Ubuntu kernel: [  346.332210] Pid: 4191, comm:
SmartTool Not tainted 2.6.31.6-rt19-ceng1 #1
Dec 29 14:48:07 Ubuntu kernel: [  346.332214] Call Trace:
Dec 29 14:48:07 Ubuntu kernel: [  346.332224]  [<c031dd09>]
debug_smp_processor_id+0xb9/0xd0
Dec 29 14:48:07 Ubuntu kernel: [  346.332229]  [<c0568583>]
__schedule+0x13/0xa70
Dec 29 14:48:07 Ubuntu kernel: [  346.332236]  [<c014c984>] ? irq_exit+0x54/0x90
Dec 29 14:48:07 Ubuntu kernel: [  346.332243]  [<c011d486>] ?
smp_apic_timer_interrupt+0x56/0x90
Dec 29 14:48:07 Ubuntu kernel: [  346.332249]  [<c010332a>]
work_resched+0x5/0x19
Dec 29 14:48:07 Ubuntu kernel: [  346.332256] BUG: using
smp_processor_id() in preemptible [00000000] code: SmartTool/4191
Dec 29 14:48:07 Ubuntu kernel: [  346.332425] caller is __schedule+0x6a/0xa70
Dec 29 14:48:07 Ubuntu kernel: [  346.332429] Pid: 4191, comm:
SmartTool Not tainted 2.6.31.6-rt19-ceng1 #1
Dec 29 14:48:07 Ubuntu kernel: [  346.332432] Call Trace:
Dec 29 14:48:07 Ubuntu kernel: [  346.332437]  [<c031dd09>]
debug_smp_processor_id+0xb9/0xd0
Dec 29 14:48:07 Ubuntu kernel: [  346.332443]  [<c05685da>]
__schedule+0x6a/0xa70
Dec 29 14:48:07 Ubuntu kernel: [  346.332449]  [<c014c984>] ? irq_exit+0x54/0x90
Dec 29 14:48:07 Ubuntu kernel: [  346.332454]  [<c011d486>] ?
smp_apic_timer_interrupt+0x56/0x90
Dec 29 14:48:07 Ubuntu kernel: [  346.332460]  [<c010332a>]
work_resched+0x5/0x19
Dec 29 14:48:09 Ubuntu kernel: [  349.658309] __ratelimit: 2 callbacks
suppressed

These two traces repeat constantly in the logs - I suppose the crash
occurred when a migration eventually occurred in the middle of this.
The processes running are polling several usb-serial devices.

This does not occur with 2.6.29.6-rt24, or with SMP disabled
(including after disabling a CPU at runtime).

I'll try to get some ftrace results; in the meantime, any ideas?

Kernel log, lspci, lsmod, and config at http://fushizen.net/~bd/rt-oops.tar.gz

Thanks,

Bryan Donlan
