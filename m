From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: [PATCH] USB: g_serial: fix deadlock with PREEMPT_RT enabled
Date: Fri, 28 Oct 2011 14:16:25 +0200
Message-ID: <1319804185-18559-1-git-send-email-michael.thalmeier@hale.at>
Mime-Version: 1.0
Cc: rt <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Michael Thalmeier <michael@thalmeier.at>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In commit 44a0c0190b500ee6bcfc0976fe540f65dee2cd67 unlocking of spin_locks has
been removed. This patch party restores this functionality.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/usb/gadget/u_serial.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/u_serial.c b/drivers/usb/gadget/u_serial.c
index 40f7716..a925b9e 100644
--- a/drivers/usb/gadget/u_serial.c
+++ b/drivers/usb/gadget/u_serial.c
@@ -553,7 +553,16 @@ recycle:
 	 * a workqueue, so we won't get callbacks and can hold port_lock
 	 */
 	if (tty && do_push) {
+		/*
+		 * Drop the lock here since it might end up calling
+		 * gs_flush_chars, which takes the lock.
+		 */
+		spin_unlock_irq(&port->port_lock);
 		tty_flip_buffer_push(tty);
+		spin_lock_irq(&port->port_lock);
+
+		/* tty may have been closed */
+		tty = port->port_tty;
 	}
 
 
-- 
1.7.6.4



--
Scanned by MailScanner.
