Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DA1ADC89;
	Mon, 10 Feb 2025 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170613; cv=none; b=VxHtG4Ihv9gLgGILVYfPMWCxO63Xk6visM4kRz0c2Kr1NT6m2k3lMROZ2B55dDVE8Rgbz+52KY3KYOFW2Z7vJSZORxM0u4KWsTn8qW9Q/tNpFaWDya04aBYtx9BFQd7pJb/Yw9C5qKbdZd9gaq5//WJ4qeZ9AiSoLpsGZbinjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170613; c=relaxed/simple;
	bh=SP2mNCJCWYP+Y8goXQCeNQj3FziYLaCpbQI4pkMOXBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Iz8rbLJT5nhTR+QxGUPkbjLRhswazOgZABTx4HVmBew1OWNMHEqlJjXjg+znIMYY6L9CO5jzsLpzT4qXq6k07a9ABU0qv6B7R1BWDu2I07LaAajOTQO6RmLXbgCg1ySVgCJjMdiuV2cOShEefojWAu7CdJ3+wKGlAzycarSKUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=FB4WGqTG; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="FB4WGqTG"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=SP2mN
	CJCWYP+Y8goXQCeNQj3FziYLaCpbQI4pkMOXBI=;b=FB4WGqTGxABJX41b7PK+dmsKpIBRvW+6Kzj
	99ixaMXem2disaIHMGI9isPF5p9TwTCFV6TeqCFDwrV2hOY6ST0d8fkktEzL6LzmP24Nd0wv/1kTJ
	KS/Gq6o6uWP4b1kEjowRhhllOPtcNBMZ3IwHBU8lWWXA1avtrYr1jieMD2cnvW7HFCpV43+tV+1O8
	ZZhSZKqNhnN1VVAzasqwhbBGlArKDE+TEHFFmLsGo/fSvPCimugl83pThVxhYLCvTFuocCju8O1KN
	078Muj6az4Ed1UbZJKf7OusByAabtqPQDE7WendcBs/4qBJCRJFmDF2CQP5TQpoBN85ffo5UiZYw=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51A6uAe23587313; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2rWhqikycnTS8B6ZlP
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhqikycnTS8B6ZlP; m=Pln8YCdW3FRyGMFqByHrpv+NATtDA2H3XU8IdDMV1k0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 51A6u8RL859203
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 16/17] sched/core: Enable might_sleep() and smp_processor_id() checks early
Date: Mon, 10 Feb 2025 15:55:44 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-17-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 1c3c5eab171590f86edd8d31389d61dd1efe3037 upstream.

might_sleep() and smp_processor_id() checks are enabled after the boot
process is done. That hides bugs in the SMP bringup and driver
initialization code.

Enable it right when the scheduler starts working, i.e. when init task and
kthreadd have been created and right before the idle task enables
preemption.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184736.272225698@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 init/main.c            | 10 ++++++++++
 kernel/sched/core.c    |  4 +++-
 lib/smp_processor_id.c |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 6c745aff6669..0db97f4e2090 100644
--- a/init/main.c
+++ b/init/main.c
@@ -412,6 +412,16 @@ static noinline void __init_refok rest_init(void)
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
+
+	/*
+	 * Enable might_sleep() and smp_processor_id() checks.
+	 * They cannot be enabled earlier because with CONFIG_PRREMPT=y
+	 * kernel_thread() would trigger might_sleep() splats. With
+	 * CONFIG_PREEMPT_VOLUNTARY=y the init task might have scheduled
+	 * already, but it's stuck on the kthreadd_done completion.
+	 */
+	system_state = SYSTEM_SCHEDULING;
+
 	complete(&kthreadd_done);
 
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3e7d115d93d..d8dd1408943c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7966,8 +7966,10 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	rcu_sleep_check(); /* WARN_ON_ONCE() by default, no rate limit reqd. */
 	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
 	     !is_idle_task(current)) ||
-	    system_state != SYSTEM_RUNNING || oops_in_progress)
+	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
+	    oops_in_progress)
 		return;
+
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 		return;
 	prev_jiffy = jiffies;
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 11fa431046a8..3fc9a5b0ce48 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -28,7 +28,7 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
 	/*
 	 * It is valid to assume CPU-locality during early bootup:
 	 */
-	if (system_state != SYSTEM_RUNNING)
+	if (system_state < SYSTEM_SCHEDULING)
 		goto out;
 
 	/*
-- 
2.30.2


