From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
Subject: Re: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros should
	select FRAME_POINTER
Date: Wed, 4 Feb 2009 16:26:15 +0100
Message-ID: <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	 <20090204150840.GC30027@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:13148 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664AbZBDP0S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 10:26:18 -0500
In-Reply-To: <20090204150840.GC30027@oksana.dev.rtsoft.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/2/4 Anton Vorontsov <avorontsov@ru.mvista.com>:
> Irqsoff, switch and preempt tracers use CALLER_ADDR macros, so they
> should select FRAME_POINTER. Otherwise traces are meaningless.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  kernel/trace/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e2a4ff6..48f7a37 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -86,6 +86,7 @@ config IRQSOFF_TRACER
>        select TRACE_IRQFLAGS
>        select TRACING
>        select TRACER_MAX_TRACE
> +       select FRAME_POINTER
>        help
>          This option measures the time spent in irqs-off critical
>          sections, with microsecond accuracy.
> @@ -108,6 +109,7 @@ config PREEMPT_TRACER
>        depends on DEBUG_KERNEL
>        select TRACING
>        select TRACER_MAX_TRACE
> +       select FRAME_POINTER
>        help
>          This option measures the time spent in preemption off critical
>          sections, with microsecond accuracy.
> @@ -136,6 +138,7 @@ config SCHED_TRACER
>        select TRACING
>        select CONTEXT_SWITCH_TRACER
>        select TRACER_MAX_TRACE
> +       select FRAME_POINTER
>        help
>          This tracer tracks the latency of the highest priority task
>          to be scheduled in, starting from the point it has woken up.
> --


Looks right.

BTW, how behaves builtin_return_address in case of !FRAME_POINTERS ?
I guess it would only work with the first caller builtin_return_address(0)
