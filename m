From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own
 oneshot-like handling
Date: Mon, 14 Mar 2016 23:13:29 +0000
Message-ID: <20160314231329.1c3a2978@laptop>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-serial@vger.kernel.org>, Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-rt-users@vger.kernel.org>,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.10]:19213 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083AbcCNXNd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 19:13:33 -0400
In-Reply-To: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Mar 2016 11:34:36 +0100, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> This patch depends on patch "sc16is7xx: drop bogus use of IRQF_ONESHOT" 
> 
>  drivers/tty/serial/sc16is7xx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 73d46e2..96d1f3e 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -706,13 +706,20 @@ static void sc16is7xx_ist(struct kthread_work *ws)
>  	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
>  	int i;
>  
> -	for (i = 0; i < s->devtype->nr_uart; ++i)
> +	for (i = 0; i < s->devtype->nr_uart; ++i) {
>  		sc16is7xx_port_irq(s, i);
> +		enable_irq(s->p[i].port.irq);
> +	}
> +
>  }

Apart from needless multiple disable/enable (as tglx commented)
I think you also have to re-read the IRQ status (i.e. call
sc16is7xx_port_irq()) because IRQs coming between status read and
enable_irq may get lost for some IRQ controllers.
