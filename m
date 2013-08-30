From: Mike Galbraith <bitbucket@online.de>
Subject: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Fri, 30 Aug 2013 16:39:40 +0200
Message-ID: <1377873580.5422.25.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
	 <1377842245.5422.7.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64236 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab3H3Ojq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 10:39:46 -0400
In-Reply-To: <1377842245.5422.7.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

The semaphore scalability changes have a less than wonderful trait for
-rt.  The below.. makes it not do that.  I originally did this to test
(and actually survive) scalability patches backported to 3.0-rt on a 64
core box, and was just rudely reminded of the problem after putting
3.10-rt onto the same box for latency comparison.


goto again loop can and does induce livelock in -rt.  Remove it.

Signed-off-by: Mike Galbraith <bitbucket@online.de>

---
 ipc/sem.c |   56 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)

Index: linux-2.6/ipc/sem.c
===================================================================
--- linux-2.6.orig/ipc/sem.c
+++ linux-2.6/ipc/sem.c
@@ -208,22 +208,11 @@ void __init sem_init (void)
 static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
 			      int nsops)
 {
+	struct sem *sem;
 	int locknum;
- again:
-	if (nsops == 1 && !sma->complex_count) {
-		struct sem *sem = sma->sem_base + sops->sem_num;
-
-		/* Lock just the semaphore we are interested in. */
-		spin_lock(&sem->lock);
 
-		/*
-		 * If sma->complex_count was set while we were spinning,
-		 * we may need to look at things we did not lock here.
-		 */
-		if (unlikely(sma->complex_count)) {
-			spin_unlock(&sem->lock);
-			goto lock_array;
-		}
+	if (nsops == 1 && !sma->complex_count) {
+		sem = sma->sem_base + sops->sem_num;
 
 		/*
 		 * Another process is holding the global lock on the
@@ -231,9 +220,29 @@ static inline int sem_lock(struct sem_ar
 		 * but have to wait for the global lock to be released.
 		 */
 		if (unlikely(spin_is_locked(&sma->sem_perm.lock))) {
-			spin_unlock(&sem->lock);
-			spin_unlock_wait(&sma->sem_perm.lock);
-			goto again;
+			spin_lock(&sma->sem_perm.lock);
+			if (sma->complex_count)
+				goto wait_array;
+
+			/*
+			 * Acquiring our sem->lock under the global lock
+			 * forces new complex operations to wait for us
+			 * to exit our critical section.
+			 */
+			spin_lock(&sem->lock);
+			spin_unlock(&sma->sem_perm.lock);
+		} else {
+			/* Lock just the semaphore we are interested in. */
+			spin_lock(&sem->lock);
+
+			/*
+			 * If sma->complex_count was set prior to acquisition,
+			 * we must fall back to the global array lock.
+			 */
+			if (unlikely(sma->complex_count)) {
+				spin_unlock(&sem->lock);
+				goto lock_array;
+			}
 		}
 
 		locknum = sops->sem_num;
@@ -247,11 +256,22 @@ static inline int sem_lock(struct sem_ar
 		 */
  lock_array:
 		spin_lock(&sma->sem_perm.lock);
+ wait_array:
 		for (i = 0; i < sma->sem_nsems; i++) {
-			struct sem *sem = sma->sem_base + i;
+			sem = sma->sem_base + i;
+#ifdef CONFIG_PREEMPT_RT_BASE
+			if (spin_is_locked(&sem->lock))
+#endif
 			spin_unlock_wait(&sem->lock);
 		}
 		locknum = -1;
+
+		if (nsops == 1 && !sma->complex_count) {
+			sem = sma->sem_base + sops->sem_num;
+			spin_lock(&sem->lock);
+			spin_unlock(&sma->sem_perm.lock);
+			locknum = sops->sem_num;
+		}
 	}
 	return locknum;
 }


