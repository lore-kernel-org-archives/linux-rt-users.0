From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] rcutorture: fix missing function at build time
Date: Mon, 2 Mar 2015 13:18:15 -0800
Message-ID: <20150302211815.GY15405@linux.vnet.ibm.com>
References: <20150302201530.GA4189@uudg.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52775 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbbCBVST (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2015 16:18:19 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 2 Mar 2015 14:18:19 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0517A1FF0027
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Mar 2015 14:09:29 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t22LIHO419595470
	for <linux-rt-users@vger.kernel.org>; Mon, 2 Mar 2015 14:18:17 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t22LIGqH011635
	for <linux-rt-users@vger.kernel.org>; Mon, 2 Mar 2015 14:18:17 -0700
Content-Disposition: inline
In-Reply-To: <20150302201530.GA4189@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 02, 2015 at 05:15:31PM -0300, Luis Claudio R. Goncalves wrote:
> Hello,
> 
> This is a minor issue, but as I seem to have woken up Paul at 4AM with the
> many beeps from IRC I would feel bad if I did not send this patch to the
> list. Actually, as that patch has been sitting on my computer for a few
> days now, i already feel bad :)

Actually, you did not wake me up -- I had accidentally left my system
logged into IRC overnight and saw your post when I woke up some time
later.  ;-)

> rcutorture: fix missing function at build time
> 
> Trying to build the rcutorture module on 3.18.7-rt2 ends up on:
> 
>    ERROR: "rcu_force_quiescent_state" [kernel/rcu/rcutorture.ko] undefined!
> 
> Commit "71d22b5 Subject: rcu: Merge RCU-bh into RCU-preempt" encloses three
> functions (rcu_batches_completed_bh, rcu_force_quiescent_state and
> rcu_bh_force_quiescent_state) on an #ifndef CONFIG_PREEMPT_RT_FULL / #endif
> pair, rendering them non-existent on RT. As the commit points out, that was
> a wise and necessary move.
> 
> But in order to get rcutorture build working again we need to define an
> empty rcu_force_quiescent_state function.
> 
> Signed-off-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a4e9e25..28a54f6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -378,6 +378,11 @@ void rcu_bh_force_quiescent_state(void)
>  	force_quiescent_state(&rcu_bh_state);
>  }
>  EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
> +#else
> +void rcu_force_quiescent_state(void)
> +{
> +}
> +EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);

This is -rt only, correct?

							Thanx, Paul

>  #endif
> 
>  /*
> 
> -- 
> [ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
> [ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
> 

