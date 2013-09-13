From: Mike Galbraith <bitbucket@online.de>
Subject: [patch 1/3] ipc/sem: fix -rt livelock
Date: Fri, 13 Sep 2013 08:12:40 +0200
Message-ID: <1379052760.5455.127.camel@marge.simpson.net>
References: <1379051751.5455.112.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60430 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3IMGMx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 02:12:53 -0400
In-Reply-To: <1379051751.5455.112.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

goto again loop can and does induce livelock in -rt.  Remove it.

spin_unlock_wait(lock) in -rt kernels takes/releases the lock in question, so
all it takes to create a self perpetuating loop is for one task to start the
ball rolling by taking the array lock, other tasks see this, and react by
take/release/retry endlessly.

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



