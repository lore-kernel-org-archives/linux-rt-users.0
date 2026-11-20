Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198815;
	b=H+YfQBwfnrSVP+TCHn13noyxKYXNCwMF033YeyDRiMJ/8vX0Vw2Pbo7b2DTLBRHPupaH
	 fToWqaxeBZcg5pJFUWN5sB735ay3GFhX+YSJ6N8E5E/DKwHDBSxxbh9hX71Qz3qSD0j7B
	 x9U7xEIqKiBDNLdtvM5zVtZrZmMxRDHCJi+PSAV8bOs/rjsxYOwS0wXQPQTHTadNiW6lh
	 v16kQeKWS32vguhYTBFWD1/TEEEK4AHIQDSiaxkAGYyApBuWvfubhk3c16x0HkqmURgv7
	 fmSeHoUzdjc08Df+3VfzPfn6S7Z+4/DPHc8e1ERedqFaNmHie1eJoyVYV/91NUzKMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YPedKILbu01eoY33ZLm37PxOMYs+jBP0a8L+1xgzvhk=;
	b=4EGgdljt/KPmm3aRPdsFxJYaCdcVgejeKTch68TU4bujAz96TO3jcEqrxg9mo6M+9KXj
	 4yxHe2f9udVd78Nk9va19VgqhXYMziCJw2YrRNw7gwYI/mt2wGTUeVM3jsWlnUE3LYnes
	 cGTUORItFTzgVfH3Xgje4TPCi6w72MfY5ptQ19a4MNQgMEn9q9WB9SLSNYp7XhTBtOeAA
	 6qQaI0aiRQNabFSZN+fH7tDwQXiLol4SFv9sWB7muD+6Bxs6V2tC7H2LxSq3TYV9k7v9F
	 769mMjABer4ZX2g22L59TWP198RerfJsJR0rQN6sh6TnU1MfJrT0/S6tMLmDNk4MnQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAtG2F7i;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A33606A894
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A33606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAtG2F7i
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so665220f8f.3
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198811; x=1795803611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPedKILbu01eoY33ZLm37PxOMYs+jBP0a8L+1xgzvhk=;
        b=TAtG2F7i8knZDS6lI+q/JHc/lqry777i0ApnZnw6o7PEMSyV2PtPZuHuzTtnQZGwBj
         WAXVWQJPp4lU6AWorMuCbOaoNeSd9mzCb+xV9OLgUXtXsU8Xi3Qmo3Bw+iGGpkucJ8BD
         LcJ7kBzbkH5SZhoOTLpPmjnjreqxT5cZR11ks6WVBQSojwsyDOOZjXvPVAlFLL/JOtNL
         XHc79wJAqKUhV0b8Exbfg61OBSYRx876D1g7RxG0LooIJXO4bxCdDIEwO50oioW19z1f
         7QpCglokUtVOOK4DBPEQLffpgFBTMTfagMTRmrjLUjsgm0VqjAMVe6lnHUelpM8yyZ1X
         B41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198811; x=1795803611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPedKILbu01eoY33ZLm37PxOMYs+jBP0a8L+1xgzvhk=;
        b=oWL7vp9YgVXNMY9O/ppcK2rgt8r3tsO0mqUVMPMbdUuy0bfQ56aJCAdimQjVIIfLG0
         C6c+oVkvTsl0JZGfrR/UMg0T7PsgF6j79fgu9X5W+++tdzNGUgxbP6JB+LypvyeaDoVv
         b2gTXEQYrcXQ6fFGKmUVggY6jInLEVANPlPY2qOBqvHEkWvBMaFTngdwe/wupAvxYWh8
         IgMC3a9nqEO8rvs855YVVSPXYMxNurknWuLOsc9tXc0wk8DCTWXJEqukHjgnQ0kBSQaW
         hBiYBnt+7/Df/rOWeAO4pYV6oCBs4ivbdlwBMBwrZZZc1dvsw7VfPRovNIJEmn00Vth1
         ld/Q==
X-Forwarded-Encrypted: i=1; AL+hErHwwFkEQqjZVoMxaQJmoKnuNDY4llHfvtPHrTg8t4XEM4v1QKR+RhcAxggkPAQPbEvUMVZ+qSl6KVreINr18w==@vger.kernel.org
X-Gm-Message-State: APuU4Z81TKOuaz7MfM33XR67gAZ9vlixBUzTtrwxjZvwQK8tI0nZMNvH
	58p68EynnWBBBFzTG0PqydTS+Py0UkpXdNFFSL+nJg+advsKD4oyapCFsBOQGg==
