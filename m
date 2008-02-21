From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH [RT] 11/14] optimize the !printk fastpath through the lock acquisition
Date: Thu, 21 Feb 2008 17:36:25 +0100
Message-ID: <200802211736.26719.ak@suse.de>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net> <20080221152722.4804.77478.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	gregkh@suse.de, sdietrich@novell.com, pmorreale@novell.com,
	mkohari@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:50951 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156AbYBUQl7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 11:41:59 -0500
In-Reply-To: <20080221152722.4804.77478.stgit@novell1.haskins.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 21 February 2008 16:27:22 Gregory Haskins wrote:

> @@ -660,12 +660,12 @@ rt_spin_lock_fastlock(struct rt_mutex *lock,
>  		void fastcall (*slowfn)(struct rt_mutex *lock))
>  {
>  	/* Temporary HACK! */
> -	if (!current->in_printk)
> -		might_sleep();
> -	else if (in_atomic() || irqs_disabled())
> +	if (unlikely(current->in_printk) && (in_atomic() || irqs_disabled()))

I have my doubts that gcc will honor unlikelies that don't affect
the complete condition of an if.

Also conditions guarding returns are by default predicted unlikely
anyways AFAIK. 

The patch is likely a nop.

-Andi
