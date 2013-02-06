From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/6] mm: swap: Initialize local locks early
Date: Wed, 06 Feb 2013 17:02:15 -0500
Message-ID: <20130206220251.431154934@goodmis.org>
References: <20130206220210.823160521@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5792 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758325Ab3BFWCw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 17:02:52 -0500
Content-Disposition: inline; filename=0005-mm-swap-Initialize-local-locks-early.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/swap.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index e3f7d6f..c428897 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -772,6 +772,15 @@ unsigned pagevec_lookup(struct pagevec *pvec, struct address_space *mapping,
 
 EXPORT_SYMBOL(pagevec_lookup);
 
+/* Early setup for the local locks */
+static int __init swap_init_locks(void)
+{
+	local_irq_lock_init(rotate_lock);
+	local_irq_lock_init(swap_lock);
+	return 1;
+}
+early_initcall(swap_init_locks);
+
 unsigned pagevec_lookup_tag(struct pagevec *pvec, struct address_space *mapping,
 		pgoff_t *index, int tag, unsigned nr_pages)
 {
@@ -789,9 +798,6 @@ void __init swap_setup(void)
 {
 	unsigned long megs = totalram_pages >> (20 - PAGE_SHIFT);
 
-	local_irq_lock_init(rotate_lock);
-	local_irq_lock_init(swap_lock);
