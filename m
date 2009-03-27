From: Robin Gareus <robin@gareus.org>
Subject: 2.6.29-rt1+ irqbalance = OOPS
Date: Fri, 27 Mar 2009 17:16:10 +0100
Message-ID: <49CCFBCA.6050702@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:60435 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbZC0Q2A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Mar 2009 12:28:00 -0400
Received: from [192.168.3.102]
	(LAubervilliers-151-12-102-192.w193-252.abo.wanadoo.fr [193.252.206.192])
	by post.strato.de (fruni mo58) (RZmta 18.28)
	with ESMTP id p044c5l2RFkSKS for <linux-rt-users@vger.kernel.org>;
	Fri, 27 Mar 2009 17:16:15 +0100 (MET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Starting the irqbalance daemon ( http://www.irqbalance.org/ ) on
2.6.29-rt1 causes the system to OOPS and freeze. irqbalance works fine
with previous realtime kernels (2.6.24.7-rt27).

The OOPS seems to be caused by the PID of the [timer] IRQ-1. However the
OOPS message is too long and I can't read the beginning lines on the
terminal. The system hangs so I can't scroll back and it's not written
to any log. SysRq does also not work after the OOPS.

A bit off topic, but how can I capture those OOPSes?

I could get a larger screen and a digital camera ;) The lkcd.sf.net
patch does not apply to 2.6.29. Running a realtime kernel in qemu does
not make much sense, although it may be sufficient to reproduce this OOPS.
Is there a way to use USB as serial console using a hub and two
computers? I guess I'll need a dongle or sth. Besides would a printk()
to a serial port work even if some IRQ handler hangs?

Any ideas? links?
robin
