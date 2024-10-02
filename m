Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4111CFECF;
	Wed,  2 Oct 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877294; cv=none; b=S6UDjghF2cFxOrZtF1uIoiARnmRW8pg9Q1ZJfdz3aAiYRSTMDaIPcQlP3OmSn+Uc5Jlbko/YAfXBvKaYyyitSmWcH9pYc+AUvssseVPBlouMAKPlKZwh5JzH5A4ZXezO5kgdVfFynNgGi2tlUwLwyzudrOUjHfvUDn0VdSmLPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877294; c=relaxed/simple;
	bh=p+86IdibhIFZsKrZSp2jMDkkjfe2JM9IOm09HaA7KT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xx7lBSvI/am4dyxlMW90ZSS2KcfUD646KJVRosA7GbIIpG9MOiig/CZpqu6iC1LU+h6wx1Gi+Ny+uy7jgglZKZ/6fwlIsr1ztiUp9YFwnFBdNzr2b1BG4RGPdXW5ZlRchrRdycE2soF2Ha/qSp/5kO6R5Zemz6UcxXbX8Yz33r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ycOBieC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gelp1OPb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ycOBieC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gelp1OPb"
Date: Wed, 2 Oct 2024 15:54:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727877291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ruaSjWab27ygCxq06I2+xUxQndIEpVzW3ImLCRGdEOc=;
	b=0ycOBieCzLNRQyBCu5gsRE49gOWxlZbFeCfSnmzd9k9E1o2f5XmBi4iJKgR+AWkZk7nJtu
	d02FdhJoD0ZmfbKBWinhsN1ML6SR3PVW9zVE1iOgoIYodw0Kqm524m8qQhIfI8ohOV6VVf
	tEISJZF+jBIV5zB46ejLKGJIBaYnzfZGTVXxxezRACm88Jjikx570ZcRz7jMUdFBP/gzLD
	BXYw6j7yo92lpX6kpDfNb2lTBlVzHP8uidx2OoR1Xc6lE+2RevTsn2z5EFmLXK2mK44Dow
	i3WZOpXZQOr3VS/u2U5OcPJbDzzINVgsBb4/0q/9ae+Fuc3zmt2NjST2bnoAtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727877291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ruaSjWab27ygCxq06I2+xUxQndIEpVzW3ImLCRGdEOc=;
	b=Gelp1OPbfQve1yRKuZxcr2qFRij2Ctvl19rwRdHhcwnmnYxlNpX0jxLf/WwptIBq4gfA4D
	lvyTFQrUfGa/U4Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.12-rc1-rt2
Message-ID: <20241002135449.xUZX0zAj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.12-rc1-rt2 patch set. 

Changes since v6.12-rc1-rt1:

  - Drop the "don't push tasks for RT balancing if there are no tasks
    that can be pushed" patch introduced in v6.5-rc4-rt2. The situation
    improved since v6.7.

  - Drop the "Preempt the timer softirq if it is PI boosted" patch also
    introduced in v6.5-rc4-rt2. In covered only timer_list timers (not
    hrtimer). It would require more of this duct tape in more places.
    The longterm plan is to avoid having the BH lock.

Known issues
    None.

The delta patch against v6.12-rc1-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/incr/patch-6.12-rc1-rt1-rt2.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.12-rc1-rt2

The RT patch against v6.12-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12-rc1-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patches-6.12-rc1-rt2.tar.xz

Sebastian

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 448bbef474564..fc53e0ad56d90 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -35,10 +35,8 @@ static inline void local_bh_enable(void)
 
 #ifdef CONFIG_PREEMPT_RT
 extern bool local_bh_blocked(void);
-extern void softirq_preempt(void);
 #else
 static inline bool local_bh_blocked(void) { return false; }
-static inline void softirq_preempt(void) { }
 #endif
 
 #endif /* _LINUX_BH_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04dbfb7cda334..2016534bbc533 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1838,7 +1838,6 @@ static inline int dl_task_check_affinity(struct task_struct *p, const struct cpu
 }
 #endif
 
-extern bool task_is_pi_boosted(const struct task_struct *p);
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
 extern int task_prio(const struct task_struct *p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7af5c21c94a8..91d250a0e039b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7533,21 +7533,6 @@ static inline void preempt_dynamic_init(void) { }
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
-/*
- * task_is_pi_boosted - Check if task has been PI boosted.
- * @p:	Task to check.
- *
- * Return true if task is subject to priority inheritance.
- */
-bool task_is_pi_boosted(const struct task_struct *p)
-{
-	int prio = p->prio;
-
-	if (!rt_prio(prio))
-		return false;
-	return prio != p->normal_prio;
-}
-
 int io_schedule_prepare(void)
 {
 	int old_iowait = current->in_iowait;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a825cdc1f02b3..172c588de5427 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2176,11 +2176,8 @@ static int rto_next_cpu(struct root_domain *rd)
 
 		rd->rto_cpu = cpu;
 
-		if (cpu < nr_cpu_ids) {
-			if (!has_pushable_tasks(cpu_rq(cpu)))
-				continue;
+		if (cpu < nr_cpu_ids)
 			return cpu;
-		}
 
 		rd->rto_cpu = -1;
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c251f1bf75c5e..0052bd4d9ec1d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -248,19 +248,6 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-void softirq_preempt(void)
-{
-	if (WARN_ON_ONCE(!preemptible()))
-		return;
-
-	if (WARN_ON_ONCE(__this_cpu_read(softirq_ctrl.cnt) != SOFTIRQ_OFFSET))
-		return;
-
-	__local_bh_enable(SOFTIRQ_OFFSET, true);
-	/* preemption point */
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
-}
-
 /*
  * Invoked from ksoftirqd_run() outside of the interrupt disabled section
  * to acquire the per CPU local lock for reentrancy protection.
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index aef6ca700c991..79f0dc73ac436 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1564,16 +1564,9 @@ static void timer_sync_wait_running(struct timer_base *base)
 	__releases(&base->lock) __releases(&base->expiry_lock)
 	__acquires(&base->expiry_lock) __acquires(&base->lock)
 {
-	bool need_preempt;
-
-	need_preempt = task_is_pi_boosted(current);
-	if (need_preempt || atomic_read(&base->timer_waiters)) {
+	if (atomic_read(&base->timer_waiters)) {
 		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
-
-		if (need_preempt)
-			softirq_preempt();
-
 		spin_lock(&base->expiry_lock);
 		raw_spin_lock_irq(&base->lock);
 	}
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