X-Gm-Gg: AYBFou1sF9w2hF3CpslK3KRjt5l+rf7DCgawg7AQ/bK7W3JQv1nIoILQGY9d9ScawaN
	dTldouKkg1CMfxgpl+vuFPXT6byP1YJyUZt4Vk4b4LH6kvy2Da/PKM/rV9qwmgz3ofmktZaqztX
	yA40CiGsCeEDhbm6a7qumYid7btY9kAnI4xK7r0SMalYynCp+IBqPgUaGZyc/d6Le22OcWL0yWA
	nohYyA4X3nFMjVUiyt8N9lPIw2Cflncz5VhrJrbYDX5xZuWG8K4oKM81UCP3aMJ/8UukPfWpTid
	IxQae7mAeebV6LTFTXYdLg1Lty+zLd0sKI1kJAL0778drdR7PhlwEUtpxqKpjVtxbQTJN4q3pWL
	kWCsr0f49tTB/is7071wNb1B/hiXZhiYVDJDy9eAIxsgabOPIPJVWU8ptAfBS4vTs7+m6N962/m
	L5YzMVXiGENTFnjByqaOV1ORiBBY1eEbaQBk3eRWY6XO5UjI8OYm01tAknVU+YtfLlqgAUzk+lH
	a2LSw1AmBDyFBCTrBxtJ9YmVjxodJ2OzpSg0QDQCGlQQafJ6jKsxDqSDrNwOfJIOBM1yqPN9rwi
	8waciBFnO746i4aWux8QdSRr1zSObtvuyu5cWbxcPruoCQwsPWI3Vl7I8NHXJmgd+ki+t3D7/ay
	SpcJOBvglLBMshyddFrQfG8S0RA==
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb887c2cb0mr98732575e9.2.1795198810472;
        Fri, 20 Nov 2026 10:20:10 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:10 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 1/4] sched/deadline: Fix dl_server time accounting
Date: Fri, 20 Nov 2026 19:19:46 +0100
Message-Id: <20261120181949.7528-2-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261120181949.7528-1-fcarli@gmail.com>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
 <20261120181949.7528-1-fcarli@gmail.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

commit e636ffb9e31b4f7dde7fef5358669266b9ce02ec upstream.

The dl_server time accounting code is a little odd. The normal scheduler
pattern is to update curr before doing something, such that the old state is
fully accounted before changing state.

Notably, the dl_server_timer() needs to propagate the current time accounting
since the current task could be ran by dl_server and thus this can affect
dl_se->runtime. Similarly for dl_server_start().

And since the (deferred) dl_server wants idle time accounted, rework
sched_idle_class time accounting to be more like all the others.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251020141130.GJ3245006@noisy.programming.kicks-ass.net
[ Florent: rq->donor does not exist in 6.12, use rq->curr ]
Signed-off-by: Florent Carli <fcarli@gmail.com>
---
 kernel/sched/deadline.c | 40 +++++++++++++++-------------------------
 kernel/sched/fair.c     |  9 ++-------
 kernel/sched/idle.c     | 16 +++++++++++++++-
 kernel/sched/sched.h    |  3 +--
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f5c64d1a0..2e3bd43af 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1216,8 +1216,12 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		sched_clock_tick();
 		update_rq_clock(rq);
 
-		if (!dl_se->dl_runtime)
-			return HRTIMER_NORESTART;
+		/*
+		 * Make sure current has propagated its pending runtime into
+		 * any relevant server through calling dl_server_update() and
+		 * friends.
+		 */
+		rq->curr->sched_class->update_curr(rq);
 
 		if (dl_se->dl_defer_armed) {
 			/*
@@ -1594,35 +1598,16 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	s64 delta_exec;
-
-	if (!rq->fair_server.dl_defer)
-		return;
-
-	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
-		return;
-
-	delta_exec = rq_clock_task(rq) - p->se.exec_start;
-	if (delta_exec < 0)
-		return;
-
-	rq->fair_server.runtime -= delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
-	}
-
-	p->se.exec_start = rq_clock_task(rq);
+	if (dl_se->dl_server_active && dl_se->dl_runtime && dl_se->dl_defer)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime)
+	if (dl_se->dl_server_active && dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
@@ -1849,6 +1834,11 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime || dl_se->dl_server_active)
 		return;
 
+	/*
+	 * Update the current task to 'now'.
+	 */
+	rq->curr->sched_class->update_curr(rq);
+
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 020a39fe0..7e5179189 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1259,8 +1259,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
-			dl_server_update(&rq->fair_server, delta_exec);
+		dl_server_update(&rq->fair_server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
@@ -7114,12 +7113,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
-		/* Account for idle runtime */
-		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
-	}
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1f0f0d9a5..a2ab252e7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -471,9 +471,11 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 	resched_curr(rq);
 }
 
+static void update_curr_idle(struct rq *rq);
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	update_curr_idle(rq);
 	scx_update_idle(rq, false, true);
 }
 
@@ -521,6 +523,7 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
  */
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 {
+	update_curr_idle(rq);
 }
 
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
@@ -536,6 +539,17 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
 
 static void update_curr_idle(struct rq *rq)
 {
+	struct sched_entity *se = &rq->idle->se;
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
+
+	delta_exec = now - se->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	se->exec_start = now;
+
+	dl_server_update_idle(&rq->fair_server, delta_exec);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5e788dc39..598dd26fe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -411,14 +411,13 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  * naturally thottled to once per period, avoiding high context switch
  * workloads from spamming the hrtimer program/cancel paths.
  */
+extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task);
 
-extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.39.3 (Apple Git-146)

