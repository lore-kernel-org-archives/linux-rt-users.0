Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C01ADC79;
	Mon, 10 Feb 2025 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170612; cv=none; b=Pbu/aBi9e5vCr3osy+ljKcgkzfSGMS+BEs6SKOxYh8AKIlez2RXOBlD5yHPMobQp6zJTzpFQmAPS4eaAUIcblpbie/L0vYtfxSIrFdFDKDsIaT3kK5hK48PP+io1/i5acQWZ/1IkcYqNRDK69/nWW8VDEUyMuRCL9729kjdCm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170612; c=relaxed/simple;
	bh=oPbhdi6X+NHmZoY+32TmyHl/HKc+x2mok1HvpyiYhAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HRCJcrdoNL7UOaX5h0eRkvzH2UgIXeVXNVWmdOOYtCyMG1qj2BUOfUbqKADdWZbj+Xv7bXRLOyZbA+Hy0xnRdmZCmTJh5UQfc5uPhg9qRZ09gfcKylkzOQBt2RsmvEttbbT9y9DpagtVJOIEwBd2Cvk0Ba+34erOocaw1U0n7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=bSzuvNKV; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="bSzuvNKV"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170576;x=1740380176;bh=oPbhd
	i6X+NHmZoY+32TmyHl/HKc+x2mok1HvpyiYhAw=;b=bSzuvNKVpX/9glXGFuZlm9UjDKHJTsUZm45
	XTfziGG7DzsMQ1QkYSjkSittyqoSxVE8iBraY0hPHfpyJ2W8k8ovYEx6GWz9xJHhl7lsnauTvsp7Y
	APC3lfhUIYPOVQgBsB8P18cHiQzs4FwxPw9m2gA5uAxXOstugM59eAvxIzjvTbGQl4bFo0ag8aHIh
	jWOj9PCsy7pzGRg0gFEnz+nUIy/pnt44kLsz/nxbr04l1z5bPmFomMx036s2ODMU99JFqDcsDD6x7
	B+FdINI5uCkLCuyS0Kq+kKAWjwNfbiI2OFARra78tISlAeJb+90Gp/VTjtVJfUkdhS9y8cjujIzQ=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 51A6uGJ3605581; Mon, 10 Feb 2025 15:56:16 +0900
X-Iguazu-Qid: 2rWhWAeBjX3UcsnPV6
X-Iguazu-QSIG: v=2; s=0; t=1739170570; q=2rWhWAeBjX3UcsnPV6; m=PEpGbHJPdTb+kyLSpGQ0l6qlUAcFXU+N+Hi+UfiPIQo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 51A6u73v4035346
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 14/17] mm/vmscan: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:42 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-15-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit c6202adf3a0969514299cf10ff07376a84ad09bb upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in kswapd_run() to handle the extra states.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184736.119158930@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76853088f66b..9cd702320375 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3620,7 +3620,7 @@ int kswapd_run(int nid)
 	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
 	if (IS_ERR(pgdat->kswapd)) {
 		/* failure at boot is fatal */
-		BUG_ON(system_state == SYSTEM_BOOTING);
+		BUG_ON(system_state < SYSTEM_RUNNING);
 		pr_err("Failed to start kswapd on node %d\n", nid);
 		ret = PTR_ERR(pgdat->kswapd);
 		pgdat->kswapd = NULL;
-- 
2.30.2


