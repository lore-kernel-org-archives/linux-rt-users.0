From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RT] spinlock: Add include for BUG() in spinlock_rt.h
Date: Fri, 22 Jun 2012 11:08:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206221108180.2853@ionos>
References: <1340285878.27036.138.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	leroy christophe <christophe.leroy@c-s.fr>,
	Iratxo Pichel Ortiz <ipichel@albentia.com>,
	David Garcia <dgarcia@albentia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33543 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761839Ab2FVJIx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2012 05:08:53 -0400
In-Reply-To: <1340285878.27036.138.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 Jun 2012, Steven Rostedt wrote:

> spinlock_rt.h references BUG(), but it does not include bug.h, and on
> some architectures (powerpc) this can cause a build failure.
> 
> Reported-by: Iratxo Pichel Ortiz <ipichel@albentia.com>
> Reported-by: leroy christophe <christophe.leroy@c-s.fr>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ----
> [ Thomas, can you add this patch to your queue so that I can add it to
> stable. Please, let me know when you have. Thanks! ]

Picked it up, thanks. Please take it right away w/o waiting for my
release.

Thanks,

	Thomas

 
> diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
> index 3b555b4..0618387 100644
> --- a/include/linux/spinlock_rt.h
> +++ b/include/linux/spinlock_rt.h
> @@ -5,6 +5,8 @@
>  #error Do not include directly. Use spinlock.h
>  #endif
>  
> +#include <linux/bug.h>
> +
>  extern void
>  __rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key);
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
