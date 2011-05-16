From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Re:How to establish a priority to an interrupt handler
Date: Mon, 16 May 2011 16:50:57 +0200 (CEST)
Message-ID: <9385970.13897.1305557457392.JavaMail.root@WARSBL113.highway.telekom.at>
Reply-To: hannes_bauer@aon.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout06.highway.telekom.at ([195.3.96.89]:56723 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756056Ab1EPOvA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 May 2011 10:51:00 -0400
Received: from warsbl113-nfs.highway.telekom.at (HELO WARSBL113.highway.telekom.at) ([172.18.96.90])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub97.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 16 May 2011 14:50:57 -0000
Received: from WARSBL113.highway.telekom.at (localhost.localdomain [127.0.0.1])
	by WARSBL113.highway.telekom.at (8.13.1/8.13.1) with ESMTP id p4GEovQY027445
	for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2011 16:50:57 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Monica!

You can change the priority of the irq thread with the _chrt_ tool from=
 user space.

With preempt-rt all your interrupts are forced threaded ones (excluding=
 timer interrupt and may some others). If you realy want it to be execu=
ted in hard interrupt context u have to use the IRQF_NODELAY as irqflag=
 when requesting the interrupt with request_irq().

This could however lead to larger latencies for the system, especially =
when your interrupt handler is long, since all irqs are disabled in tha=
t context. On the other hand your interrupt latency will be much shorte=
r since no schedule() has to be done to schedule the irq_thread.

If you need to change the priority from within the driver code this thr=
ead (http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg0102=
2.html) my be interesting for you.

I hope this is helping you.

Kind regards

Johannes Bauer


----- Urspr=C3=BCngliche Nachricht -----
Von: "Monica Puig-Pey"
Erhalten: 16.05.2011 12:26
An: linux-rt-users@vger.kernel.org

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

M=C3=B3nica
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
