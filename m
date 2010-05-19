From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Microblaze RT
Date: Wed, 19 May 2010 09:08:29 -0400
Message-ID: <1274274509.26328.764.camel@gandalf.stny.rr.com>
References: <4BF3DFCA.7010604@petalogix.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: michal.simek@petalogix.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:62284 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab0ESNIc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 May 2010 09:08:32 -0400
In-Reply-To: <4BF3DFCA.7010604@petalogix.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-05-19 at 14:55 +0200, Michal Simek wrote:
> ==> /debugfs/tracing/latency_hist/preemptirqsoff/CPU0 <==
> #Minimum latency: 12 microseconds
> #Average latency: 1991 microseconds
> #Maximum latency: 4294954 microseconds
> #Total samples: 76773
> #There are 0 samples lower than 0 microseconds.
> #There are 35 samples greater or equal than 10240 microseconds.
> #usecs           samples
>       0                 0
>       1                 0
>       2                 0 

Note, do you disable the irqsoff tracer on idle? 

In x86 we have in process_*.c we have:

			stop_critical_timings();
			pm_idle();
			start_critical_timings();

This causes the irqsoff() tracer to not care about the time we are in
idle. The interrupts are disabled when calling pm_idle() and enabled in
assembly, so we miss it. But really, we don't care here because, if
interrupts were disabled and not react, then the CPU would be dead ;-)

This is just one theory, those numbers could be because of something
else. But this is the most common case when the preemptoff and irqsoff
tracers are ported to another arch.

-- Steve


