From: Joel Fernandes <joelaf@google.com>
Subject: Re: preemptirqsoff tracer
Date: Tue, 4 Apr 2017 08:04:44 -0700
Message-ID: <CAJWu+or4zdksA4QoqgFbTGaf5n-UwHi9UcqxC5KCUghZq2YweA@mail.gmail.com>
References: <CAJWu+or98ki=e0wE=jjK7S+dNCdYVvkd_M4SF0Er3Wi4o6gUGg@mail.gmail.com>
 <20170404092734.382064ba@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33083 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbdDDPEq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 11:04:46 -0400
Received: by mail-vk0-f48.google.com with SMTP id d188so176691409vka.0
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Apr 2017 08:04:46 -0700 (PDT)
In-Reply-To: <20170404092734.382064ba@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 4, 2017 at 6:27 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 4 Apr 2017 01:27:25 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> Hi Steven,
>>
>> Just looking at code of the preemptirqsoff tracer, I wonder if it is
>> really working as expected.
>>
>> With the tracer enabled, start_critical_timing will be called only if
>> _both_ preemption and IRQs are turned off. Instead shouldn't this be
>> an OR condition (either preemption or IRQs are turned off)?
>
> What code are you looking at. From what I have:

Mainline.

>
> void start_critical_timings(void)
> {
>         if (preempt_trace() || irq_trace())
>                 start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
> }

This is called from the idle path though.

>
> There's an OR statement.

Actually in trace_preempt_off, its an AND condition but the
irq_trace() is negated so it works correctly (too many double
negatives so I missed that, sorry!).

if (preempt_trace() && !irq_trace) ...

and likewise in trace_hardirqs_on, its:

if (!preempt_trace() && irq_trace())

So its all good :-)
Regards,
Joel
