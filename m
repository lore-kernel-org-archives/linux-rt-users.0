From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3.10-rt] simple-wait: rename and export the equivalent of waitqueue_active()
Date: Tue, 27 Aug 2013 14:20:26 -0400
Message-ID: <1377627626-14632-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36590 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3H0SUs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Aug 2013 14:20:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The function "swait_head_has_waiters()" was internalized into
wait-simple.c but it parallels the waitqueue_active of normal
waitqueue support. Given that there are over 150 waitqueue_active
users in drivers/ fs/ kernel/ and the like, lets make it globally
visible, and rename it to parallel the waitqueue_active accordingly.
We'll need to do this if we expect to expand its usage beyond RT.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Assumption here is that we'll want to mainline the simple wait
 queue support, and hence want to align the names and all API like
 stuff as much as possible before submitting to mainline.]

 include/linux/wait-simple.h |  8 ++++++++
 kernel/wait-simple.c        | 10 +---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/wait-simple.h b/include/linux/wait-simple.h
index 4efba4d..f86bca2 100644
--- a/include/linux/wait-simple.h
+++ b/include/linux/wait-simple.h
@@ -47,6 +47,14 @@ extern void swait_prepare(struct swait_head *head, struct swaiter *w, int state)
 extern void swait_finish_locked(struct swait_head *head, struct swaiter *w);
 extern void swait_finish(struct swait_head *head, struct swaiter *w);
 
+/* Check whether a head has waiters enqueued */
+static inline bool swaitqueue_active(struct swait_head *h)
+{
+	/* Make sure the condition is visible before checking list_empty() */
+	smp_mb();
+	return !list_empty(&h->list);
+}
+
 /*
  * Wakeup functions
  */
diff --git a/kernel/wait-simple.c b/kernel/wait-simple.c
index 2c85626..7dfa86d 100644
--- a/kernel/wait-simple.c
+++ b/kernel/wait-simple.c
@@ -26,14 +26,6 @@ static inline void __swait_dequeue(struct swaiter *w)
 	list_del_init(&w->node);
 }
 
-/* Check whether a head has waiters enqueued */
-static inline bool swait_head_has_waiters(struct swait_head *h)
-{
-	/* Make sure the condition is visible before checking list_empty() */
-	smp_mb();
-	return !list_empty(&h->list);
-}
