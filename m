Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA06200CB;
	Tue,  4 Feb 2025 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636708; cv=none; b=Zt5KVm974mPynKWAWZcU1cl0VeIY63oOTXpO/naw5OoMAqZ0gQ87l1dBHlb9BUVsLBzfZDTRld3pJiBq5r9Pau1y21/yfYnYYcMa/R9+NPEuIBZvg5iFyMt7XNT4Do88CA8VFkWFzCvHGKyaHB6/N8ryyYVhzs2yjQ399peXwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636708; c=relaxed/simple;
	bh=BfVd1Kr9aFB9e0q+IARJRTODnRHHsOmAQ5YFSacC2G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kg3lXr3yQk8JtF5Kd7plTDrfm3DaKUVgd9Hz1l0DUEsAq7dVbPI7FJikhukfUHqa/CyC7tAYe9r0SEHqqeit123op0l8S9lMajIysGWl878Xs21j2zFJiiy0sjz4HK0vPNv3SZPyT2g7NQ+FWwZHSFwdYb/UP33F+bulrWpbqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=SWgqRXJ3; arc=none smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="SWgqRXJ3"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 5140mQNI2258601; Tue, 4 Feb 2025 09:48:26 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1738630063;x=1739839663;bh=BfVd1
	Kr9aFB9e0q+IARJRTODnRHHsOmAQ5YFSacC2G0=;b=SWgqRXJ3uTOLrBAh28J+gSmKI0DAktFH0Pm
	UdQ+pcOeM+4773MwLjE7ohwmlm4pP1dLb4e0uYDmEpWZw/QwLxZPeLSzh9qSjVrvBUtdJ0hw273wo
	efYqULSohcGFolLxRofW6YHK+EDaUB3P6AcL5TOSrnGxDaZRtMQHvpP92+RyKh+AGgGS7WMj8f5r0
	gBhEghoizKQcJ8Jf5mvHoi7TNPQamEj3wlpT5l5HUFACrps8YkmKxVNYgYyCkaSLfvKqzZRMvq10x
	6X+Mmp9dMeCuYEMyLo5ClRE479he3tDxc+BYxjKDGvmjUopT8tSpkBcygkmCXSbfy8U0r4CwYd+Q=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5140lg8D1755166; Tue, 4 Feb 2025 09:47:42 +0900
X-Iguazu-Qid: 2yAbAvUQLBamBJJ4Jf
X-Iguazu-QSIG: v=2; s=0; t=1738630062; q=2yAbAvUQLBamBJJ4Jf; m=EYnyDhiFJwSiMT7AaAO/x4s1cYkkAhXV1xRMnXaGgyM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5140leal1589797
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:47:40 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 4.9 v1 1/2] init: Introduce system_scheduling flag for allocate_slab()
Date: Tue,  4 Feb 2025 09:46:03 +0900
X-TSB-HOP2: ON
Message-Id: <1738629964-11977-2-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Between v4.14-rt and v5.10-rt, allocate_slab() is responsible for enabling
IRQ before running the following SLAB allocation functions if
    system_state >= SYSTEM_SCHEDULING
However, SYSTEM_SCHEDULING is introduced[1] in the mainline v4.13 and
it's not reasonable to backport all related changes into older RT kernels
from functional compatibility and longer term maintenance perspectives.

Thus, as an alternative (but non-mainline) way, introduce an extra flag
"system_scheduling" which becomes true at the same point as
    system_state = SYSTEM_SCHEDULING
in the mainline, so that the existing system_states and users of them
are not affected.

allocate_slab() will use this flag for its IRQ control by the upcoming change.

[1] https://lore.kernel.org/all/20170516184231.564888231@linutronix.de/

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 include/linux/kernel.h |  1 +
 init/main.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d68f639f7330..2a15e829aaec 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -490,6 +490,7 @@ extern enum system_states {
 	SYSTEM_RESTART,
 	SYSTEM_SUSPEND,
 } system_state;
+extern bool system_scheduling;
 
 #define TAINT_PROPRIETARY_MODULE	0
 #define TAINT_FORCED_MODULE		1
diff --git a/init/main.c b/init/main.c
index 9933fca3a5c8..4f382179b61e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -110,6 +110,14 @@ bool early_boot_irqs_disabled __read_mostly;
 enum system_states system_state __read_mostly;
 EXPORT_SYMBOL(system_state);
 
+/*
+ * This corresponds to system_state >= SYSTEM_SCHEDULING in the mainline.
+ * On PREEMPT_RT kernels, slab allocator requires this state to check if
+ * the allocation must be run with IRQ enabled or not.
+ */
+bool system_scheduling __read_mostly = false;
+EXPORT_SYMBOL(system_scheduling);
+
 /*
  * Boot command-line arguments
  */
@@ -401,6 +409,10 @@ static noinline void __init_refok rest_init(void)
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
+
+	/* Corresponds to system_state = SYSTEM_SCHEDULING in the mainline */
+	system_scheduling = true;
+
 	complete(&kthreadd_done);
 
 	/*
-- 
2.30.2


