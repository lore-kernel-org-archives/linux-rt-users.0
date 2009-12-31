From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: RE: Lockup with "BUG: using smp_processor_id() in preemptible"
Date: Thu, 31 Dec 2009 12:16:18 -0500
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B3045943388F@palmail03.lsi.com>
References: <3e8340490912310821i625daf3bu6024f6644d2789a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Bryan Donlan <bdonlan@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55777 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752675AbZLaRQY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Dec 2009 12:16:24 -0500
In-Reply-To: <3e8340490912310821i625daf3bu6024f6644d2789a4@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Bryan Donlan
> Sent: Thursday, December 31, 2009 10:22 AM
> To: RT
> Subject: Lockup with "BUG: using smp_processor_id() in preemptible"
> 
> Hi,
> 
> With 2.6.31.6-rt19, I have an application which reliably triggers a
> system freeze on a dual-processor system. Prior to the lockup, there's
> this spam in logs:
> 
> Dec 29 14:48:07 Ubuntu kernel: [  346.332026] BUG: using
> smp_processor_id() in preemptible [00000000] code: SmartTool/4191
> Dec 29 14:48:07 Ubuntu kernel: [  346.332205] caller is
> __schedule+0x13/0xa70
> Dec 29 14:48:07 Ubuntu kernel: [  346.332210] Pid: 4191, comm:
> SmartTool Not tainted 2.6.31.6-rt19-ceng1 #1
> Dec 29 14:48:07 Ubuntu kernel: [  346.332214] Call Trace:
> Dec 29 14:48:07 Ubuntu kernel: [  346.332224]  [<c031dd09>]
> debug_smp_processor_id+0xb9/0xd0
> Dec 29 14:48:07 Ubuntu kernel: [  346.332229]  [<c0568583>]
> __schedule+0x13/0xa70
> Dec 29 14:48:07 Ubuntu kernel: [  346.332236]  [<c014c984>] ?
> irq_exit+0x54/0x90
> Dec 29 14:48:07 Ubuntu kernel: [  346.332243]  [<c011d486>] ?
> smp_apic_timer_interrupt+0x56/0x90
> Dec 29 14:48:07 Ubuntu kernel: [  346.332249]  [<c010332a>]
> work_resched+0x5/0x19
> Dec 29 14:48:07 Ubuntu kernel: [  346.332256] BUG: using
> smp_processor_id() in preemptible [00000000] code: SmartTool/4191
> Dec 29 14:48:07 Ubuntu kernel: [  346.332425] caller is
> __schedule+0x6a/0xa70
> Dec 29 14:48:07 Ubuntu kernel: [  346.332429] Pid: 4191, comm:
> SmartTool Not tainted 2.6.31.6-rt19-ceng1 #1
> Dec 29 14:48:07 Ubuntu kernel: [  346.332432] Call Trace:
> Dec 29 14:48:07 Ubuntu kernel: [  346.332437]  [<c031dd09>]
> debug_smp_processor_id+0xb9/0xd0
> Dec 29 14:48:07 Ubuntu kernel: [  346.332443]  [<c05685da>]
> __schedule+0x6a/0xa70
> Dec 29 14:48:07 Ubuntu kernel: [  346.332449]  [<c014c984>] ?
> irq_exit+0x54/0x90
> Dec 29 14:48:07 Ubuntu kernel: [  346.332454]  [<c011d486>] ?
> smp_apic_timer_interrupt+0x56/0x90
> Dec 29 14:48:07 Ubuntu kernel: [  346.332460]  [<c010332a>]
> work_resched+0x5/0x19
> Dec 29 14:48:09 Ubuntu kernel: [  349.658309] __ratelimit: 2 callbacks
> suppressed
> 
> These two traces repeat constantly in the logs - I suppose the crash
> occurred when a migration eventually occurred in the middle of this.
> The processes running are polling several usb-serial devices.
> 
> This does not occur with 2.6.29.6-rt24, or with SMP disabled
> (including after disabling a CPU at runtime).
> 
> I'll try to get some ftrace results; in the meantime, any ideas?
> 
> Kernel log, lspci, lsmod, and config at http://fushizen.net/~bd/rt-
> oops.tar.gz
> 
> Thanks,
> 
> Bryan Donlan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-
> users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Yes - from looking at trace and smp code it seems to occur during migration, however, there is a fair amount of asm woven in to this part and I have trouble following it and have no idea about root cause. With smp support I eventually hit this trap using brute force polling, epoll or async signals, regardless of application level affinity, irq priority, etc. Time to fault seems to very between a few minutes to several hours.

I have encountered this exception using core duo with a network application. It does not occur on single core machines (I am also testing with SMP disabled and it also seems to resolve the issue). It seems very reproducible on my core duo, both 32 and 64 bit and using the latest stable kernel and rt patch.

My app hammers the network interface with packets. I'm planning to boil it down into a couple of peer to peer test routines so that network processing latency can be accurately measured under rt patch for streaming applications. Rt patch seems to give excellent results that I cannot achieve using non-patch kernel (even with hand tuned affinity, IRQs, priorities, etc), so I'm hoping we can figure it out and fix it. 

For now, I plan to set everyone up with smp disabled in our test lab. Things seem stable with this setting.

Here are a few additional refs...

http://thread.gmane.org/gmane.linux.rt.user/5343/focus=5346

http://lkml.org/lkml/2009/11/26/302

http://lkml.org/lkml/2009/11/23/548

http://lkml.org/lkml/2009/11/26/318


-Bob

