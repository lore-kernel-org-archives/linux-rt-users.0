From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Mon, 7 May 2018 14:51:46 +0200
Message-ID: <20180507125146.75crpaj2scav7mql@linutronix.de>
References: <20180504163041.28726-1-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, gregkh@linuxfoundation.org,
        Daniel Wagner <daniel.wagner@siemens.com>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504163041.28726-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-05-04 18:30:41 [+0200], Daniel Wagner wrote:
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
>  	unsigned long flags;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
>  #if defined(SUPPORT_SYSRQ)
> -	if (port->sysrq)
> +	if (port->sysrq) {
>  		locked = 0;
> -	else
> +		local_irq_save(flags);

how is this helping? You should see a splat after a sysrq request.

> +	} else
>  #endif
>  	if (oops_in_progress)
> -		locked = spin_trylock(&port->lock);
> +		locked = spin_trylock_irqsave(&port->lock, flags);
>  	else
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);
>  
>  	/* first save SCSCR then disable interrupts, keep clock source */
>  	ctrl = serial_port_in(port, SCSCR);

Sebastian
