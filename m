From: Monica Puig-Pey <puigpeym@unican.es>
Subject: How to establish a priority to an interrupt handler
Date: Mon, 16 May 2011 12:26:09 +0200
Message-ID: <4DD0FBC1.9050708@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver1.unican.es ([130.206.5.100]:42318 "EHLO
	ccserver1.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1EPKZ4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 May 2011 06:25:56 -0400
Received: from ccserver1.unican.es (ccserver1.unican.es [127.0.0.1])
	by ccserver1.unican.es (Postfix) with ESMTP id 255EA40AF8
	for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2011 12:26:10 +0200 (CEST)
Received: from correouc.unican.es (cas02.unican.es [193.144.193.214])by
	ccserver1.unican.es (Postfix) with ESMTP id 1A2E240AF6for
	<linux-rt-users@vger.kernel.org>; Mon, 16 May 2011 12:26:10 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm using Ubuntu 10.04 with the 2.6.31-11-rt patch installed. I'm=20
developing a PCI device driver using hardware interrupts.
As I read at the RT wiki=20
(https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch )=20
interrupts are moved to kernel threads called Threaded Interrupts in th=
e=20
RT patch.

I would like to give a priority chosen by me to my IRQ handler, but I=20
don't know how to do it, or if it is possible (it seems it is).

I've found (http://lwn.net/Articles/302043/ ) that what I had to use in=
=20
order to get Threaded Interrupt is:

int request_threaded_irq(unsigned int irq, irq_handler_t handler,
                      irq_handler_t quick_check_handler,
                      unsigned long flags, const char *name, void *dev)

But there is not priority there!

Using ps -eo pid,pri,rtprio,cmd I've seen my handler runs with priority=
 50.

I also used :

int request_irq (unsigned int irq, void (*handler) (int, void *, struct=
=20
pt_regs *), unsigned long irqflags, const char *devname, void *dev_id);

and using ps command here my handler still runs with priority 50.=20
Shouldn't it work as a non threaded interrupt then? Why 50 instead 99 o=
r=20
the highest priority one?

Which function should I use to chose the priority for the IRQ thread?

Is there any other function to call from this context where my handler=20
could know its priority?

Thank you

M=F3nica
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
