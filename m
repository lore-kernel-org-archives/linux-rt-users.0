From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH RESEND v2] cyclictest: Fixed incorrect wakeup reset interface
Date: Wed, 09 Mar 2011 16:30:23 +0100
Message-ID: <4D779D0F.8020003@osadl.org>
References: <1299683339-14381-1-git-send-email-leemgs1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Geunsik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:34685 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757158Ab1CIPkV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2011 10:40:21 -0500
In-Reply-To: <1299683339-14381-1-git-send-email-leemgs1@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/09/2011 04:08 PM, Geunsik Lim wrote:
> When we try to run ftrace with cyclictest command of rt-test,
> We view the error according to base kernel version.
> We need to modify this hard coded interface.
>
> Signed-off-by: Geunsik Lim<geunsik.lim@samsung.com>
We need a space here: Geunsik Lim <geunsik.lim@samsung.com>

> ---
>   src/cyclictest/cyclictest.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
Oops, this is still old, it's only 1 insertion now. You could have 
produced a real patch, couldn't you?

> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 0847aed..abc0b4e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -487,7 +487,7 @@ static void setup_tracer(void)
>   				setkernvar(traceroptions, traceptr[i]);
>   		}
>   		setkernvar("tracing_max_latency", "0");
> -		setkernvar("latency_hist/wakeup_latency/reset", "1");
> +		setkernvar("latency_hist/wakeup/reset", "1");
>   	} else {
>   		setkernvar("trace_all_cpus", "1");
>   		setkernvar("trace_freerunning", "1");
Acked-by: Carsten Emde <C.Emde@osadl.org>
