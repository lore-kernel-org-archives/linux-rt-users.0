From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v3.14-rt] netpoll: guard the access to dev->npinfo with
 rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y
Date: Wed, 3 Dec 2014 13:19:11 -0800
Message-ID: <20141203211911.GR25340@linux.vnet.ibm.com>
References: <1417608357-26552-1-git-send-email-kexin.hao@windriver.com>
 <20141203125020.GA5775@opentech.at>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Hao <haokexin@gmail.com>, linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:37088 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaLCVTR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Dec 2014 16:19:17 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 3 Dec 2014 14:19:17 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 97A811FF0040
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Dec 2014 14:07:58 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB3LJuWC49479900
	for <linux-rt-users@vger.kernel.org>; Wed, 3 Dec 2014 14:19:56 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB3LJDBF032036
	for <linux-rt-users@vger.kernel.org>; Wed, 3 Dec 2014 14:19:14 -0700
Content-Disposition: inline
In-Reply-To: <20141203125020.GA5775@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Dec 03, 2014 at 01:50:20PM +0100, Nicholas Mc Guire wrote:
> On Wed, 03 Dec 2014, Kevin Hao wrote:
> 
> > For vanilla kernel we don't need to invoke rcu_read_lock/unlock_bh
> > explicitly to mark an RCU-bh critical section in the softirq context
> > because bh is already disabled in this case. But for a rt kernel,
> > the commit ("rcu: Merge RCU-bh into RCU-preempt") implements the
> > RCU-bh in term of RCU-preempt. So we have to use
> > rcu_read_lock/unlock_bh() to mark an RCU-bh critical section even in
> > +
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +	rcu_read_lock_bh();
> > +#endif
> > +
> > +	npinfo = rcu_dereference_bh(skb->dev->npinfo);
> > +	ret = npinfo && (!list_empty(&npinfo->rx_np) || npinfo->rx_flags);
> > +
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +	rcu_read_unlock_bh();
> > +#endif
> 
> Is that not actually a bug indepedent of RT ? 
> without the rcu_read_lock/unlock who says that the 
> rcu_dereference is still valid at this point ? 
> I though that if bh are already disabled you still
> need the read_lock. disabled bh would allow to "downgrad" 
> the rcu_read_lock_bh to rcu_read_lock but you still need it.

In vanilla kernels, anything that disables BH acts as rcu_read_lock_bh().
So yes, you can have cases where rcu_read_lock_bh() is needed only in
the -rt kernel.

							Thanx, Paul

