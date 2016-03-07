From: Yang Shi <yang.shi@windriver.com>
Subject: Re: regression in rt patches
Date: Mon, 7 Mar 2016 15:55:06 -0800
Message-ID: <56DE14DA.2090407@windriver.com>
References: <20160307182825.3647f443@md1em3qc>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: Henning Schild <henning.schild@siemens.com>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58056 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933492AbcCGXzM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 18:55:12 -0500
In-Reply-To: <20160307182825.3647f443@md1em3qc>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 3/7/2016 9:28 AM, Henning Schild wrote:
> Hey,
>
> this patch out of the current 4.4.3-rt9 series
> "trace: Use rcuidle version for preemptoff_hist trace point"
> introduces a regression where the kernel wont compile for a
> configuration without trace histograms

Thanks for finding it. Yes, it was missed by me.

Yang

>
> Ammend to following to the patch to fix it:
>
> --- a/include/trace/events/hist.h
> +++ b/include/trace/events/hist.h
> @@ -9,6 +9,7 @@
>   
>   #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
>   #define trace_preemptirqsoff_hist(a, b)
> +#define trace_preemptirqsoff_hist_rcuidle(a, b)
>   #else
>   TRACE_EVENT(preemptirqsoff_hist,
>
>
> Henning

