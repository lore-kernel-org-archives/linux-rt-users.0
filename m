From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [ANNOUNCE] 3.0-rt4
Date: Thu, 28 Jul 2011 13:36:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107281330360.2660@ionos>
References: <alpine.LFD.2.02.1107272222420.2660@ionos> <45EE9921DD12714AB1D7B7B9D2FE208B0230256D4A96@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46712 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1G1LhA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 07:37:00 -0400
In-Reply-To: <45EE9921DD12714AB1D7B7B9D2FE208B0230256D4A96@dbde03.ent.ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 Jul 2011, N, Mugunthan V wrote:

> Hi RT Folks
> 
> I am testing 3.0-rt3 on AM3517 - Arm Cortex A8. As the kernel from the
> mainline is not booting I am using a patch to boot AM3517 kernel on top of
> the mainline kernel. I am getting a warning as below.
> 
> The same issue when I reported for rt3, Thomas has suggested a patch 
> that is already integrated in rt4, even then I am getting the same 
> warning.

That's a different warning as the one which was addressed by the
patch.

> Attaching the patch and the rt-config file.

Please do not send this stuff over and over.
 
Fix for the serial issue below.

Thanks,

	tglx

---
 drivers/tty/serial/omap-serial.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/tty/serial/omap-serial.c
===================================================================
--- linux-2.6.orig/drivers/tty/serial/omap-serial.c
+++ linux-2.6/drivers/tty/serial/omap-serial.c
@@ -947,13 +947,12 @@ serial_omap_console_write(struct console
 	unsigned int ier;
 	int locked = 1;
 
-	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&up->port.lock);
+		locked = spin_trylock_irqsave(&up->port.lock, flags);
 	else
-		spin_lock(&up->port.lock);
+		spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
 	 * First save the IER then disable the interrupts
@@ -980,8 +979,7 @@ serial_omap_console_write(struct console
 		check_modem_status(up);
 
 	if (locked)
-		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int __init
