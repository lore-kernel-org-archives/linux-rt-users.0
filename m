From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.4-rt PATCH] rt: trace: add rcuidle version macro for
 preemptirqsoff_hist and hrtimer_interrupt
Date: Tue, 8 Mar 2016 09:10:36 +0100
Message-ID: <56DE88FC.5080500@linutronix.de>
References: <1457394338-11865-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Yang Shi <yang.shi@windriver.com>, tglx@linutronix.de,
	rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49346 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151AbcCHIKj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 03:10:39 -0500
In-Reply-To: <1457394338-11865-1-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/08/2016 12:45 AM, Yang Shi wrote:
> diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
> index 6122e42..37f6eb8 100644
> --- a/include/trace/events/hist.h
> +++ b/include/trace/events/hist.h
> @@ -9,6 +9,7 @@
>  
>  #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
>  #define trace_preemptirqsoff_hist(a, b)
> +#define trace_preemptirqsoff_hist_rcuidle(a, b)
>  #else
>  TRACE_EVENT(preemptirqsoff_hist,

I have this piece already in my tree.

>  
> @@ -33,6 +34,7 @@ TRACE_EVENT(preemptirqsoff_hist,
>  
>  #ifndef CONFIG_MISSED_TIMER_OFFSETS_HIST
>  #define trace_hrtimer_interrupt(a, b, c, d)
> +#define trace_hrtimer_interrupt_rcuidle(a, b, c, d)
>  #else
>  TRACE_EVENT(hrtimer_interrupt,

I was thinking about this but then I saw no users of it. Do we have
any? (haven't seen them in v4.1 either).

Sebastian

