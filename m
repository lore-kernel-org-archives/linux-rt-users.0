Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1101AC88B;
	Mon, 10 Feb 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170612; cv=none; b=Z73E7odQbbfs8rB81RnuhVCwvzBqx4TyLA65tmQggRkILT+K1PadNfJQ0d4QEB1rWBOwosDAxv/JOvyAbKVU9OzBOh/DdGvizfQ+mWRcprJArTfGRMd7TEzn5y+n221wsLjHlSTEg1TcU3qQTLNfNcUx/t/IlsAVm/SZoPT5MO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170612; c=relaxed/simple;
	bh=iicbccpumPzfEtugq4KWFjKgGvcPopR7aKnNXGjxNaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=grLDBYJ+ijK6p2xnmQQQRTclpuuDd0O/e/2sPhfQsuraHHZykJ6UyBr0SBtYB22fk0J+RzBRUBPoPUJdByAAbJa4GuNvJVDGA/LlQhPzUYo38YfXPfa/bD3kQBqJYQFiEnyOypYOtdwpAPXnvgcRFL85p3nSF3f+8DHMYB/sQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=cvLCK5SE; arc=none smtp.client-ip=210.130.202.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="cvLCK5SE"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170570;x=1740380170;bh=iicbc
	cpumPzfEtugq4KWFjKgGvcPopR7aKnNXGjxNaM=;b=cvLCK5SEcKFcT2zmpcCOFiLW8YlO8Fg89xg
	ZJC+t51t22hZnqBNG1jW6+UTppHDggRJH10vC3i3cDqXLiHOe2OUJa0R1G4QGRILzZMKdgsRL/Ujt
	6dCyfDwiwUsrgHFheHphRJx/JExLuMHkmBczMrfiOQC1Ci0tAr4wTom0n5Z/idKNVLGgXWmNT5Rri
	5nOsdW6SlCh7fabP1DhzSDxLSFswt5wRmNHmzE3afZwzzIHx2FqfbIE1R3g22yHrIWePcSbkFnA3i
	SrZ/xmxXZPY7+CeVd1l8X4YAjC7v8YgSiGu/jenRcwSQqjDbAFvCUmDvvmxr+ujjZSMHxigvPzrA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51A6uAU93387600; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2yAbpfLvFIKSbpKASa
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbpfLvFIKSbpKASa; m=gkZYdlsGvJB53wDsPFGToGjNwGtZeOMly87cM8gSnsc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 51A6u6864036119
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:06 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 01/17] init: Pin init task to the boot CPU, initially
Date: Mon, 10 Feb 2025 15:55:29 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-2-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 8fb12156b8db61af3d49f3e5e104568494581d1f upstream.

Some of the boot code in init_kernel_freeable() which runs before SMP
bringup assumes (rightfully) that it runs on the boot CPU and therefore can
use smp_processor_id() in preemptible context.

That works so far because the smp_processor_id() check starts to be
effective after smp bringup. That's just wrong. Starting with SMP bringup
and the ability to move threads around, smp_processor_id() in preemptible
context is broken.

Aside of that it does not make sense to allow init to run on all CPUs
before sched_smp_init() has been run.

Pin the init to the boot CPU so the existing code can continue to use
smp_processor_id() without triggering the checks when the enabling of those
checks starts earlier.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184734.943149935@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 init/main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index 9933fca3a5c8..6c745aff6669 100644
--- a/init/main.c
+++ b/init/main.c
@@ -386,6 +386,7 @@ static __initdata DECLARE_COMPLETION(kthreadd_done);
 
 static noinline void __init_refok rest_init(void)
 {
+	struct task_struct *tsk;
 	int pid;
 
 	rcu_scheduler_starting();
@@ -395,7 +396,17 @@ static noinline void __init_refok rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	kernel_thread(kernel_init, NULL, CLONE_FS);
+	pid = kernel_thread(kernel_init, NULL, CLONE_FS);
+	/*
+	 * Pin init on the boot CPU. Task migration is not properly working
+	 * until sched_init_smp() has been run. It will set the allowed
+	 * CPUs for init to the non isolated CPUs.
+	 */
+	rcu_read_lock();
+	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
+	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
+	rcu_read_unlock();
+
 	numa_default_policy();
 	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
 	rcu_read_lock();
@@ -993,10 +1004,6 @@ static noinline void __init kernel_init_freeable(void)
 	 * init can allocate pages on any node
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
-	/*
-	 * init can run on any cpu.
-	 */
-	set_cpus_allowed_ptr(current, cpu_all_mask);
 
 	cad_pid = get_pid(task_pid(current));
 
-- 
2.30.2


