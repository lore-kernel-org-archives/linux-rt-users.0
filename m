From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/3] cyclictest: initialize 'stop' early
Date: Tue, 22 Mar 2016 15:55:10 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221553550.10687@riemann>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com> <1458239345-30892-4-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34502 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759462AbcCVOzN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:55:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id p65so30734518wmp.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 07:55:12 -0700 (PDT)
In-Reply-To: <1458239345-30892-4-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 17 Mar 2016, Luiz Capitulino wrote:

> For some modes like MODE_CLOCK_NANOSLEEP, the clock
> is already ticking when 'stop' is initialized. This
> shouldn't matter, as this memset() should very fast
> (I'd guess a few dozens or hundrends nanoseconds at
> most?), but I also think there's no reason to do it
> this late. So, initialize it along with everything
> else.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f5a67dc..202939f 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -829,6 +829,8 @@ static void *timerthread(void *param)
>  		tspec.it_interval = interval;
>  	}
>  
> +	memset(&stop, 0, sizeof(stop));
> +
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->prio;
>  	if (setscheduler(0, par->policy, &schedp))
> @@ -868,10 +870,10 @@ static void *timerthread(void *param)
>  	tsnorm(&next);
>  
>  	if (duration) {
> -		memset(&stop, 0, sizeof(stop)); /* grrr */
>  		stop = now;
>  		stop.tv_sec += duration;
>  	}
> +
>  	if (par->mode == MODE_CYCLIC) {
>  		if (par->timermode == TIMER_ABSTIME)
>  			tspec.it_value = next;
> -- 
> 2.1.0
> 
> --

Not sure about this one. It might be okay, but it certainly
makes the code messier. Is this just a theorectical possibility
or do you have some evidence that this is a problem?

I think I'll skip it for now unless you can show that it's a
real problem.

Thanks

John
