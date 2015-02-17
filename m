From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3.14-rt] netpoll: guard the access to dev->npinfo with
 rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y
Date: Tue, 17 Feb 2015 15:29:53 +0100
Message-ID: <20150217142953.GS26177@linutronix.de>
References: <1417608357-26552-1-git-send-email-kexin.hao@windriver.com>
 <20141203125020.GA5775@opentech.at>
 <20141203211911.GR25340@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Kevin Hao <haokexin@gmail.com>, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43942 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933601AbbBQO37 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 09:29:59 -0500
Content-Disposition: inline
In-Reply-To: <20141203211911.GR25340@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul E. McKenney | 2014-12-03 13:19:11 [-0800]:

>> Is that not actually a bug indepedent of RT ? 
>> without the rcu_read_lock/unlock who says that the 
>> rcu_dereference is still valid at this point ? 
>> I though that if bh are already disabled you still
>> need the read_lock. disabled bh would allow to "downgrad" 
>> the rcu_read_lock_bh to rcu_read_lock but you still need it.
>
>In vanilla kernels, anything that disables BH acts as rcu_read_lock_bh().
>So yes, you can have cases where rcu_read_lock_bh() is needed only in
>the -rt kernel.

But it won't hurt mainline using rcu_read_lock_bh() around
rcu_dereference_bh() right?
I am not going to apply this because that code is gone shortly after
v3.14 was released. The fm10k however does the same thing so atleast RCU
knows when to scream :)

>
>							Thanx, Paul

Sebastian
