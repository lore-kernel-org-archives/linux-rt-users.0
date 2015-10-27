From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Tue, 27 Oct 2015 07:18:01 -0700
Message-ID: <1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1445886895-3692-1-git-send-email-joshc@ni.com>
	 <20151027004422.GH5105@linux.vnet.ibm.com>
	 <20151027123153.GG8245@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35747 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbbJ0OSG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Oct 2015 10:18:06 -0400
In-Reply-To: <20151027123153.GG8245@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-10-27 at 07:31 -0500, Josh Cartwright wrote:

> Okay, yes, I like the first suggestion better as well, I've included a
> patch below that does just that.  I hope you don't mind me turning it
> into a Suggested-by :).
> 
> Thanks for taking a look!
>   Josh


> @@ -6969,7 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
>  void synchronize_net(void)
>  {
>  	might_sleep();
> -	if (rtnl_is_locked())
> +	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
>  		synchronize_rcu_expedited();
>  	else
>  		synchronize_rcu();

No objection from me. Thanks.

Acked-by: Eric Dumazet <edumazet@google.com>


