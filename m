From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 1/3] cyclictest: Ensure that next wakeup time is never
 in the past
Date: Tue, 2 Jun 2015 15:06:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1506021506280.13306@riemann>
References: <20150526190333.510838769@glx-um.de> <20150526190443.567997063@glx-um.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: anna-maria@glx-um.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34922 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbbFBNGw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 09:06:52 -0400
Received: by wikd7 with SMTP id d7so12915663wik.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jun 2015 06:06:51 -0700 (PDT)
In-Reply-To: <20150526190443.567997063@glx-um.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 26 May 2015, anna-maria@glx-um.de wrote:

> The calculated next wakeup time is already in the past, if the latency
> is longer than the interval. Thereby latency is detected that does not
> correspond to latency caused by the system but by cyclictest itself.
> 
> Force forward the next wakeup time past now.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
> ---
>  src/cyclictest/cyclictest.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: rt-tests/src/cyclictest/cyclictest.c
> ===================================================================
> --- rt-tests.orig/src/cyclictest/cyclictest.c
> +++ rt-tests/src/cyclictest/cyclictest.c
> @@ -369,6 +369,12 @@ static inline void tsnorm(struct timespe
>  	}
>  }
>  
> +static inline int tsgreater(struct timespec *a, struct timespec *b)
> +{
> +	return ((a->tv_sec > b->tv_sec) ||
> +		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
> +}
> +
>  static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
>  {
>  	int64_t diff;
> @@ -949,6 +955,12 @@ void *timerthread(void *param)
>  		}
>  		tsnorm(&next);
>  
> +		while (tsgreater(&now, &next)) {
> +			next.tv_sec += interval.tv_sec;
> +			next.tv_nsec += interval.tv_nsec;
> +			tsnorm(&next);
> +		}
> +
>  		if (par->max_cycles && par->max_cycles == stat->cycles)
>  			break;
>  	}
> 
> 
> --

Applied, this one will be in the next build
Thanks!

John Kacur
