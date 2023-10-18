Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E161EB21
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eqzGqdhc"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73A130;
	Wed, 18 Oct 2023 12:48:53 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AAB4C41278;
	Wed, 18 Oct 2023 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697658528;
	bh=SD/1DSd8LkUD/zRpHE/Lx7nVsJxLLRJldAx76/Ewjto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=eqzGqdhcMKkEsGGZrnIdDr4IRYpseCFXUwUeaxfkv3BDuhXLVq/8uqRDeo5jQM6qv
	 VkMaNlBHQ121JFDJw1UODaexmYsTKTA/hI8ihgT2PLuFzMjTxmEYXpMDNNCkzksL9X
	 rgFpiSMYFdC6BmbJ1zR+6LC1UWONgcszBUHO1KmRonLsWLOQqQks9PdvPSOD98Lkev
	 W7yr8XxezPCmMn1svc1b/M5GDFgTLyrJz+sH5CKFWq3OvfJAxLeyFSVhlubUqr2fdd
	 3xIjzE6XhBvF0q7IbYnTlsoJg5fR1/hzIyN+R9GA/ikzx4QdA2TeftCRE0n3F3/amB
	 6XOhOzwec5Jng==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT 06/12] sched: avoid false lockdep splat in put_task_struct()
Date: Wed, 18 Oct 2023 15:48:27 -0400
Message-Id: <20231018194833.651674-7-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wander Lairson Costa <wander@redhat.com>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


In put_task_struct(), a spin_lock is indirectly acquired under the kernel
stock. When running the kernel in real-time (RT) configuration, the
operation is dispatched to a preemptible context call to ensure
guaranteed preemption. However, if PROVE_RAW_LOCK_NESTING is enabled
and __put_task_struct() is called while holding a raw_spinlock, lockdep
incorrectly reports an "Invalid lock context" in the stock kernel.

This false splat occurs because lockdep is unaware of the different
route taken under RT. To address this issue, override the inner wait
type to prevent the false lockdep splat.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230614122323.37957-3-wander@redhat.com
(cherry picked from commit 893cdaaa3977be6afb3a7f756fbfd7be83f68d8c)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 include/linux/sched/task.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0c2d00809915..75d52a9e7620 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -115,6 +115,19 @@ static inline void put_task_struct(struct task_struct *t)
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
+	/*
+	 * In !RT, it is always safe to call __put_task_struct().
+	 * Under RT, we can only call it in preemptible context.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
+
+		lock_map_acquire_try(&put_task_map);
+		__put_task_struct(t);
+		lock_map_release(&put_task_map);
+		return;
+	}
+
 	/*
 	 * under PREEMPT_RT, we can't call put_task_struct
 	 * in atomic context because it will indirectly
@@ -135,10 +148,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 * when it fails to fork a process. Therefore, there is no
 	 * way it can conflict with put_task_struct().
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
-		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
-	else
-		__put_task_struct(t);
+	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
 static inline void put_task_struct_many(struct task_struct *t, int nr)
-- 
2.34.1

