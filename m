Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B52F9C3F
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898260; cv=none; b=qu8ieBLo8fsifYBQkT5f3WntDpe/lzcIiSIdEgIxiPeAHgeJzxUdQODSwDK4LWsGS0rM9UBx3K2aSbpbTViMnYJPhXi+OnXyZCCGOqP3V1LVl7PMTE1Da3oG4ZUiRiolO/B7QKmbJQsB1kQDgTkLrpAZyJ+Ztu2AgTos3SeJ2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898260; c=relaxed/simple;
	bh=X2XIMwhYaB0ah6fOHVJoyGQJI5CluMxg3NdI9Q+81YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGCE2BVHR0+s/JWZ/80cVPRIrWM49COhNSX18hRyaG3gDagTUVR73L36eV81MEbEburyUE1aV6QSdYZyYtwQQQaJ368WWm8+t2U5LvtjudD3+qfSLPnGaafr/uC1xb8EFltYXsFK6KCqwzanHDB6L8fFXss6SWxUkmev6Wl0+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nszGRVw+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GymDIJJP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nszGRVw+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GymDIJJP"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Uh+DVF3uGHMCSF211+h1UJh785nINeva/S3SK2080Q=;
	b=nszGRVw+YIM/LStjLKdfhWlpJLxS8UNv5vfmtn5zwghLAqXECWLn7YGtVRHt6uMRR7V/wW
	qsoI5l5cQ1LW6ylht1U4o5cZJJRhPQ2jledYAZ/c7oIL1raBhY94LopfezqtuOTNSKjW7b
	r3//Q23mtGfwTnczOWRFsX3EPlvI5JKjy1avgQjY8e0uB9IcW4lVOc+NJfGGcp/v6gs4zq
	mqUuLvmvXZiG9gI6gKo1SkU4AzCfNo8bSW5o8wSd4upk8SoAa6SF4pzT8snq1wHaUqdQJZ
	vJAcavC4lh7ct6D718CI6z9z2MoPK6Ps7D6v+vVhEXFq8/LYZPahfCk80QiMpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Uh+DVF3uGHMCSF211+h1UJh785nINeva/S3SK2080Q=;
	b=GymDIJJPrDfr2xy3WJjqkbuO2WVnMNwJXmGScnUGY74erQ9tCikWSBR9j57+ur4WcYjgV7
	gForYBE8RWN97PDg==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/10] rt-utils: Decouple writting trace-marks with trace stopping
Date: Wed,  3 Sep 2025 13:17:14 +0200
Message-ID: <20250903111717.1391196-8-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Most users write a trace mark and expect that the trace stops afterwads.
Decoupling writting and stopping the trace so it can be used in context
where trace stopping is not needed.

Make tracemark() writting just to the tracemark file.
Add tracing_stop() which stops tracing and let current users of
tracemark() use it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c         | 1 +
 src/include/rt-utils.h              | 1 +
 src/lib/rt-utils.c                  | 8 ++++++--
 src/oslat/oslat.c                   | 1 +
 src/sched_deadline/cyclicdeadline.c | 1 +
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 890da5d869c92..b4bce8915b432 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -852,6 +852,7 @@ static void *timerthread(void *param)
 				break_thread_id =3D stat->tid;
 				tracemark("hit latency threshold (%llu > %d)",
 					  (unsigned long long) diff, tracelimit);
+				tracing_stop();
 				break_thread_value =3D diff;
 			}
 			pthread_mutex_unlock(&break_thread_id_lock);
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 569023c5d3051..e148dd77fd7d8 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -31,6 +31,7 @@ int parse_mem_string(char *str, uint64_t *val);
=20
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void tracing_stop(void);
 void disable_trace_mark(void);
=20
 #define MSEC_PER_SEC		1000
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 294fc9683a122..e504b17738411 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -427,7 +427,7 @@ void tracemark(char *fmt, ...)
=20
 	/* bail out if we're not tracing */
 	/* or if the kernel doesn't support trace_mark */
-	if (tracemark_fd < 0 || trace_fd < 0)
+	if (tracemark_fd < 0)
 		return;
=20
 	va_start(ap, fmt);
@@ -436,8 +436,12 @@ void tracemark(char *fmt, ...)
=20
 	/* write the tracemark message */
 	write(tracemark_fd, tracebuf, len);
+}
=20
-	/* now stop any trace */
+void tracing_stop(void)
+{
+	if (trace_fd < 0)
+		return;
 	write(trace_fd, "0\n", 2);
 }
=20
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 9e5a08a2fbd92..4291221dc6521 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -340,6 +340,7 @@ static void insert_bucket(struct thread *t, stamp_t val=
ue)
 		char *line =3D "%s: Trace threshold (%d us) triggered on cpu %d with %.*=
f us!\n";
 		tracemark(line, g.app_name, g.trace_threshold, t->core_i,
 			  g.precision, us);
+		tracing_stop();
 		err_quit(line, g.app_name, g.trace_threshold, t->core_i,
 			 g.precision, us);
 	}
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cycli=
cdeadline.c
index 04e61edc68d83..e2f827deb275a 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -885,6 +885,7 @@ void *run_deadline(void *data)
 				break_thread_value =3D stat->max;
 				tracemark("hit latency threshold (%lld > %d)",
 						 (unsigned long long) stat->max, tracelimit);
+				tracing_stop();
 			}
 			pthread_mutex_unlock(&break_thread_id_lock);
 			break;
--=20
2.51.0

