From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/6] mm: swap: Initialize local locks early
Date: Wed, 06 Feb 2013 16:58:23 -0500
Message-ID: <20130206215915.682758618@goodmis.org>
References: <20130206215818.969089606@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-mm-swap-Initialize-local-locks-early.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/swap.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 2051da9..62dc70c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -767,6 +767,15 @@ unsigned pagevec_lookup_tag(struct pagevec *pvec, struct address_space *mapping,
 }
 EXPORT_SYMBOL(pagevec_lookup_tag);
 
+/* Early setup for the local locks */
+static int __init swap_init_locks(void)
+{
+	local_irq_lock_init(rotate_lock);
+	local_irq_lock_init(swap_lock);
+	return 1;
+}
+early_initcall(swap_init_locks);
+
 /*
  * Perform any setup for the swap system
  */
@@ -774,9 +783,6 @@ void __init swap_setup(void)
 {
 	unsigned long megs = totalram_pages >> (20 - PAGE_SHIFT);
 
-	local_irq_lock_init(rotate_lock);
-	local_irq_lock_init(swap_lock);
-
 #ifdef CONFIG_SWAP
 	bdi_init(swapper_space.backing_dev_info);
 #endif
-- 
1.7.10.4
