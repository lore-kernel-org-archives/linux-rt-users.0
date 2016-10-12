From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 12 Oct 2016 12:49:56 -0400
Message-ID: <20161012124956.3cb5f988@redhat.com>
References: <20161012111251.74d1d52e@redhat.com>
        <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        mst@redhat.com, paulmck@linux.vnet.ibm.com
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752511AbcJLQ4f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2016 12:56:35 -0400
In-Reply-To: <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 12 Oct 2016 11:21:14 -0500
Julia Cartwright <julia@ni.com> wrote:

> On Wed, Oct 12, 2016 at 11:12:51AM -0400, Luiz Capitulino wrote:
> > Hi,
> > 
> > We have the following patch applied to the RT tree:
> > 
> >   commit a9d3cc781a3306bfa332fa7cb6134b70696058d5
> >   Author: Josh Cartwright <joshc@ni.com>
> >   Date:   Tue Oct 27 07:31:53 2015 -0500
> >   
> >       net: Make synchronize_rcu_expedited() conditional on !RT_FULL
> > 
> > However, as noted by Michael, making rcu_normal=1 default in the
> > RT kernel should have the same effect (ie.  not calling
> > synchronize_sched_expedited()).
> > 
> > So, honest question, is there a reason not to:
> > 
> >  1. Drop the patch above
> >  2. Make rcu_normal=1 default?  
> 
> I think this is probably a cleaner way to fix the problems which
> motivated this patch in the first place.  In my defense, the above patch
> predates rcu_normal :).

No need to defend yourself! We debugged this very spike in one of
our kernels that don't have rcu_normal. We decided to do exactly
what you're doing before looking at upstream. Your patch helped
us confirm that we were in the right track.

> Something like this, perhaps?

Looks good, but (honest question) what does it buy us using
rcu_normal_after_boot vs rcu_normal? Is the boot process
improved someway?

As long as we're rcu_normal=1 before launching user-space,
this should be fine.

> 
>    Julia
> 
> -- 8< --
> Subject: [PATCH] rcu: enable rcu_normal_after_boot by default for RT
> 
> The forcing of an expedited grace period is an expensive and very
> RT-application unfriendly operation, as it forcibly preempts all running
> tasks on CPUs which are preventing the gp from expiring.
> 
> By default, as a policy decision, disable the expediting of grace
> periods (after boot) on configurations which enable PREEMPT_RT_FULL.
> 
> Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
>  kernel/rcu/update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index b40d346..4975917 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -63,7 +63,7 @@ MODULE_ALIAS("rcupdate");
>  #ifndef CONFIG_TINY_RCU
>  module_param(rcu_expedited, int, 0);
>  module_param(rcu_normal, int, 0);
> -static int rcu_normal_after_boot;
> +static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
>  module_param(rcu_normal_after_boot, int, 0);
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  

