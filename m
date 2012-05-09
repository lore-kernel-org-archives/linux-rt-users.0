From: John Kacur <jkacur@redhat.com>
Subject: Re: cyclictest problem/bug as non-root
Date: Wed, 9 May 2012 15:19:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205091459260.3981@tycho>
References: <20120210115721.GA13313@opentech.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43801 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab2EINTp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 09:19:45 -0400
Received: by bkcji2 with SMTP id ji2so259332bkc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 May 2012 06:19:44 -0700 (PDT)
In-Reply-To: <20120210115721.GA13313@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 10 Feb 2012, Nicholas Mc Guire wrote:

> 
> HI !
> 
>  minor bug in cyclictest but potential causing confusion on cyclictest 
>  resuults when running as non-root user.
> 
> Setup:
>  if one sets the rtprio in /etc/security/limits.conf to something below
>  prio max - like:
> 
>  @hofrat          hard    rtprio          10
>  @hofrat          soft    rtprio          10
> 
>  but then starts cylictest with -p 80 cyclictest will not fuss and also
>  display priority 80 (as it uses par->prio in print_stat) but effectively 
>  runs with prio 0 as the return value of sched_setscheduler is not being
>  checked in timerthread), resulting in semingly bad scheduling jitter values.
> 
>  So maybe cyclictest should take the effective maximum schduling priority
>  of the user and not the scheduling policy maximum. Not sur if the check
>  in timerthread is actually really needed - but it should not hurt ither.
>  patch below (against current git) at "works for me" quality.
> 
> thx!
> hofrat
> 
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 731b4bd..fa89502 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -33,6 +33,7 @@
>  #include <sys/time.h>
>  #include <sys/utsname.h>
>  #include <sys/mman.h>
> +#include <sys/resource.h>
>  #include "rt_numa.h"
>  
>  #include "rt-utils.h"
> @@ -641,7 +642,10 @@ void *timerthread(void *param)
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->prio;
> -	sched_setscheduler(0, par->policy, &schedp);
> +	if(sched_setscheduler(0, par->policy, &schedp) == -1){
> +		fprintf(stderr,"sched_setscheduler prio %d failed\n",par->prio);
> +		par->prio=0; 
> +	}
>  
>  	/* Get current time */
>  	clock_gettime(par->clock, &now);
> @@ -943,6 +947,7 @@ static void process_options (int argc, char *argv[])
>  {
>  	int error = 0;
>  	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +	struct rlimit rlim;
>  
>  	for (;;) {
>  		int option_index = 0;
> @@ -1145,6 +1150,15 @@ static void process_options (int argc, char *argv[])
>  		policy = SCHED_FIFO;
>  	}
>  
> +	/* check against rlimit see /etc/security/limits.conf */
> +	getrlimit(RLIMIT_RTPRIO, &rlim);
> +	if ( priority > rlim.rlim_max){
> +		fprintf(stderr, "defaulting realtime priority to %d\n", 
> +			(int) rlim.rlim_max);
> +		priority = rlim.rlim_max;
> +	}
> +
> +
>  	if ((policy == SCHED_FIFO || policy == SCHED_RR) && priority == 0) {
>  		fprintf(stderr, "defaulting realtime priority to %d\n", 
>  			num_threads+1);
> 
> --

Hi Nicholas!

You're the fellow who told me not to worry if the power went out in that 
Prague dungeon-like restaurant, that we could just follow you out, right?

First of all, thank you for pointing out the bug in cyclictest, sorry it 
has taken me so long to reply.

The bug is real, but unfortunately there are a few problems with your 
solution.

1. If you are a privileged process you will override whatever is in 
/etc/security/limits.conf when calling sched_setscheduler, but getrlimit 
will dumbly report what is in limits.conf. So, the above patch could set 
the maximum priority at a lower value for privileged processes if 
limits.conf has some nonsense in it.

2. getrlimit can return RLIM_INFINITY meaning unlimited. But RLIM_INFINITY 
is -1, so that will be less than the requested prio so the above would set 
the prio to -1.

3. The kernel will enforce the soft limit not the hard limit, so you can't 
just set the priority to the rlim_max. For example if limits.conf has

 @hofrat          hard    rtprio          20
 @hofrat          soft    rtprio          10

you cannot set the prio to 20 without first calling setrlimit to raise the 
soft limit (rlim_cur)

There is a philosophical problem here as well. Should software fail if it
cannot do what the user requests, or should it try to do the next best 
thing. I can see both arguments, but in this case I would prefer that if a 
user requests a prio and the software cannot do it, then it should fail 
with a warning rather than simply take the next best prio. (which is easy 
to overlook)

So, I have a patch that will do the following.

1. If the user requests a prio lower than the hard limit but higher than 
the soft limit, it will adjust the prio up the hard limit, in order to try 
to do what the user requests.

2. If the user requests a prio higher than the hard limit, it will fail 
with a warning.

I'll send the patch in a separate mail.

Thanks

John
