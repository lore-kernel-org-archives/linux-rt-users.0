Return-Path: <SRS0=ZzBC=DW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5041C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Oct 2020 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3905C22248
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Oct 2020 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UmypyCFu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqX8PnPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbgJOPev (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Oct 2020 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbgJOPev (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Oct 2020 11:34:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA14C061755;
        Thu, 15 Oct 2020 08:34:50 -0700 (PDT)
Date:   Thu, 15 Oct 2020 17:34:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602776089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KfNOB4OxNNyo90HqKvnnOhQqAAVanReJOwgZs4gaFZo=;
        b=UmypyCFu3AR2fECGeZjRjcz7UessWn9ZG5BeYxaqlGUfg3JRk1YTi8/plG4c/3LT+gCEyp
        rK6qH37o4EmrXZN/elstTlP4Xd8gtqr9PO+Eu7jd53LxiDCNzbsIQkRfb0v2BU0lSUGGMu
        FFBN10vdWs3k8fT44n2wAJ+athKZ2InSfgrklIvC6NyhcfHH7dxNKsp2tMd+BNSPimVAkK
        vDfhfFes5ypXNatqvk9ue8DgMYgSLx6RwAhnloTHWavW7d0bu/QI+eOKHXhimAAM6zeW0n
        0LFCK0BDRWHldggEwYqzRW3tb8nPU1Vs2Zb9YFmXTGMhntvS7M7wZQs36Hi3hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602776089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KfNOB4OxNNyo90HqKvnnOhQqAAVanReJOwgZs4gaFZo=;
        b=AqX8PnPckq3GHrQkM111Efj0gmdGRLxGrg+imPzncucgQnqIDTzXwYA2pnwRqBKIj+I+XS
        79eNhi+N3RLpvACA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rt16
Message-ID: <20201015153447.5nzzwc54e3o2rzib@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rt16 patch set. 

Changes since v5.9-rt15:

  - The rtmutex rework resulted in "unused variable" warnings if built
    without lockdep. Reported by Mike Galbraith.

  - The softirq rework led to a warning which could be triggered by the
    `ss' tool. Reported by Mike Galbraith.

  - The migrate-disable rework removed a data from a trace-event. Adding
    it bad resulted in a compile failure for !RT. Patch by Clark
    Williams.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rt16

The RT patch against v5.9 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rt16.tar.xz

Sebastian

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index ac2be04c59fa7..3085132eae383 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -69,10 +69,10 @@ extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 		rt_spin_lock_nested(lock, subclass);	\
 	} while (0)
 
-# define spin_lock_nest_lock(lock, nest_lock)		\
+# define spin_lock_nest_lock(lock, subclass)		\
 	do {                                                           \
-		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
-		rt_spin_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+		typecheck(struct lockdep_map *, &(subclass)->dep_map);	\
+		rt_spin_lock_nest_lock(lock, &(subclass)->dep_map);	\
 	} while (0)
 
 # define spin_lock_irqsave_nested(lock, flags, subclass) \
@@ -82,15 +82,15 @@ extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 		rt_spin_lock_nested(lock, subclass);	 \
 	} while (0)
 #else
-# define spin_lock_nested(lock, subclass)	spin_lock(lock)
-# define spin_lock_nest_lock(lock, nest_lock)	spin_lock(lock)
-# define spin_lock_bh_nested(lock, subclass)	spin_lock_bh(lock)
+# define spin_lock_nested(lock, subclass)	spin_lock(((void)(subclass), (lock)))
+# define spin_lock_nest_lock(lock, subclass)	spin_lock(((void)(subclass), (lock)))
+# define spin_lock_bh_nested(lock, subclass)	spin_lock_bh(((void)(subclass), (lock)))
 
 # define spin_lock_irqsave_nested(lock, flags, subclass) \
 	do {						 \
 		typecheck(unsigned long, flags);	 \
 		flags = 0;				 \
-		spin_lock(lock);			 \
+		spin_lock(((void)(subclass), (lock)));	 \
 	} while (0)
 #endif
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index aa7f3bef6d4fa..21706f318a001 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2437,6 +2437,15 @@ enum print_line_t trace_handle_return(struct trace_seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
 
+static unsigned short migration_disable_value(struct task_struct *tsk)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	return tsk ? tsk->migration_disabled : 0;
+#else
+	return 0;
+#endif
+}
+
 void
 tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
 			     unsigned long flags, int pc)
@@ -2460,7 +2469,7 @@ tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
 		(need_resched_lazy() ? TRACE_FLAG_NEED_RESCHED_LAZY : 0) |
 		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
 
-	entry->migrate_disable = (tsk) ? tsk->migration_disabled & 0xFF : 0;
+	entry->migrate_disable = migration_disable_value(tsk);
 }
 EXPORT_SYMBOL_GPL(tracing_generic_entry_update);
 
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d4..1199ebade17b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 239e54474b653..fcb105cbb5465 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -585,7 +585,9 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 	int err = 0;
 
 	if (sk->sk_state != TCP_LISTEN) {
+		local_bh_disable();
 		inet_ehash_nolisten(sk, osk);
+		local_bh_enable();
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
@@ -617,11 +619,8 @@ int inet_hash(struct sock *sk)
 {
 	int err = 0;
 
-	if (sk->sk_state != TCP_CLOSE) {
-		local_bh_disable();
+	if (sk->sk_state != TCP_CLOSE)
 		err = __inet_hash(sk, NULL);
-		local_bh_enable();
-	}
 
 	return err;
 }
@@ -632,17 +631,20 @@ void inet_unhash(struct sock *sk)
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
 	struct inet_listen_hashbucket *ilb = NULL;
 	spinlock_t *lock;
+	bool state_listen;
 
 	if (sk_unhashed(sk))
 		return;
 
 	if (sk->sk_state == TCP_LISTEN) {
+		state_listen = true;
 		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
-		lock = &ilb->lock;
+		spin_lock(&ilb->lock);
 	} else {
+		state_listen = false;
 		lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
+		spin_lock_bh(lock);
 	}
-	spin_lock_bh(lock);
 	if (sk_unhashed(sk))
 		goto unlock;
 
@@ -655,7 +657,10 @@ void inet_unhash(struct sock *sk)
 	__sk_nulls_del_node_init_rcu(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 unlock:
-	spin_unlock_bh(lock);
+	if (state_listen)
+		spin_unlock(&ilb->lock);
+	else
+		spin_unlock_bh(lock);
 }
 EXPORT_SYMBOL_GPL(inet_unhash);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 2d3add9e61162..50fd17cbf3ec7 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -335,11 +335,8 @@ int inet6_hash(struct sock *sk)
 {
 	int err = 0;
 
-	if (sk->sk_state != TCP_CLOSE) {
-		local_bh_disable();
+	if (sk->sk_state != TCP_CLOSE)
 		err = __inet_hash(sk, NULL);
-		local_bh_enable();
-	}
 
 	return err;
 }
