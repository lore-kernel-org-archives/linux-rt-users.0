Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:38316 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbeJEVWX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Oct 2018 17:22:23 -0400
Date: Fri, 5 Oct 2018 16:23:25 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: __migrate_disabled symbol not exported for rt kernel > 4.9
Message-ID: <20181005142325.bltjehfbffvnhkam@linutronix.de>
References: <20180918205514.GB31793@joraj-alpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180918205514.GB31793@joraj-alpa>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: linux-rt-users@vger.kernel.org, skrishnakar@gmail.com

On 2018-09-18 16:55:14 [-0400], Jonathan Rajotte-Julien wrote:
> Hi,
Hi,

> While building/linking our out-of-tree modules, lttng-modules, against
> 4.14.69-rt43 we encounter this error:
> 
>     WARNING: "__migrate_disabled" [/home/builder/lttng-modules/lttng-modules-2.10.7/lttng-tracer.ko] undefined!
> 
> Same problem for other stable rt kernels > 4.9.
> Everything work fine against 4.9.115-rt93.
> 
> It looks like __migrate_disabled was moved from linux/include/sched.h to
> linux/include/preempt.h. No problem there but for a configuration the
> inline function was transformed into a function declaration. The symbol for
> that function is not currently exported (EXPORT_SYMBOL*).
> 
> Should __migrate_disabled be exported when defined in kernel/sched/core.c?

If you need it, I guess so. In order to inline it again, it should be
moved back to sched.h…

> And for personal knowledge:
> 
> What is the reason for not using an inline function for the (CONFIG_SMP)
> && (CONFIG_PREEMPT_RT_BASE) configuration?

we should not include sched.h (for struct task_struct) into preempt.h

> The commit message introducing __migrate_disabled does not give much information
> regarding why it is done differently compared to 4.9-rt kernels.
> 
> We will probably end up accessing the migrate_disabled field directly since we
> need to support those kernel versions somehow.

Do you want a EXPORT_SYMBOL_GPL for that or are you good?

> Cheers

Sebastian
