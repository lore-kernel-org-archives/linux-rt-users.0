From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preemptirqsoff tracer
Date: Tue, 4 Apr 2017 09:27:34 -0400
Message-ID: <20170404092734.382064ba@gandalf.local.home>
References: <CAJWu+or98ki=e0wE=jjK7S+dNCdYVvkd_M4SF0Er3Wi4o6gUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752461AbdDDN1j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 09:27:39 -0400
In-Reply-To: <CAJWu+or98ki=e0wE=jjK7S+dNCdYVvkd_M4SF0Er3Wi4o6gUGg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 4 Apr 2017 01:27:25 -0700
Joel Fernandes <joelaf@google.com> wrote:

> Hi Steven,
> 
> Just looking at code of the preemptirqsoff tracer, I wonder if it is
> really working as expected.
> 
> With the tracer enabled, start_critical_timing will be called only if
> _both_ preemption and IRQs are turned off. Instead shouldn't this be
> an OR condition (either preemption or IRQs are turned off)?

What code are you looking at. From what I have:

void start_critical_timings(void)
{
	if (preempt_trace() || irq_trace())
		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
}

There's an OR statement.

-- Steve

> 
> >From the example in ftrace.txt documentation:  
>     local_irq_disable();
>     call_function_with_irqs_off();
>     preempt_disable();
>     call_function_with_irqs_and_preemption_off();
>     local_irq_enable();
>     call_function_with_preemption_off();
>     preempt_enable();
> 
> Looks to me like the preemptirqsoff tracer will starting tracing from
> preempt_disable and end at the preempt_enable. Instead, shouldn't we
> be tracing starting from the local_irq_disable and end at the
> preempt_enable?
> 
> Regards,
> Joel

