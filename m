From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"
Date: Tue, 01 Oct 2013 09:54:51 +0200
Message-ID: <524A7FCB.3020406@linutronix.de>
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab3JAHyy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Oct 2013 03:54:54 -0400
In-Reply-To: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/01/2013 09:26 AM, Wolfram Sang wrote:
> This reverts commit 6391f697d4892a6f233501beea553e13f7745a23. The
> compiler warning it wants to fix does not appear with my gcc 4.6.2. IMO
> we don't need superfluous (and here even misleading) code to make old
> compilers happy. Fixing the printout was bogus, too. We want to know
> WHICH critical irq failed, not which level it had.

According to minimal Doc*/Changes minimal gcc is 3.2. Mine was 4.3.5.
Why miss leading code? Default here does the same as unhandled and crit
where it does nothing. Any why do you want to see l2irq since it was
not in the case statement? l2 holds the number, l1 the level.

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>
> ---
> 
> Have I been on CC when the original patch was sent?

You were but your email bounced. I wasn't aware of this new email
address you are using now.

> 
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> index b69221b..b89ef65 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -373,9 +373,8 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
>  	case MPC52xx_IRQ_L1_PERP: irqchip = &mpc52xx_periph_irqchip; break;
>  	case MPC52xx_IRQ_L1_SDMA: irqchip = &mpc52xx_sdma_irqchip; break;
>  	case MPC52xx_IRQ_L1_CRIT:
> -	default:
>  		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping it.\n",
> -			__func__, l1irq);
> +			__func__, l2irq);
>  		irq_set_chip(virq, &no_irq_chip);
>  		return 0;
>  	}
> 

Sebastian
