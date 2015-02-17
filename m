From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v3.14-rt] netpoll: guard the access to dev->npinfo with
 rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y
Date: Tue, 17 Feb 2015 08:16:38 -0800
Message-ID: <20150217161637.GY4166@linux.vnet.ibm.com>
References: <1417608357-26552-1-git-send-email-kexin.hao@windriver.com>
 <20141203125020.GA5775@opentech.at>
 <20141203211911.GR25340@linux.vnet.ibm.com>
 <20150217142953.GS26177@linutronix.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Kevin Hao <haokexin@gmail.com>, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:51793 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbBQQQn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 11:16:43 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 17 Feb 2015 09:16:43 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0F3BB1FF002D
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 09:07:52 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1HGGwh548562238
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 09:16:58 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1HGGdAc032018
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 09:16:40 -0700
Content-Disposition: inline
In-Reply-To: <20150217142953.GS26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 17, 2015 at 03:29:53PM +0100, Sebastian Andrzej Siewior wrote:
> * Paul E. McKenney | 2014-12-03 13:19:11 [-0800]:
> 
> >> Is that not actually a bug indepedent of RT ? 
> >> without the rcu_read_lock/unlock who says that the 
> >> rcu_dereference is still valid at this point ? 
> >> I though that if bh are already disabled you still
> >> need the read_lock. disabled bh would allow to "downgrad" 
> >> the rcu_read_lock_bh to rcu_read_lock but you still need it.
> >
> >In vanilla kernels, anything that disables BH acts as rcu_read_lock_bh().
> >So yes, you can have cases where rcu_read_lock_bh() is needed only in
> >the -rt kernel.
> 
> But it won't hurt mainline using rcu_read_lock_bh() around
> rcu_dereference_bh() right?

Using rcu_read_lock_bh() around rcu_dereference_bh() is completely
legal, yes.

> I am not going to apply this because that code is gone shortly after
> v3.14 was released. The fm10k however does the same thing so atleast RCU
> knows when to scream :)

That is good, because it has been a good long time since I could
reasonably review all code in the kernel that uses RCU.  ;-)

							Thanx, Paul

> Sebastian
> 

