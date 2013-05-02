From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: timerfd read does not return - was probably fixed in 3.4.38
Date: Thu, 02 May 2013 16:02:31 -0400
Message-ID: <1367524951.7373.7.camel@gandalf.local.home>
References: <516BDE52.90200@meduna.org>
	 <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org>
	 <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org>
	 <517B8D91.4010700@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5851 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761782Ab3EBUCd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 May 2013 16:02:33 -0400
In-Reply-To: <517B8D91.4010700@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2013-04-27 at 10:34 +0200, Stanislav Meduna wrote:

> A general question: I am seeing a few recent changes in the tracing
> code. Is it generally safe to have at least latency histogram enabled
> in the production code, or is it advised not to compile these features
> in? I'd like to see the latencies the customer is getting in the real
> environment, but if the code is considered as work-in-progress,
> it is better to play it safe.

Only the wakeup latency tracer does not cause a hit to performance. I
recommend irqsoff/preemptoff to not be enabled on production systems.
Not for safety reasons, but because they cause a noticeable overhead to
the kernel when configured in but not enabled.

As for the other tracers, the function tracer is usually fine. But some
have said that they see a slight performance decrease when configured
in. I haven't seen that, but it really does depend on the hardware.

The events should not be an issue to configure in.

-- Steve


