From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 12 Oct 2016 09:39:30 -0700
Message-ID: <20161012163930.GH29518@linux.vnet.ibm.com>
References: <20161012111251.74d1d52e@redhat.com>
 <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        mst@redhat.com
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754926AbcJLQji (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2016 12:39:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9CGcPCY145428
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2016 12:39:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2615bvj31f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2016 12:39:37 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Oct 2016 10:39:36 -0600
Content-Disposition: inline
In-Reply-To: <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 12, 2016 at 11:21:14AM -0500, Julia Cartwright wrote:
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
> 
> Something like this, perhaps?
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

Looks like a reasonable approach to me.  Objections?

							Thanx, Paul

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
> -- 
> 2.9.3
> 

