From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/4] rt-tests: cyclictest segfault with '-a'
Date: Wed, 02 May 2012 13:37:36 -0700
Message-ID: <4FA19B10.70305@linux.intel.com>
References: <4FA09D6A.2050101@am.sony.com> <4FA09F81.3000506@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62172 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362Ab2EBUiI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 16:38:08 -0400
In-Reply-To: <4FA09F81.3000506@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 05/01/2012 07:44 PM, Frank Rowand wrote:
> This fixes a segfault on ARM when the '-a' option is used.
> 
> man sched_setaffinity says to use pthread_setaffinity_np() when using the
> POSIX threads API.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

Compile tested and tried "-a 0", but my ARM kernel/emulation is UP, so
not sure this is of much value.

Tested-by: Darren Hart <dvhart@linux.intel.com>

> ---
>  src/cyclictest/cyclictest.c |    4 	3 +	1 -	0 !
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: b/src/cyclictest/cyclictest.c
> ===================================================================
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -612,6 +612,7 @@ void *timerthread(void *param)
>  	struct thread_stat *stat = par->stats;
>  	int stopped = 0;
>  	cpu_set_t mask;
> +	pthread_t thread;
>  
>  	/* if we're running in numa mode, set our memory node */
>  	if (par->node != -1)
> @@ -620,7 +621,8 @@ void *timerthread(void *param)
>  	if (par->cpu != -1) {
>  		CPU_ZERO(&mask);
>  		CPU_SET(par->cpu, &mask);
> -		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
> +		thread = pthread_self();
> +		if(pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
>  			warn("Could not set CPU affinity to CPU #%d\n", par->cpu);
>  	}
>  
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
