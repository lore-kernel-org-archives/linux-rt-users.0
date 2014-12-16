From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: [PATCH] rtmutex.c: Fix incorrect waiter check
Date: Mon, 15 Dec 2014 17:35:24 -0700
Message-ID: <548F7E4C.90805@hp.com>
References: <1417808100-21626-1-git-send-email-brad.mouring@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, Brad Mouring <brad.mouring@ni.com>
To: Brad Mouring <bmouring@ni.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:39713 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaLPAff (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Dec 2014 19:35:35 -0500
Received: from g6t1524.atlanta.hp.com (g6t1524.atlanta.hp.com [15.193.200.67])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id 2ECDF4253
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Dec 2014 00:35:35 +0000 (UTC)
In-Reply-To: <1417808100-21626-1-git-send-email-brad.mouring@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Yes, agreed.  Using the macro (), as done in the patch, is the correct
way to avoid invalid pointer dereferencing.

Tested with patch-3.14.25-rt22 patch on a 2 socket platform.

Reviewed-by: T Makphaibulchoke <tmac@hp.cojm>
Tested-by: T Makphaibulchoke <tmac@hp.cojm>


On 12/05/2014 12:35 PM, Brad Mouring wrote:
> In task_blocks_on_lock, there's a null check on pi_blocked_on
> of the task_struct. This pointer can encode the fact that the
> task that contains the pointer is waking (preventing requeuing)
> and therefore is non-null. Use the inline function to avoid
> dereferencing an invalid "pointer"
> 
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Reported-by: Ben Shelton <ben.shelton@ni.com>
> ---
>  kernel/locking/rtmutex.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 6c40660..535321e 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -335,7 +335,8 @@ int max_lock_depth = 1024;
>  
>  static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
>  {
> -	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
> +	return rt_mutex_real_waiter(p->pi_blocked_on) ?
> +		p->pi_blocked_on->lock : NULL;
>  }
>  
>  /*
> 
