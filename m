From: Thomas Pfaff <tpfaff@pcs.com>
Subject: loadavg problem with 2.6.26.8-rt16 on Atmel AT91SAM9260
Date: Thu, 19 Feb 2009 13:11:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902191110060.22561@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pcs.de ([145.253.69.50]:33266 "EHLO mail.pcs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbZBSMSl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Feb 2009 07:18:41 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

While testing the 2.6.26.8-rt16 kernel on an AT91SAM9260-EK Arm9 board i noticed 
a small regression to 2.6.24.7-rt27.

The kernel compiles and boots fine but the average load when the cpu is idle 
tends to be 1, it starts at 0 when the system boots and goes to 1 or above after 
some time.

All kernels have the at91 patches from http://maxim.org.za/sam9.html

Following kernels are ok:

2.6.24.7-rt27
2.6.26.8 without rt

With the rt patch i have tested several combinations of the PREEMPT options:

Without CONFIG_PREEMPT_HARDIRQ i get an oops on boot (see next mail).

All other CONFIG_PREEMPT_[NONE|VOLUNTARY|DESKTOP|RT] options are working but 
with the wrong average load.

--
Thomas
