Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.efficios.com ([167.114.142.138]:51152 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbeISC3i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Sep 2018 22:29:38 -0400
Date: Tue, 18 Sep 2018 16:55:14 -0400
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: __migrate_disabled symbol not exported for rt kernel > 4.9
Message-ID: <20180918205514.GB31793@joraj-alpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: bigeasy@linutronix.de
Cc: linux-rt-users@vger.kernel.org, skrishnakar@gmail.com

Hi,

While building/linking our out-of-tree modules, lttng-modules, against
4.14.69-rt43 we encounter this error:

    WARNING: "__migrate_disabled" [/home/builder/lttng-modules/lttng-modules-2.10.7/lttng-tracer.ko] undefined!

Same problem for other stable rt kernels > 4.9.
Everything work fine against 4.9.115-rt93.

It looks like __migrate_disabled was moved from linux/include/sched.h to
linux/include/preempt.h. No problem there but for a configuration the
inline function was transformed into a function declaration. The symbol for
that function is not currently exported (EXPORT_SYMBOL*).

Should __migrate_disabled be exported when defined in kernel/sched/core.c?

And for personal knowledge:

What is the reason for not using an inline function for the (CONFIG_SMP)
&& (CONFIG_PREEMPT_RT_BASE) configuration?

The commit message introducing __migrate_disabled does not give much information
regarding why it is done differently compared to 4.9-rt kernels.

We will probably end up accessing the migrate_disabled field directly since we
need to support those kernel versions somehow.

Cheers
-- 
Jonathan Rajotte-Julien
EfficiOS
