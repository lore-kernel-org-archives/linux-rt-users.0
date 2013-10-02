From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"
Date: Wed, 02 Oct 2013 09:12:16 +0200
Message-ID: <524BC750.1090401@linutronix.de>
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de> <524A7FCB.3020406@linutronix.de> <20131001091115.GB2993@katana> <524AF913.6020007@linutronix.de> <20131001190344.GA3006@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40576 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3JBHMT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Oct 2013 03:12:19 -0400
In-Reply-To: <20131001190344.GA3006@katana>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/01/2013 09:03 PM, Wolfram Sang wrote:
> 
> Yup. But I just remembered a better solution:
> 
> From: Wolfram Sang <wsa@the-dreams.de> Subject: [PATCH] ppc:
> mpc52xx: silence false positive from old GCC
> 
> So people can compile with -Werror.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de> --- 
> arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +- 1 file changed,
> 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c index b89ef65..2898b73
> 100644 --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c +++
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c @@ -340,7 +340,7 @@
> static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int
> virq, { int l1irq; int l2irq; -	struct irq_chip *irqchip; +	struct
> irq_chip *uninitialized_var(irqchip); void *hndlr; int type; u32
> reg;
> 
> 
> uninitialized_var was created for exactly that purpose IIRC.

Yup, looks good, thanks.

> 
> Thanks,
> 
> Wolfram
> 

Sebastian
