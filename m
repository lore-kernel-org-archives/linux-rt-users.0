From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Re: OHCI issue with RT patch
Date: Thu, 4 Nov 2010 12:04:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA75F2F5@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404AA75F2EB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "B, Ravi" <ravibabu@ti.com>, Remy Bohmer <linux@bohmer.net>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41182 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab0KDGf4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Nov 2010 02:35:56 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404AA75F2EB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> 2010/10/22 B, Ravi <ravibabu@ti.com>:
> > Dear All,
> >
> > I am using Linux 2.6.33.7 stable kernel + patch-2.6.33.7-rt29 to test
> OHCI interface on TI OMAPL138 platform.
> > We observed that during bootup and OHCI init sequence the kernel hangs.
> If we use plane Linux 2.6.33.7 stable kernel
> > Without RT patch then OHCI works fine.
> 
> Just a guess: Are you using the SLAB or SLOB allocator?
> We have seen that SLOB gives all kinds of weird problems in OHCI. SLAB
> works fine here.

I did further debugging on this and seems the issue could be due to
RT changes done at kernel/irq/manage.c

We faced the same hang issue even when CONFIG_PREEMPT_RT is disabled.
Then we tried below patch which reverts a change by RT patch and
observed it to start working fine.

------------ ------- ----------------
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -746,8 +746,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
                rand_initialize_irq(irq);
        }

-       /* Preempt-RT setup for forced threading */
-       preempt_hardirq_setup(new);
+       /* Oneshot interrupts are not allowed with shared */
+       if ((new->flags & IRQF_ONESHOT) && (new->flags & IRQF_SHARED))
+               return -EINVAL;

        /*
         * Check whether the interrupt nests into another interrupt
--------------------------------------

Unfortunately if we enable CONFIG_PREEMPT_RT with above patch applied,
Then we see a series of kernel panics as shown below.

--------------------------------------
 (__bug+0x0/0x2c) from [<c0286c1c>] (rt_spin_lock_slowlock+0x88/0x24c)
 (rt_spin_lock_slowlock+0x0/0x24c) from (rt_spin_lock+0x44/0x48)
rt_spin_lock+0x0/0x48) from [<c01cd4ec>] (ohci_irq+0x134/0x1c0)
 (ohci_irq+0x0/0x1c0) from [<c01be3a0>] (usb_hcd_irq+0x3c/0x84)
 (usb_hcd_irq+0x0/0x84) from [<c00693c4>] (handle_irq_action+0x9c/0xa0)
 (handle_irq_action+0x0/0xa0) from [<c00693ec>] (handle_IRQ_event+0x24/0xd0)
handle_IRQ_event+0x0/0xd0) from [<c006b400>] (handle_edge_irq+0x15c/0x1d0)
 (handle_edge_irq+0x0/0x1d0) from [<c0027074>] (asm_do_IRQ+0x74/0x94)
 (asm_do_IRQ+0x0/0x94) from [<c0027b4c>] (__irq_svc+0x4c/0x9c)
---------------------------------------

There seems to be problem with kernel/irq/* changes done in RT patch.
Can some help me resolve this issue.

Regards,
Ajay
> 
> Kind regards,
> 
> Remy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
