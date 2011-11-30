From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 15:16:18 +0100
Message-ID: <1322662578.2921.275.camel@twins>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	 <1322620613.17003.110.camel@frodo>
	 <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	 <1322651681.2921.247.camel@twins> <1322662465.17003.117.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: John Kacur <jkacur@redhat.com>, Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59426 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab1K3OQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 09:16:37 -0500
In-Reply-To: <1322662465.17003.117.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> I took Peter's patch and ported it to 3.0-rt. Hopefully, I didn't screw
> it up.
> 
> -- Steve
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 096bf0a..966a8c4 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -764,6 +764,7 @@ static enum {
>  	PARTIAL_AC,
>  	PARTIAL_L3,
>  	EARLY,
> +	LATE,
>  	FULL
>  } g_cpucache_up;
>  
> @@ -795,7 +796,7 @@ static void init_node_lock_keys(int q)
>  {
>  	struct cache_sizes *s = malloc_sizes;
>  
> -	if (g_cpucache_up != FULL)
> +	if (g_cpucache_up < LATE)
>  		return;
>  
>  	for (s = malloc_sizes; s->cs_size != ULONG_MAX; s++) {
> @@ -1752,7 +1753,7 @@ void __init kmem_cache_init_late(void)
>  	mutex_unlock(&cache_chain_mutex);
>  
>  	/* Done! */
> -	g_cpucache_up = FULL;
> +	g_cpucache_up = LATE;
>  
>  	/* Annotate slab for lockdep -- annotate the malloc caches */
>  	init_lock_keys();
> 
> 

You did screw it up.. now g_cpucache_up will never be FULL. It works
much better if you also apply 30765b92 to this tree.
