From: Joel Fernandes <joelaf@google.com>
Subject: preemptirqsoff tracer
Date: Tue, 4 Apr 2017 01:27:25 -0700
Message-ID: <CAJWu+or98ki=e0wE=jjK7S+dNCdYVvkd_M4SF0Er3Wi4o6gUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35914 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbdDDI10 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 04:27:26 -0400
Received: by mail-vk0-f46.google.com with SMTP id s68so166633612vke.3
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Apr 2017 01:27:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

Just looking at code of the preemptirqsoff tracer, I wonder if it is
really working as expected.

With the tracer enabled, start_critical_timing will be called only if
_both_ preemption and IRQs are turned off. Instead shouldn't this be
an OR condition (either preemption or IRQs are turned off)?

>From the example in ftrace.txt documentation:
    local_irq_disable();
    call_function_with_irqs_off();
    preempt_disable();
    call_function_with_irqs_and_preemption_off();
    local_irq_enable();
    call_function_with_preemption_off();
    preempt_enable();

Looks to me like the preemptirqsoff tracer will starting tracing from
preempt_disable and end at the preempt_enable. Instead, shouldn't we
be tracing starting from the local_irq_disable and end at the
preempt_enable?

Regards,
Joel
