From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] [tty]: Report warning when low_latency flag is wrongly
 used
Date: Wed, 24 Oct 2012 10:32:28 -0400
Message-ID: <5087FBFC.6050506@windriver.com>
References: <20121023111659.6f4427c7@bob.linux.org.uk> <1351082142-28633-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1351082142-28633-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12-10-24 08:35 AM, Ivo Sieben wrote:
> When a driver has the low_latency flag set and uses the schedule_flip()
> function to initiate copying data to the line discipline, a workqueue is
> scheduled in but never actually flushed. This is incorrect use of the
> low_latency flag (driver should not support the low_latency flag, or use
> the tty_flip_buffer_push() function instead). Make sure a warning is
> reported to catch incorrect use of the low_latency flag.
> 
> This patch goes with: cee4ad1ed90a0959fc29f9d30a2526e5e9522cfa

Ideally you shouldn't put commit IDs in the commit log when they
are not "permanent" (i.e. already part of mainline).  For example,
I have no idea what cee4ad1e contains, or what tree it lives in,
and I can't even search for it, since you've not also included
the short log.

Paul.
--

> 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
> 
> ---
>  drivers/tty/tty_buffer.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 06725f5..6cf87d7 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -365,6 +365,7 @@ void tty_schedule_flip(struct tty_struct *tty)
>  {
>  	struct tty_bufhead *buf = &tty->port->buf;
>  	unsigned long flags;
> +	WARN_ON(tty->low_latency);
>  
>  	spin_lock_irqsave(&buf->lock, flags);
>  	if (buf->tail != NULL)
> 
