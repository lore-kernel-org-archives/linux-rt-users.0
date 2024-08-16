Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA28191473;
	Fri, 16 Aug 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806366; cv=none; b=ZJV/BhIxHLHMZ2QY/EgK+fKhV411eY1zvG6Dclyry/k9cqyzv4bvcOGg/LHXOvULaC8hlXtku/QFNl2qRMI5vyPB+gSxgv4d6vZaN2wiB/+7RE61uVjve229qBSzVrlrIjr/Oh9F64zTct8wRyxwNQD3XBdVww3uSqs1keofHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806366; c=relaxed/simple;
	bh=dHeBOR0iXKJ8NFMEIvejr5Y/+Gsjod7jZ21pu/CQ+9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=netLqSXDRZFFL4p+1Ig24hmw8kLkDGJJltKILtljJUG/1vGsBKGidiPbbzsbbxCN6aNsXZAYSvx/lSrd+b31kphL/BO0e8S3u1ZIT5mV2W+GQsfgvEw1cLFSmIObFVGKTh0Rp5KqG8F9Ry3rz2gi+CmwICOj58FVgvQmrAQua2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTUOp1wW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ohiaYBsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTUOp1wW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ohiaYBsb"
Date: Fri, 16 Aug 2024 13:06:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723806362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8p1DOwcABDcP7EqrNATymKkV2zbLhMCE/BJnT0utHXY=;
	b=GTUOp1wW0ysBS0/hkFgURUSgX0UF9soTILs1iRBW3sr6k4bOIQZzXF6pgOb1vogNHL3LXY
	5zJPnNo/Tl9o4RRty3O+/gcrGoH6DKQgOEmrI4YIkPBNtOkJUw+JbwanWltvaZ4XMhzKcC
	gNWy3by8aoVJf5kFwFLNHDuJeTRkTCnZ7cTM6ywrFzc5Kh5/FL6Wmmltx/VLrnvQ9sAcPg
	Dr+cU+r9xRtJfLYORTeLqZ0ZwSuRKGk81Boqc//ZHnZgT8TUIO3ohJIRzmg6DYnzGHRw0T
	iSDtMiRo0UJh/eS/cI6Z6zrZMg/vzDR6FHciEhIKvftNuNGTs3z/jzYkXzHl5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723806362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8p1DOwcABDcP7EqrNATymKkV2zbLhMCE/BJnT0utHXY=;
	b=ohiaYBsbo6m6sNjHwDkYldKHnkBNymlCW7er0dml+aM0qRyYkAdhb/HE/7qG/wsBUtFsU9
	wQFtW1jl0yKnzjAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.11-rc3-rt3
Message-ID: <20240816110600.egmY1AJG@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.11-rc3-rt3 patch set. 

Changes since v6.11-rc3-rt2:

  - Replace the AES-GCM related patch introduced in v6.11-rc1-rt1 with
    an alternative version by Eric Biggers.

  - Add sparse annotation to PREEMPT_RT's locking functions and unusual
    locking patterns in the timer code.

Known issues
    None.

The delta patch against v6.11-rc3-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/incr/patch-6.11-rc3-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.11-rc3-rt3

The RT patch against v6.11-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patch-6.11-rc3-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patches-6.11-rc3-rt3.tar.xz

Sebastian

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index be92e4c3f9c7f..d63ba9eaba3e4 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1366,6 +1366,8 @@ gcm_crypt(struct aead_request *req, int flags)
 		err = skcipher_walk_aead_encrypt(&walk, req, false);
 	else
 		err = skcipher_walk_aead_decrypt(&walk, req, false);
+	if (err)
+		return err;
 
 	/*
 	 * Since the AES-GCM assembly code requires that at least three assembly
@@ -1381,39 +1383,31 @@ gcm_crypt(struct aead_request *req, int flags)
 	gcm_process_assoc(key, ghash_acc, req->src, assoclen, flags);
 
 	/* En/decrypt the data and pass the ciphertext through GHASH. */
-	while ((nbytes = walk.nbytes) != 0) {
-		if (unlikely(nbytes < walk.total)) {
-			/*
-			 * Non-last segment.  In this case, the assembly
-			 * function requires that the length be a multiple of 16
-			 * (AES_BLOCK_SIZE) bytes.  The needed buffering of up
-			 * to 16 bytes is handled by the skcipher_walk.  Here we
-			 * just need to round down to a multiple of 16.
-			 */
-			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
-			aes_gcm_update(key, le_ctr, ghash_acc,
-				       walk.src.virt.addr, walk.dst.virt.addr,
-				       nbytes, flags);
-			le_ctr[0] += nbytes / AES_BLOCK_SIZE;
-			kernel_fpu_end();
-			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-			kernel_fpu_begin();
-		} else {
-			/* Last segment: process all remaining data. */
-			aes_gcm_update(key, le_ctr, ghash_acc,
-				       walk.src.virt.addr, walk.dst.virt.addr,
-				       nbytes, flags);
-			kernel_fpu_end();
-			err = skcipher_walk_done(&walk, 0);
-			kernel_fpu_begin();
-			/*
-			 * The low word of the counter isn't used by the
-			 * finalize, so there's no need to increment it here.
-			 */
-		}
+	while (unlikely((nbytes = walk.nbytes) < walk.total)) {
+		/*
+		 * Non-last segment.  In this case, the assembly function
+		 * requires that the length be a multiple of 16 (AES_BLOCK_SIZE)
+		 * bytes.  The needed buffering of up to 16 bytes is handled by
+		 * the skcipher_walk.  Here we just need to round down to a
+		 * multiple of 16.
+		 */
+		nbytes = round_down(nbytes, AES_BLOCK_SIZE);
+		aes_gcm_update(key, le_ctr, ghash_acc, walk.src.virt.addr,
+			       walk.dst.virt.addr, nbytes, flags);
+		le_ctr[0] += nbytes / AES_BLOCK_SIZE;
+		kernel_fpu_end();
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+		if (err)
+			return err;
+		kernel_fpu_begin();
 	}
-	if (err)
-		goto out;
+	/* Last segment: process all remaining data. */
+	aes_gcm_update(key, le_ctr, ghash_acc, walk.src.virt.addr,
+		       walk.dst.virt.addr, nbytes, flags);
+	/*
+	 * The low word of the counter isn't used by the finalize, so there's no
+	 * need to increment it here.
+	 */
 
 	/* Finalize */
 	taglen = crypto_aead_authsize(tfm);
@@ -1441,8 +1435,9 @@ gcm_crypt(struct aead_request *req, int flags)
 				       datalen, tag, taglen, flags))
 			err = -EBADMSG;
 	}
