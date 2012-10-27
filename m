From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: loading pages to memory causes high latency
Date: Sat, 27 Oct 2012 10:38:17 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210271029370.2756@ionos>
References: <508ACFCF.8040001@meduna.org> <alpine.LFD.2.02.1210262254560.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37022 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2J0IiT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2012 04:38:19 -0400
In-Reply-To: <alpine.LFD.2.02.1210262254560.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 26 Oct 2012, Thomas Gleixner wrote:
> On Fri, 26 Oct 2012, Stanislav Meduna wrote:
> > The command
> >   echo 1000000 > /proc/sys/kernel/sched_rt_runtime_us
> > fixes the problem but is not really something I want
> > to enable when developing a real-time capable system
> > that will be running in remote locations. With 980000
> > I still get negligible latencies. With 970000 I get 4 ms.
> > With 960000 I get 15 ms latencies. So it is indeed
> > the throttling that is firing here.
> 
> Right. So that means that the pata irq or something else loops in
> circles for whatever reasons.
> 
> For a simple test, can you just set the pata irq thread to SCHED_OTHER
> with chrt? Does that cure the problem?
> 
> Aside of that I'd really like to see a full function trace of that
> scenario. Can you please apply the patch below and run that with the
> function tracer enabled. The throttling will stop the trace right at
> the point.

Ok. The trace shows what happens. The pata driver runs all of its work
in the interrupt handler context and the hardware is fast enough to
saturate the machine. I.e. right after the handler returns and
reenables interrupts the next pata irq fires. Lather rinse and repeat.

On mainline you'd just see the machine stalling for a bit as it would
process interrupts and nothing else. Of course you wont see rt
throttling because all of this happens in hard interrupt context,
except if you force interrupt threading via "threadirqs" on the kernel
command line.

There is not much we can do about that unless we want to do a major
surgery on that pata driver code.

So either you disable the throttler or you reconfigure the pata irq
thread to SCHED_OTHER, which will slow it down a bit, but avoids the
hogging of the machine with a RT task going wild.

Thanks,

	tglx
