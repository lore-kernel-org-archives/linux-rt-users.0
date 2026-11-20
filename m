Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198818;
	b=gmjRiw350bbfdOHU1Y8t4Ge7cCqOenXK7xm4xnSEFWNtS3y5a/g4pkNMP+uqzeRZotlh
	 6nCx6jXcazrSdhVnQMn+pzks+CuLLcelRVAfB8dEPEfVx2E6pP+BQ4J1omL5O9mBNLw+R
	 n4qEZhIeKMWkqQ/EzwnB4T+GQpO9lRKNe+WZW68nXCrKZbtKKNVY80jzva1FB2uTMsIAc
	 TfSj1t4s1Hopg+H2YuuLJpC2RS74pQOebXD8EuiqrqnKblHwkw9GZ+h8tDydMG90jIQ4u
	 ajw4j4A+6gAbWf54CRz3TWDLEnPDEpQg3emtTGfLs3r6Hn58U56ideylTy1B8cdqyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MmNmKImiBN4Oi3ug85Mub5EmyOD096RpBgb0kIdYP6U=;
	b=ghPoFHEe87LSyGUMmanyXGE2FtgswkDEps0iNg0bjnVTtVe33dMmTB1Q/GX2QT44VWZR
	 dXec/cCqMHeODRSoOEhkyjSMMM2AzFmKz5ylFoeMHEDEyuZR7WwqYbSMY8PjZySKyj59g
	 6DBk2rHjgtjrG6EDjQmsYK2DLW35NDMFd4vE7eG4Lo5XmjyVIUDIC1kdqzURm2/l+BklC
	 A340OMXORzp8d5B3c8Lrc6Hw5UONV1TU4UoHBBfpV7wH44Uhyq+qAg5eOqfbCiqSZee1x
	 9RAkVufMc9WrC8d1xmdKzppLPPjkHLTT1TokTOygSQ3W2QBUi9t0svZgE8IRSL/dCcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CERWGJuq;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F75606A88C
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 18:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F75606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CERWGJuq
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so10419615e9.0
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198813; x=1795803613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmNmKImiBN4Oi3ug85Mub5EmyOD096RpBgb0kIdYP6U=;
        b=CERWGJuqIGnmoEBH2dKQ4/6OybmTkD4rWAianzx7Yc9EXEcdDgubIrCDgrAM89epgo
         97rIBTqEDkUEBG/9Y2jEH6/ls34onN/w//E505h+sV3gSg2XsGl8u65tjEb42AAOo3Gz
         5G8oj5m5PGhobh4K4AWybGQnkjkc9TaSmS6nTWG/J7ULon11tQB+uCfSoZFTK1D8B4Mx
         Qw4KlcyqvudcdzrQjElwegwDVraofCrAW/WVHLcHwquQRaMevsyBljYb3nGCJDgtGWNH
         T7xnWN6JiJ7vI8SGMEYrWH/mhmDsJhQs02LuW65VjtI9Jwzi7Arnv7M1eygECxn4WBss
         3h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198813; x=1795803613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmNmKImiBN4Oi3ug85Mub5EmyOD096RpBgb0kIdYP6U=;
        b=gNjTAxId2pdY9atG0hKGhO2K8jUBpsZSalqd3Xomjd4hZs9Fvus8Zn3kC5hzdlKHns
         eqRT4JDUGvzBGQ8bn41wDE7Fvz9kqz4bDHfVYA2Y6METxtqshZ28N6FCom5OfYBvSk8i
         J4mtaeOLBBQcF1fDLWBpfea32wDDKTATW3qs6i7A3i3L8wX3HUuKLQmy2k10IY8WPBSp
         YPCmHXD8YuEovLEWihrPhGygkS5+FQZx2QGUj9P0M+NxhNGaL1JGHis6rljR0UEd2niZ
         CuXEa6DOU7YtBKg27JoRlUQ/+dLRoq6oP+yiex9TNuAkxOi3cM671dse2FjlmRRDyZan
         uzKw==
X-Forwarded-Encrypted: i=1; AL+hErE7Qo3ofpSV5hVblFlIWrKiOA02S2lNJ6jm7f85rUF3dYo6lxjUAnghxhVhAZsk1u3X323VHdGNoz643pB/LQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hYMCILhtASW2sseV7z32+AYnZB9Z9/p5vqLk2mZfVdrM3SF3i
	tZgF62VHDef5N74+TkbZamcjyc+WvmEzPBzPR03C5C+uHmDIwLwoHvEY
X-Gm-Gg: AYBFou1Dd7KVVDAYhhGEEwM35phdUqA8yhwUQIXICBH+fGOqVCnnwypYI3fMQ5G9Zgx
	yjFozQI4N7e9yuygqZD74w0Kvm6UUnD3LPmZwqWWz11IJOxKCtdC6pebAUT8Oe87twLikvMTQh9
	qUpBGenNJjnPxeoq3UsHJL9q5By3vrS7eDRoaNXeiP8AghAC1gO4QI+1S+ZSd2TwkjuvkSZ2wJD
	aHpIzXoxH7+9DgdcdNYBHy0bpdZtgq/Tcuq67njZEGGe5lnIq5WO2LGbva7FmQRFObv+o7A7Bv/
	wWfyd8znYNmk808rXjqSr/MjO6G2fVRuAQHMW2l9r5ORKSZXKxszY/g3s7vxQV0LGfmpeY0jxZp
	fVL97hveDhA3iv1+rr4vUwxpV6zdnGedUesrTjZgAe27nhuIlCgolhpTohg+SzZeFSfqappNzph
	NM0/Ieni5xuPoRuyaEHJV1XU0GC+XGib9nVf7jFaD1vokyO9BgMUIUzOjJyocz8+9Q/P7ksuRbr
	13aQXkApD/nEQXIp0tP0PVJff8H9KVhDgaDrEC8ieGSmazYYwwTxFDLIz4/JzfSXxwHsmA6TdXL
	h5URLVBhsMQAk6nRX+z7Nv7n2NxYQx10tmFCwnH+XWZWce0Ap3urHMrLVOAR0XSFR3FgBau/neb
	hjILmRN0EyHWhdydeC32ZeblJYg==
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr87470115e9.7.1795198812449;
        Fri, 20 Nov 2026 10:20:12 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:11 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 2/4] sched/deadline: Fix dl_server stop condition
