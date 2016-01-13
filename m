From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: trace/latency-hist: Consider new argument when probing the
 sched_switch tracer
Date: Wed, 13 Jan 2016 16:45:26 +0100
Message-ID: <20160113154526.GJ29964@linutronix.de>
References: <568B8B37.9070804@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50616 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcAMPp1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 10:45:27 -0500
Content-Disposition: inline
In-Reply-To: <568B8B37.9070804@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carsten Emde | 2016-01-05 10:21:59 [+0100]:

>Hi Thomas & Sebastian,
Hi Carsten,

>The sched_switch tracer has got a new argument. Fix the latency tracer
>accordingly.
>
>Thanks,
>    -Carsten.
>
>Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Thanks.
Is it somehow possible to detect this kind of bugs at compile time? Is
there an easy way to do this?
What is blocking the latency-hist tracer from entering mainline?

Sebastian
