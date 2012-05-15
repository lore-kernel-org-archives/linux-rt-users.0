From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG - "scheduling while atomic" on a irq handler (s3c-mci)
Date: Tue, 15 May 2012 13:38:48 -0400
Message-ID: <1337103528.14207.342.camel@gandalf.stny.rr.com>
References: <CAEOomG9NEoQKqp=pMx0NpzGaFpHBimALwhemnZL4F-8g7XURkA@mail.gmail.com>
	 <20120509174931.GB31844@pengutronix.de>
	 <CAEOomG9FZD9TEQZZKhCrNrq8SNXi3otWB2mDX69i3tWh5YQenw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org
To: Christophe Huriaux <c.huriaux@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:13980 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966103Ab2EORit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 13:38:49 -0400
In-Reply-To: <CAEOomG9FZD9TEQZZKhCrNrq8SNXi3otWB2mDX69i3tWh5YQenw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-05-10 at 15:17 +0200, Christophe Huriaux wrote:

> 
> From: Christophe Huriaux <c.huriaux@gmail.com>
> Subject: [PATCH] Fix scheduling while atomic bug in pio_tasklet
> Signed-off-by: Christophe Huriaux <c.huriaux@gmail.com>
> ---
>  drivers/mmc/host/s3cmci.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 720f993..9978ad6 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -329,7 +329,11 @@ static void s3cmci_enable_irq(struct s3cmci_host
> *host, bool more)
>                 if (enable)
>                         enable_irq(host->irq);
>                 else
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +                       disable_irq_nosync(host->irq);
> +#else
>                         disable_irq(host->irq);
> +#endif
>         }
> 
>         local_irq_restore(flags);
> @@ -350,7 +354,11 @@ static void s3cmci_disable_irq(struct s3cmci_host
> *host, bool transfer)
> 
>         if (transfer && host->irq_state) {
>                 host->irq_state = false;
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +               disable_irq_nosync(host->irq);
> +#else
>                 disable_irq(host->irq);
> +#endif
>         }
> 
>         local_irq_restore(flags);

What happens if you instead convert the local_irq_save/restore() to
local_irq_save_nort/restore_nort()?

Does that work too?

-- Steve


