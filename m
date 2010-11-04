From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: OHCI issue with RT patch
Date: Thu, 4 Nov 2010 14:06:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA75F337@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404AA75F2EB@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E739404AA75F2F5@dbde02.ent.ti.com>
 <201011041133.15660@blacky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab0KDIgf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Nov 2010 04:36:35 -0400
In-Reply-To: <201011041133.15660@blacky.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
> > I did further debugging on this and seems the issue could be due to
> > RT changes done at kernel/irq/manage.c
> >
> > We faced the same hang issue even when CONFIG_PREEMPT_RT is disabled.
> > Then we tried below patch which reverts a change by RT patch and
> > observed it to start working fine.
> >
> > ------------ ------- ----------------
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -746,8 +746,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,
> > struct irqaction *new) rand_initialize_irq(irq);
> >         }
> >
> > -       /* Preempt-RT setup for forced threading */
> > -       preempt_hardirq_setup(new);
> > +       /* Oneshot interrupts are not allowed with shared */
> > +       if ((new->flags & IRQF_ONESHOT) && (new->flags & IRQF_SHARED))
> > +               return -EINVAL;
> >
> >         /*
> >          * Check whether the interrupt nests into another interrupt
> 
> Do I understand correctly that by this change you are disabling important
> part if preempt-rt, namely hardirq threading?

Yes, correct and that's why it seems I am getting series of kernel panics.

-Ajay
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
