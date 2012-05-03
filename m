From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (3/3)
Date: Thu, 3 May 2012 09:24:32 -0700
Message-ID: <20120503162432.GA3063@kroah.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
 <1336048663-21882-3-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55751 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab2ECQYg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 12:24:36 -0400
Received: by pbbrp8 with SMTP id rp8so2681796pbb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 03 May 2012 09:24:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336048663-21882-3-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 03, 2012 at 02:37:43PM +0200, Ivo Sieben wrote:
> Solved unnecessary schedule latency in the TTY layer when used in
> realtime context:
> The global wait_queue that is used for line discipline idle handling is
> moved to a separate wait_queue for each line instance. This prevents
> unnecessary blocking on one line, because of idle handling on another
> line.

This patch makes sense even in a non-RT case, as it localizes the lock
to the specific ldisc.

Alan, any objection to me applying this one to the tree now?

thanks,

greg k-h

> Note: In a PREEMPT_RT system "normal" spin locks behave like mutexes and
> no interrupts (and therefor no scheduling) is disabled.
> 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
> ---
>  drivers/tty/tty_ldisc.c   |    7 ++++---
>  include/linux/tty_ldisc.h |    2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 30836cc..77eb299 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -28,7 +28,6 @@
>  
>  static DEFINE_RAW_SPINLOCK(tty_ldisc_lock);
>  static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
> -static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_idle);
>  /* Line disc dispatch table */
>  static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
>  
> @@ -65,7 +64,7 @@ static void put_ldisc(struct tty_ldisc *ld)
>  		return;
>  	}
>  	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
> -	wake_up(&tty_ldisc_idle);
> +	wake_up(&ld->wq_idle);
>  }
>  
>  /**
> @@ -200,6 +199,8 @@ static struct tty_ldisc *tty_ldisc_get(int disc)
>  
>  	ld->ops = ldops;
>  	atomic_set(&ld->users, 1);
> +	init_waitqueue_head(&ld->wq_idle);
> +
>  	return ld;
>  }
>  
> @@ -538,7 +539,7 @@ static void tty_ldisc_flush_works(struct tty_struct *tty)
>  static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
>  {
>  	long ret;
> -	ret = wait_event_timeout(tty_ldisc_idle,
> +	ret = wait_event_timeout(tty->ldisc->wq_idle,
>  			atomic_read(&tty->ldisc->users) == 1, timeout);
>  	return ret > 0 ? 0 : -EBUSY;
>  }
> diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
> index ff7dc08..fb79dd8 100644
> --- a/include/linux/tty_ldisc.h
> +++ b/include/linux/tty_ldisc.h
> @@ -110,6 +110,7 @@
>  #include <linux/fs.h>
>  #include <linux/wait.h>
>  #include <linux/pps_kernel.h>
> +#include <linux/wait.h>
>  
>  struct tty_ldisc_ops {
>  	int	magic;
> @@ -154,6 +155,7 @@ struct tty_ldisc_ops {
>  struct tty_ldisc {
>  	struct tty_ldisc_ops *ops;
>  	atomic_t users;
> +	wait_queue_head_t wq_idle;
>  };
>  
>  #define TTY_LDISC_MAGIC	0x5403
> -- 
> 1.7.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
