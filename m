From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rtmutex.c: Fix incorrect waiter check
Date: Wed, 21 Jan 2015 15:13:52 -0500
Message-ID: <20150121151352.7e4ef150@gandalf.local.home>
References: <548F7E4C.90805@hp.com>
	<1421269898-30591-1-git-send-email-brad.mouring@ni.com>
	<1421269898-30591-2-git-send-email-brad.mouring@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, T Makphaibulchoke <tmac@hp.com>,
	Brad Mouring <brad.mouring@ni.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Brad Mouring" <bmouring@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:34027 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750768AbbAUUNz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Jan 2015 15:13:55 -0500
In-Reply-To: <1421269898-30591-2-git-send-email-brad.mouring@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 14 Jan 2015 15:11:38 -0600
"Brad Mouring" <bmouring@ni.com> wrote:

> In task_blocks_on_lock, there's a null check on pi_blocked_on
> of the task_struct. This pointer can encode the fact that the
> task that contains the pointer is waking (preventing requeuing)
> and therefore is non-null. Use the inline function to avoid
> dereferencing an invalid "pointer"

Yep, this looks legit. I can apply it to the series I maintain.

-- Steve

> 
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Reported-by: Ben Shelton <ben.shelton@ni.com>
> Reviewed-by: T Makphaibulchoke <tmac@hp.com>
> Tested-by: T Makphaibulchoke <tmac@hp.com>
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

