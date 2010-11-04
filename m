From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: OHCI issue with RT patch
Date: Thu, 4 Nov 2010 11:33:15 +0300
Message-ID: <201011041133.15660@blacky.localdomain>
References: <19F8576C6E063C45BE387C64729E739404AA75F2EB@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E739404AA75F2F5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:36804 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0KDIda (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Nov 2010 04:33:30 -0400
Received: from mail.lvk.cs.msu.su (localhost [127.0.0.1])
	by mail.lvk.cs.msu.su (Postfix) with ESMTP id 7A6B850AC
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Nov 2010 11:33:16 +0300 (MSK)
Received: from blacky.home (unknown [91.79.29.86])
	by mail.lvk.cs.msu.su (Postfix) with ESMTPSA id 5A0F450A4
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Nov 2010 11:33:16 +0300 (MSK)
Received: from nikita by blacky.home with local (Exim 4.69)
	(envelope-from <yoush@cs.msu.su>)
	id 1PDvFz-0006jp-LT
	for linux-rt-users@vger.kernel.org; Thu, 04 Nov 2010 11:33:15 +0300
In-Reply-To: <19F8576C6E063C45BE387C64729E739404AA75F2F5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I did further debugging on this and seems the issue could be due to
> RT changes done at kernel/irq/manage.c
>
> We faced the same hang issue even when CONFIG_PREEMPT_RT is disabled.
> Then we tried below patch which reverts a change by RT patch and
> observed it to start working fine.
>
> ------------ ------- ----------------
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -746,8 +746,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,
> struct irqaction *new) rand_initialize_irq(irq);
>         }
>
> -       /* Preempt-RT setup for forced threading */
> -       preempt_hardirq_setup(new);
> +       /* Oneshot interrupts are not allowed with shared */
> +       if ((new->flags & IRQF_ONESHOT) && (new->flags & IRQF_SHARED))
> +               return -EINVAL;
>
>         /*
>          * Check whether the interrupt nests into another interrupt

Do I understand correctly that by this change you are disabling important 
part if preempt-rt, namely hardirq threading?
