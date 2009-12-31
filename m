From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: Lockup with "BUG: using smp_processor_id() in preemptible"
Date: Thu, 31 Dec 2009 12:34:26 -0500
Message-ID: <3e8340490912310934r2a8df5f0p62044592f7e7f808@mail.gmail.com>
References: <3e8340490912310821i625daf3bu6024f6644d2789a4@mail.gmail.com>
	<8C8865ED624BB94F8FE50259E2B5C5B3045943388F@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: RT <linux-rt-users@vger.kernel.org>
To: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53487 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZLaRet convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Dec 2009 12:34:49 -0500
Received: by ewy19 with SMTP id 19so4818938ewy.21
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Dec 2009 09:34:47 -0800 (PST)
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B3045943388F@palmail03.lsi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Dec 31, 2009 at 12:16 PM, Leyendecker, Robert
<Robert.Leyendecker@lsi.com> wrote:

> Yes - from looking at trace and smp code it seems to occur during migration, however, there is a fair amount of asm woven in to this part and I have trouble following it and have no idea about root cause. With smp support I eventually hit this trap using brute force polling, epoll or async signals, regardless of application level affinity, irq priority, etc. Time to fault seems to very between a few minutes to several hours.
>
> I have encountered this exception using core duo with a network application. It does not occur on single core machines (I am also testing with SMP disabled and it also seems to resolve the issue). It seems very reproducible on my core duo, both 32 and 64 bit and using the latest stable kernel and rt patch.
>
> My app hammers the network interface with packets. I'm planning to boil it down into a couple of peer to peer test routines so that network processing latency can be accurately measured under rt patch for streaming applications. Rt patch seems to give excellent results that I cannot achieve using non-patch kernel (even with hand tuned affinity, IRQs, priorities, etc), so I'm hoping we can figure it out and fix it.
>
> For now, I plan to set everyone up with smp disabled in our test lab. Things seem stable with this setting.

Okay, good to know it's a known issue. I've captured a function_graph
trace, if it will help, of the flow leading up to the printk in
debug_smp_processor_id(): http://fushizen.net/~bd/trace.1.gz (occurs
on CPU 1 at the end of the trace; the printk is clearly visible)

The patch used to generate it is at
http://fushizen.net/~bd/smp-procid-trace-trap.patch
