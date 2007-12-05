From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] Generic IRQ: Add unlocked version of set_irq_handler()
Date: Tue,  4 Dec 2007 22:00:36 -0800
Message-ID: <1196834437-19223-4-git-send-email-khilman@mvista.com>
References: <1196834437-19223-1-git-send-email-khilman@mvista.com>
 <1196834437-19223-2-git-send-email-khilman@mvista.com>
 <1196834437-19223-3-git-send-email-khilman@mvista.com>
Cc: David Brownell <david-b@pacbell.net>,
	Russell King <linux@arm.linux.org.uk>,
	Remy Bohmer <linux@bohmer.net>, linux-rt-users@vger.kernel.org,
	Kevin Hilman <khilman@mvista.com>
To: linux-omap@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:60178 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751495AbXLEGKV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 01:10:21 -0500
In-Reply-To: <1196834437-19223-3-git-send-email-khilman@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add unlocked version for use by irq_chip.set_type handlers which may
wish to change handler to level or edge handler when IRQ type is
changed.

The normal set_irq_handler() call cannot be used because it tries to
take irq_desc.lock which is already held when the irq_chip.set_type
hook is called.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 include/linux/irq.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 879ab83..2465709 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -347,6 +347,13 @@ extern void
 __set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 		  const char *name);
 
+/* caller has locked the irq_desc and both params are valid */
+static inline void __set_irq_handler_unlocked(int irq, 
+					      irq_flow_handler_t handler)
+{
+	irq_desc[irq].handle_irq = handler;
+}
+
 /*
  * Set a highlevel flow handler for a given IRQ:
  */
-- 
1.5.3.5
