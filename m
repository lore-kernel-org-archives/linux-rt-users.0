Return-Path: <SRS0=wgqT=ZL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE635C432C0
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0455222EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 08:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKSIqo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:46:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSIqo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Nov 2019 03:46:44 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iWz9k-0000CR-Vm; Tue, 19 Nov 2019 09:46:41 +0100
Date:   Tue, 19 Nov 2019 09:46:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section on RT
Message-ID: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On !RT a locked spinlock_t and rwlock_t disables preemption which
implies a RCU read section. There is code that relies on that behaviour.

Add an explicit RCU read section on RT while a sleeping lock (a lock
which would disables preemption on !RT) acquired.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c   | 6 ++++++
 kernel/locking/rwlock-rt.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cf09f8e7ed0f4..602eb7821a1b1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1141,6 +1141,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1156,6 +1157,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1169,6 +1171,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
@@ -1200,6 +1203,7 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -1216,6 +1220,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		sleeping_lock_inc();
+		rcu_read_lock();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	} else
@@ -1232,6 +1237,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		sleeping_lock_inc();
+		rcu_read_lock();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	}
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index c3b91205161cc..0ae8c62ea8320 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -310,6 +310,7 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 	ret = do_read_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -327,6 +328,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 	ret = do_write_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -338,6 +340,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_read_rt_lock(rwlock);
@@ -347,6 +350,7 @@ EXPORT_SYMBOL(rt_read_lock);
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_write_rt_lock(rwlock);
@@ -358,6 +362,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_read_rt_unlock(rwlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_read_unlock);
@@ -367,6 +372,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_write_rt_unlock(rwlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_write_unlock);
-- 
2.24.0