-out:
 	kernel_fpu_end();
+	if (nbytes)
+		skcipher_walk_done(&walk, 0);
 	return err;
 }
 
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 8544ff05e594d..7d81fc6918ee8 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -24,13 +24,13 @@ do {							\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
 } while (0)
 
-extern void rt_read_lock(rwlock_t *rwlock);
+extern void rt_read_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
-extern void rt_read_unlock(rwlock_t *rwlock);
-extern void rt_write_lock(rwlock_t *rwlock);
-extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
+extern void rt_read_unlock(rwlock_t *rwlock)	__releases(rwlock);
+extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
+extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquires(rwlock);
 extern int rt_write_trylock(rwlock_t *rwlock);
-extern void rt_write_unlock(rwlock_t *rwlock);
+extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
 
 static __always_inline void read_lock(rwlock_t *rwlock)
 {
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 61c49b16f69ab..f9f14e135be7b 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -32,10 +32,10 @@ do {								\
 	__rt_spin_lock_init(slock, #slock, &__key, true);	\
 } while (0)
 
-extern void rt_spin_lock(spinlock_t *lock);
-extern void rt_spin_lock_nested(spinlock_t *lock, int subclass);
-extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock);
-extern void rt_spin_unlock(spinlock_t *lock);
+extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
+extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock);
+extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
+extern void rt_spin_unlock(spinlock_t *lock)	__releases(lock);
 extern void rt_spin_lock_unlock(spinlock_t *lock);
 extern int rt_spin_trylock_bh(spinlock_t *lock);
 extern int rt_spin_trylock(spinlock_t *lock);
@@ -132,7 +132,7 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 #define spin_trylock_irq(lock)				\
 	__cond_lock(lock, rt_spin_trylock(lock))
 
-#define __spin_trylock_irqsave(lock, flags)		\
+#define spin_trylock_irqsave(lock, flags)		\
 ({							\
 	int __locked;					\
 							\
@@ -142,9 +142,6 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 	__locked;					\
 })
 
-#define spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
-
 #define spin_is_contended(lock)		(((void)(lock), 0))
 
 static inline int spin_is_locked(spinlock_t *lock)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc03..e389078bddecb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1601,6 +1601,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
 					   struct rt_mutex_waiter *waiter)
+	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	struct task_struct *owner;
@@ -1804,6 +1805,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
  * @lock:	The underlying RT mutex
  */
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
+	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex_waiter waiter;
 	struct task_struct *owner;
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 38e292454fccb..d1cf8b2b6dcac 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -51,7 +51,7 @@ static __always_inline void __rt_spin_lock(spinlock_t *lock)
 	migrate_disable();
 }
 
-void __sched rt_spin_lock(spinlock_t *lock)
+void __sched rt_spin_lock(spinlock_t *lock) __acquires(RCU)
 {
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	__rt_spin_lock(lock);
@@ -75,7 +75,7 @@ void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
 EXPORT_SYMBOL(rt_spin_lock_nest_lock);
 #endif
 
-void __sched rt_spin_unlock(spinlock_t *lock)
+void __sched rt_spin_unlock(spinlock_t *lock) __releases(RCU)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
@@ -225,7 +225,7 @@ int __sched rt_write_trylock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_trylock);
 
-void __sched rt_read_lock(rwlock_t *rwlock)
+void __sched rt_read_lock(rwlock_t *rwlock) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
@@ -235,7 +235,7 @@ void __sched rt_read_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_lock);
 
-void __sched rt_write_lock(rwlock_t *rwlock)
+void __sched rt_write_lock(rwlock_t *rwlock) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
@@ -246,7 +246,7 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 EXPORT_SYMBOL(rt_write_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
+void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
@@ -257,7 +257,7 @@ void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
 EXPORT_SYMBOL(rt_write_lock_nested);
 #endif
 
-void __sched rt_read_unlock(rwlock_t *rwlock)
+void __sched rt_read_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
@@ -266,7 +266,7 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
-void __sched rt_write_unlock(rwlock_t *rwlock)
+void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	rcu_read_unlock();
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index fd78166a2ebe6..1f01857032cfa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1351,11 +1351,13 @@ static void hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base)
 }
 
 static void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base)
+	__acquires(&base->softirq_expiry_lock)
 {
 	spin_lock(&base->softirq_expiry_lock);
 }
 
 static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
+	__releases(&base->softirq_expiry_lock)
 {
 	spin_unlock(&base->softirq_expiry_lock);
 }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dcdce80a40cc5..48ba3ae1df8e9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1561,6 +1561,8 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
  * the waiter to acquire the lock and make progress.
  */
 static void timer_sync_wait_running(struct timer_base *base)
+	__releases(&base->lock) __releases(&base->expiry_lock)
+	__acquires(&base->expiry_lock) __acquires(&base->lock)
 {
 	bool need_preempt;
 
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
