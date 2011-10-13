From: Joey Oravec <joravec@drewtech.com>
Subject: fixing irq latency from spin_lock_irqsave
Date: Thu, 13 Oct 2011 15:52:12 -0400
Message-ID: <4E97416C.50309@drewtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from drewtech.com ([66.36.241.150]:33827 "EHLO server.drewtech.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab1JMT64 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Oct 2011 15:58:56 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello developers,

Hopefully this is the right list. I'm trying to improve interrupt 
latency on my 1ghz Marvell ARM platform. I used the irqsoff tracer to 
check drivers one-by-one and characterize my system. My max latency is 
80-500 uS at idle and certain drivers are hotspots: ath9k (3000 uS), 
sata disk (2000 uS), and 8250 serial (9000+ uS).

In each case it looks like the latency was caused by spin_lock_irqsave() 
around something that waited for I/O. For example function 
ath9k_ps_wakeup holds a spin lock for a 10ms timeout while the card 
powers up. Or function serial8250_console_write holds a spin lock 
waiting for bytes to transmit at 115.2 kBaud.

My plan was to change any of these hotspots to a threaded IRQ handler, 
change spin locks to mutex, and retest. That worked in some simple cases 
but ath9k has 10+ spinlocks, tasklets, etc. Can anybody recommend a 
general approach for improving spin_lock_irqsave() without completely 
reworking each driver's locking strategy? Are there any documents that I 
should start with?

-joey
