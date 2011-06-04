From: Monica Puig-Pey <puigpeym@unican.es>
Subject: One Interrupted Threads per Interrupt line?
Date: Sat, 4 Jun 2011 13:48:57 +0200
Message-ID: <4DEA1BA9.7020303@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver1.unican.es ([130.206.5.100]:55271 "EHLO
	ccserver1.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab1FDLsd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Jun 2011 07:48:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm using Ubuntu 10.04 with the 2.6.31-11-rt patch installed. I'm=20
developing a PCI device driver using hardware interrupts.
I read in the =93Internals of the RT Patch=94 document=20
(http://www.kernel.org/doc/ols/2007/ols2007v2-pages-161-172.pdf ) that=20
when a device driver requests an IRQ, a thread is created to service=20
this interrupt line (Threaded interrupts). Only ONE thread can be=20
created per interrupt line, so shared interrupts are still handled by a=
=20
single thread.

My driver requests IRQ 16, which is shared with others handlers. Typing=
=20
on the shell  $ps -eo pid,pri,rtprio,cmd I can see my driver requesting=
=20
irq 16 and with 50 RTPRIO. At the same time I can see the others driver=
s=20
requesting IRQ 16 with different real time priorities than mine( 80, 85=
,=20
50). Does this mean that there are more than ONE Threaded Interrupts fo=
r=20
IRQ 16? or it's just the thread priority when running each handler for=20
IRQ 16?
=46inally, how could I change the 50 RT PRIO for my handler pci_9111?

Here you have the shell:

   PID PRI RTPRIO CMD

   658 120     80 [irq/16-uhci_hcd]
  3852 125     85 [irq/16-HDA Inte]
  4303  90     50 [irq/16-radeon@p]
  5863  90     50 [irq/16-pci_9111]
  5865  19      - ps -eo pid,pri,rtprio,cmd


Thank you very much,

M=F3nica
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
