Return-Path: <SRS0=rYaE=26=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4720C32771
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Jan 2020 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF5E2072A
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Jan 2020 12:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgAIM32 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:29:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54147 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgAIM32 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Jan 2020 07:29:28 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ipWwH-0001KM-H8; Thu, 09 Jan 2020 13:29:25 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Dick Hollenbeck <dick@softplc.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: 8250: set_ier(), clear_ier() and the concept of atomic console writes
References: <6e0f459a-d3dc-73cb-679f-6e86008048e1@softplc.com>
        <87woarjucv.fsf@linutronix.de>
        <58f88e2b-de16-0c0a-b863-521b13ae45de@softplc.com>
Date:   Thu, 09 Jan 2020 13:29:23 +0100
In-Reply-To: <58f88e2b-de16-0c0a-b863-521b13ae45de@softplc.com> (Dick
        Hollenbeck's message of "Fri, 20 Dec 2019 07:53:47 -0600")
Message-ID: <87blrcerto.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Dick,

On 2019-12-20, Dick Hollenbeck <dick@softplc.com> wrote:
> I've included a partial patch against Greg KH's tree below just to
> convey the design concepts that I introduce below in 4), 5) and 6).
>
> Hopefully this can draw a bridge between mainline, RT and where Greg
> is going with his tree, and make everyone happy.

After spending time working with and completing your patch, I realized
that the 8250 atomic console implementation does not need to be so
complex. Only serial8250_console_write_atomic() needs to track if it
needs to re-enable IER. Everything else can be as in mainline.

I will post a patch that reverts the unneeded complexity, which will
solve your problem.

Creating a macro for clearing IER is probably a good idea anyway to
eliminate all the capabilities-checking redundancy. But I'll leave that
as an excercise for mainline.

Your patch helped me to realize the insanity in what I was doing. Thank
you.

John Ogness

> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 33ad9d6de..e035e91ac 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -130,12 +130,31 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
>  	up->dl_write(up, value);
>  }
>
> +/* All write access to IER comes through here, for instrumentation sake. */
> +static inline unsigned char serial8250_set_IER(struct uart_8250_port *up, unsigned char ier)
> +{
> +#ifdef CONFIG_NMI_CONSOLE_CORNER_CASE
> +	return __serial9250_set_IER(p, ier)
> +#else
> +	unsigned char prior = up->ier;
> +
> +	up->ier = ier;	/* struct's ier field is always current with hardware */
> +	serial_out(up, UART_IER, ier);
> +	return prior;
> +#endif
> +}
> +
> +static inline unsigned char serial8250_clear_IER(struct uart_8250_port *up)
> +{
> +	return serial8250_set_IER(up, up->capabilities & UART_CAP_UUE ? UART_IER_UUE : 0);
> +}
> +
>  static inline bool serial8250_set_THRI(struct uart_8250_port *up)
>  {
>  	if (up->ier & UART_IER_THRI)
>  		return false;
> -	up->ier |= UART_IER_THRI;
> -	serial_out(up, UART_IER, up->ier);
> +
> +	serial8250_set_IER(up, up->ier | UART_IER_THRI);
>  	return true;
>  }
>
> @@ -143,8 +162,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
>  {
>  	if (!(up->ier & UART_IER_THRI))
>  		return false;
> -	up->ier &= ~UART_IER_THRI;
> -	serial_out(up, UART_IER, up->ier);
> +	serial8250_set_IER(up, up->ier & ~UART_IER_THRI);
>  	return true;
>  }
>
> @@ -343,3 +361,7 @@ static inline int serial_index(struct uart_port *port)
>  {
>  	return port->minor - 64;
>  }
> +
> +#ifdef CONFIG_NMI_CONSOLE_CORNER_CASE
> +unsigned char __serial8250_set_IER(struct uart_8250_port *up, unsigned char ier);
> +#endif