Date: Fri, 20 Nov 2026 19:19:47 +0100
Message-Id: <20261120181949.7528-3-fcarli@gmail.com>
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

commit f5a538c07df26f5c601e41f7b9c7ade3e1e75803 upstream.

Gabriel reported that the dl_server doesn't stop as expected.

The problem was found to be the fact that idle time and fair runtime are
treated equally. Both will count towards dl_server runtime and push the
activation forwards when it is in the zero-laxity wait state.

Notably:

  dl_server_update_idle()
    update_curr_dl_se()
      if (dl_defer && dl_throttled && dl_runtime_exceeded())
        hrtimer_try_to_cancel(); // stop timer
	replenish_dl_new_period()
	  deadline = now + dl_deadline; // fwd period
	  runtime = dl_runtime;
        start_dl_timer(); // restart timer

And while we do want idle time accounted towards the *current* activation of
the dl_server -- after all, a fair task could've ran if we had any -- we don't
necessarily want idle time to cause or push forward an activation.

Introduce dl_defer_idle to make this distinction. It will be set once idle time
pushed the activation forward, once set idle time will only be allowed to
consume any runtime but not push the activation. This will then cause
dl_server_timer() to fire, which will stop the dl_server.

Any non-idle time accounting during this phase will clear dl_defer_idle, so
only a full period of idle will cause the dl_server to stop.

Reported-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251101000057.GA2184199@noisy.programming.kicks-ass.net
Signed-off-by: Florent Carli <fcarli@gmail.com>
---
 include/linux/sched.h   | 15 +++++++++------
 kernel/sched/deadline.c | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c584a1f0..7f0fb62df 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -650,20 +650,22 @@ struct sched_dl_entity {
 	 *
 	 * @dl_server tells if this is a server entity.
 	 *
-	 * @dl_defer tells if this is a deferred or regular server. For
-	 * now only defer server exists.
-	 *
-	 * @dl_defer_armed tells if the deferrable server is waiting
-	 * for the replenishment timer to activate it.
-	 *
 	 * @dl_server_active tells if the dlserver is active(started).
 	 * dlserver is started on first cfs enqueue on an idle runqueue
 	 * and is stopped when a dequeue results in 0 cfs tasks on the
 	 * runqueue. In other words, dlserver is active only when cpu's
 	 * runqueue has atleast one cfs task.
 	 *
+	 * @dl_defer tells if this is a deferred or regular server. For
+	 * now only defer server exists.
+	 *
+	 * @dl_defer_armed tells if the deferrable server is waiting
+	 * for the replenishment timer to activate it.
+	 *
 	 * @dl_defer_running tells if the deferrable server is actually
 	 * running, skipping the defer phase.
+	 *
+	 * @dl_defer_idle tracks idle state
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
@@ -674,6 +676,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
+	unsigned int			dl_defer_idle     : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2e3bd43af..ea64ab436 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1223,6 +1223,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		 */
 		rq->curr->sched_class->update_curr(rq);
 
+		if (dl_se->dl_defer_idle) {
+			dl_server_stop(dl_se);
+			return HRTIMER_NORESTART;
+		}
+
 		if (dl_se->dl_defer_armed) {
 			/*
 			 * First check if the server could consume runtime in background.
@@ -1473,10 +1478,11 @@ s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta
 }
 
 static inline void
-update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-			int flags);
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se, int flags);
+
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
+	bool idle = rq->curr == rq->idle;
 	s64 scaled_delta_exec;
 
 	if (unlikely(delta_exec <= 0)) {
@@ -1497,6 +1503,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 	dl_se->runtime -= scaled_delta_exec;
 
+	if (dl_se->dl_defer_idle && !idle)
+		dl_se->dl_defer_idle = 0;
+
 	/*
 	 * The fair server can consume its runtime while throttled (not queued/
 	 * running as regular CFS).
@@ -1506,6 +1515,29 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * starting a new period, pushing the activation.
 	 */
 	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		/*
+		 * Non-servers would never get time accounted while throttled.
+		 */
+		WARN_ON_ONCE(!dl_server(dl_se));
+
+		/*
+		 * While the server is marked idle, do not push out the
+		 * activation further, instead wait for the period timer
+		 * to lapse and stop the server.
+		 */
+		if (dl_se->dl_defer_idle && idle) {
+			/*
+			 * The timer is at the zero-laxity point, this means
+			 * dl_server_stop() / dl_server_start() can happen
+			 * while now < deadline. This means update_dl_entity()
+			 * will not replenish. Additionally start_dl_timer()
+			 * will be set for 'deadline - runtime'. Negative
+			 * runtime will not do.
+			 */
+			dl_se->runtime = 0;
+			return;
+		}
+
 		/*
 		 * If the server was previously activated - the starving condition
 		 * took place, it this point it went away because the fair scheduler
@@ -1518,6 +1550,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 		replenish_dl_new_period(dl_se, dl_se->rq);
 
+		if (idle)
+			dl_se->dl_defer_idle = 1;
+
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
 		 * be started for whatever reason, we need to "unthrottle" the DL server
@@ -1857,6 +1892,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
 
-- 
2.39.3 (Apple Git-146)

