Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D810C0650F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B362190C
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294010;
	bh=zfX53Rehf53eUfIAVFAcv0jv9LkBWT66Wd3oX4Aor80=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=JurMRzf7xnsfX2pO9hSt5dqokZ0qfGygBVZNkLFeLouYoS3DvXGJeeEbp4IibosnI
	 iplhwLEtshIiiubsPvULmuwkyXK09nRTs5cx6bBXEo2vCn2JYPgTzJPAbf1G1tyZcJ
	 YH1VOkxElbevc9sKkgLEejnN3PqH9Uv9gLKnqbIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404582AbfHHTx2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404572AbfHHTx1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:27 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEA3218E0;
        Thu,  8 Aug 2019 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294006;
        bh=zfX53Rehf53eUfIAVFAcv0jv9LkBWT66Wd3oX4Aor80=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=xw36LW7dQdOUXvabj6qG9uFeNtiOMKvOpkvsJ+/hlUR9ZYqlBB2k2WtBt5gngbtyu
         rf5/0Cz84YeuGsZnbeq5U30km4b7T4Ooo8EhJ7CD/cqU2Ie70nzwvaAhZFCYa44BMS
         Z3l8azPEtrFsPx9QaZ9A4mFYGMDJKvhAyiPeMUDo=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 17/19] futex: Delay deallocation of pi_state
Date:   Thu,  8 Aug 2019 14:52:45 -0500
Message-Id: <76a278120523c1376fb32fca3ce295e109a1feac.1565293935.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit d7c7cf8cb68b7df17e6e50be1f25f35d83e686c7 ]

On -RT we can't invoke kfree() in a non-preemptible context.

Defer the deallocation of pi_state to preemptible context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/futex.c | 55 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 0548070cda89..5f1cfa2f02b6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -822,13 +822,13 @@ static void get_pi_state(struct futex_pi_state *pi_state)
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
  */
-static void put_pi_state(struct futex_pi_state *pi_state)
+static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
-		return;
+		return NULL;
 
 	if (!atomic_dec_and_test(&pi_state->refcount))
-		return;
+		return NULL;
 
 	/*
 	 * If pi_state->owner is NULL, the owner is most probably dying
@@ -848,9 +848,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (current->pi_state_cache) {
-		kfree(pi_state);
-	} else {
+	if (!current->pi_state_cache) {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -859,6 +857,30 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		pi_state->owner = NULL;
 		atomic_set(&pi_state->refcount, 1);
 		current->pi_state_cache = pi_state;
+		pi_state = NULL;
+	}
+	return pi_state;
+}
+
+static void put_pi_state(struct futex_pi_state *pi_state)
+{
+	kfree(__put_pi_state(pi_state));
+}
+
+static void put_pi_state_atomic(struct futex_pi_state *pi_state,
+				struct list_head *to_free)
+{
+	if (__put_pi_state(pi_state))
+		list_add(&pi_state->list, to_free);
+}
+
+static void free_pi_state_list(struct list_head *to_free)
+{
+	struct futex_pi_state *p, *next;
+
+	list_for_each_entry_safe(p, next, to_free, list) {
+		list_del(&p->list);
+		kfree(p);
 	}
 }
 
@@ -893,6 +915,7 @@ void exit_pi_state_list(struct task_struct *curr)
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
+	LIST_HEAD(to_free);
 
 	if (!futex_cmpxchg_enabled)
 		return;
@@ -937,7 +960,7 @@ void exit_pi_state_list(struct task_struct *curr)
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
 			raw_spin_unlock(&hb->lock);
-			put_pi_state(pi_state);
+			put_pi_state_atomic(pi_state, &to_free);
 			continue;
 		}
 
@@ -956,6 +979,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
+
+	free_pi_state_list(&to_free);
 }
 
 #endif
@@ -1938,6 +1963,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
+	LIST_HEAD(to_free);
 
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -2175,7 +2201,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 * object.
 				 */
 				this->pi_state = NULL;
-				put_pi_state(pi_state);
+				put_pi_state_atomic(pi_state, &to_free);
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
@@ -2192,7 +2218,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
 	 * need to drop it here again.
 	 */
-	put_pi_state(pi_state);
+	put_pi_state_atomic(pi_state, &to_free);
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
@@ -2213,6 +2239,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 out_put_key1:
 	put_futex_key(&key1);
 out:
+	free_pi_state_list(&to_free);
 	return ret ? ret : task_count;
 }
 
@@ -2350,13 +2377,16 @@ static int unqueue_me(struct futex_q *q)
 static void unqueue_me_pi(struct futex_q *q)
 	__releases(q->lock_ptr)
 {
+	struct futex_pi_state *ps;
+
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
-	put_pi_state(q->pi_state);
+	ps = __put_pi_state(q->pi_state);
 	q->pi_state = NULL;
 
 	raw_spin_unlock(q->lock_ptr);
+	kfree(ps);
 }
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -3305,6 +3335,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
+			struct futex_pi_state *ps_free;
+
 			raw_spin_lock(q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
@@ -3315,8 +3347,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
-			put_pi_state(q.pi_state);
+			ps_free = __put_pi_state(q.pi_state);
 			raw_spin_unlock(q.lock_ptr);
+			kfree(ps_free);
 		}
 	} else {
 		struct rt_mutex *pi_mutex;
-- 
2.14.1

