From: Remy Bohmer <linux@bohmer.net>
Subject: Re: RT Latency on Atmel Processors
Date: Thu, 24 Sep 2009 22:40:56 +0200
Message-ID: <3efb10970909241340v75375381m8f833e41ba96b733@mail.gmail.com>
References: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Azraiyl <azraiyl@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:18621 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZIXUse (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2009 16:48:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so1666651and.1
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2009 13:48:38 -0700 (PDT)
In-Reply-To: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> When I compare this results with:
>
> http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch
>
> it should be possible to get worst case latency below 150 us (for this kind of
> processor). The problem with this page is that there are no details, about the
> test environment. Was it measured with cyclictest? Was there anything running in

Well, those seem to be my measured figures, so I will try to explain
them. It is _not_ measured with cyclictest.
The worst case latency here is determined by:
1: a periodic interrupt of which the handler runs in IRQF_NODELAY domain.
2: A user space thread running as SCHED_FIFO at prio 99 that goes to
sleep and that is woken up directly by the periodic interrupt handler
with wake_up_process(). (the posix_cpu_timers thread is pushed down to
98 so only 1 thread is running at 99)
3: The user space thread toggles a GPIO line
4: With a scope the wost-case time is measured between the interrupt
generation and the moment the GPIO toggles.

With a optimal configured kernel it is even possible to reach latency
times in user-space close to about 40-50us, it is merely limited by
the time a cache flush takes due to process context switching. But in
practice the 150us is a nice figure to calculate with in a environment
like this.

The lower the priority of your realtime thread is set, and the more
softirqs/irq-threads are prioritised above it, the higher the
latencies count up. So, cyclictest will likely not reach these kind of
figures, because it is highly dependant on the OS timer framework, and
on softirqs/interrupts. IIRC those were in the 500us area...

The fun is that system load does not have much impact on the worst
case figures, it only increases the chance the worst case figures
occur.

These numbers are measured on 2.6.23-rt and 2.6.24-rt quite some time
ago. I have no figures yet on how 2.6.31-rt behaves now.
But, I have not found any real stability problems so far, except the
serial terminal problem with shared interrupts that is solved by using
irqf_nodelay for this interrupt handler.

Kind Regards,

Remy
