Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC963B8BA4
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477804; cv=fail; b=V63nlpL7uF9ubzXN4GyJd2XQlL+HZW4ywWRSkdEDmO5fPFLlxkZruv2wGW1Os4tK7gMccGhiHenkulCSQUO6A7DFOlNocxlqRhp0QVIo3rXoeZ84jp+ug/Gt1kROG6+ep4AendMqzu7DtK2m2wVMifxIANXTHA9hAbQ6S1LSC3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477804; c=relaxed/simple;
	bh=+T8QCMSM33lvJTycOzZhYEJsdIQb8dY08QX4cpEP+L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9KBWS8UA1Mwhkb8QzV7N+hGCFnL7Z/87N3fq6PzcuZFFFpDMtdtvo0+6F6J+pUv80MOi7Ze87JVC6eG4JTcRARc6fG3C1xbSNaEKaFilKf60IyKg3SXIimj4FsFQUVc1S4asJXtv93D/ho+sKqPCq8Eei7gdwsaJgE8gTZeznI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=fFwOR9AK; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="fFwOR9AK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCMb5Rh2U4X+E6lXUCVr62K8xiSffTACGKaA49esqbbDG1FjsYq8hWdwSLqW/aVPW8aTWPV7y1q+QLEqHyFinZhFLApBGqedwGw9RaGvYoxH56P3J2wG5a7wbUvXfKFn4Jkjin92s3vY+ktkVRMEIUkP5+CJi/ONU9T/yaTG6BV/Zo/2KToNA3OyZpdvyOWgB5DUgG+WejcTnmZqln7ojjzzmM14KP0om+MXaU7Kt/DoT5W7dr4PA1xx2waEgMq2SwPTVgrAN2YvpNKSD3JgpEOdMSMXSpOnHBetnEEwCunaz1KQt/FtLbVWJXW4zqRjnxweJW0iZfB3SbXdN82CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSMsTRF3T1GssDjyPtVWvX/D1LXsMuJFvSoYSdpXcZk=;
 b=wCHGYQ2MjzpnIpyDQPM+Vh3veD2/NWnOP/3RfRiBrj+pMVn02ndc65s54Mzga+Cpe6KdR78yg03l+takLbedJEGDn5tJ72lDLuhjBRkKGidYZMy6mrMzMb7p0wINfYSCKWF4jYh+Qe9N95Um5xoSKWrk5jcBGIj1l5tArqUFGgsTUiwR1oSaZUFixICIgyJnHVAchRkSdPrQ7WSDJEm6paExUeBjVOspfyHV3qELtKE+1oqrjvq0V8GgaJjWXVrBpRBnDqSiEkFyxBkIyGoTThNc3BjtJEda1HGULr66y4nD/Br/gfKd+p9h1RT4Oj4CkGUBP3N6+16lVdE2YH5i9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSMsTRF3T1GssDjyPtVWvX/D1LXsMuJFvSoYSdpXcZk=;
 b=fFwOR9AKocQox/m7YUQ1SNfwqY1vu1bjCpcptTs63/oICO/sKIdk1x32y528JapJH8XcRLKki84Gfn+Eli1dIxV8fNOg7elC8kA7jh/OraSpNnIv06+ucVnlOTp42B3rtlL28SK/eh6zDlTdobjDnmnQMT7sf8NbWeb+aKXvXNk0DGqYo1URwnrq+49E0B7nQOELTpx23gUmkb6gZnp8o0j5zL536KRDDbCi3rGBDq+ZPWsJFIyDb68EtUws+FEGRqk3pTESZfFvZDRHf3lPeGSSNfKbJnpZrjHRRCd+m+4/HwDztm1LJ6xL3sZCkIC185Oe18VneXHz4iGgaJ7yeg==
Received: from MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15) by
 DBAPR07MB6821.eurprd07.prod.outlook.com (2603:10a6:10:197::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.13; Tue, 15 Sep 2026 13:09:54 +0000
Received: from MA3PEPF00000405.eurprd04.prod.outlook.com
 (2603:10a6:250:0:cafe::59) by MA2P292CA0028.outlook.office365.com
 (2603:10a6:250::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 13:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MA3PEPF00000405.mail.protection.outlook.com (10.167.241.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 13:09:54 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 15 Sep 2026 15:09:53 +0200
Received: from seroiuvd01221.sero.gic.ericsson.se (seroiuvd01221.sero.gic.ericsson.se [10.86.87.142])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 2D3574020B40;
	Tue, 15 Sep 2026 15:09:53 +0200 (CEST)
Received: by seroiuvd01221.sero.gic.ericsson.se (Postfix, from userid 7162142)
	id F107960968CE; Tue, 15 Sep 2026 15:09:52 +0200 (CEST)
From: Jinnan Li <jinnan.a.li@ericsson.com>
To: Tomas Glozar <tglozar@redhat.com>
CC: <jkacur@redhat.com>, <williams@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Subject: [PATCH v2 1/1] cyclictest: add --warm-up option to skip initial cycles from stats
Date: Tue, 15 Sep 2026 15:09:38 +0200
Message-ID: <20260915130938.3703652-2-jinnan.a.li@ericsson.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAP4=nvRU3DAm2dg-TM8-6+QQ+0gNNhvFXp3Tu9rfM=2wbwJ-Ew@mail.gmail.com>
References: <CAP4=nvRU3DAm2dg-TM8-6+QQ+0gNNhvFXp3Tu9rfM=2wbwJ-Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000405:EE_|DBAPR07MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcd3773-d8f5-402f-826b-08df132aa276
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|3023799007|56012099006|5023799004|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2aBKXRIkq5JCeEg27Ctc4aBpZ9dqhc2CoVcRgZuUpJxxLVj0OI1IgXMJxbF006OKO54qKRH8P22Pgs9VQxRH0uHZg3tKFab3H7Up/6MPhln59whcRSMkDldzBCnRkjcqXpkt0VjX2seQgYvCbDxJBjOMYuR/uOfJ/+ekUe3hXvKPmu87IJQq6pjsHrGkPJuve00jybPPrLLAI7uN65eoApgwqW/zuHQetibLNKauj4D1qBJ86u9t8VNrwE0IM7X+TABZewDzJ49eE+7zaXB7MHpJ9+YTnv5gLMSoPB/frbFvs0qEZMB3RLHGzcnptcmf8hLHYxHilO8GlrQ3xnwafyxUjSMD2Za5Dx4ClYx4HilNiRTHGbk3OGp0a6OYu0Pev+cCY/y0i4FP3KjneZI8HLxYVuQLcAVnbpfqc98lMom87YAA+f1Gas3E5J7YgKanPGhULMkK48Q5U4c+My8BNo9IZb2xP9+6Wa68xh2XXCG6dGAURsYsmMxXR8APxRUpXZPD58IB3ge/pguli2fQNFt5c+rthT+UjjJmEauKsoA+Xp5VZx6hoH2uVgY7h+wGxnNLFNLkBbuyt/x2tsbnbUjHVUK8AN6mVz3k4DuzaTIdM4KcxpJJdajlODYHLgVjWOmGRNPExdGgoCX5F7tdRf975ruoheBf0m1k7M6dqFMQZCCm5s1wGADv3Kg6aGdLpBY4nr7InUTqJKFV6dWCSg==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MjP9lL4oFlNW/u7h+HSZTZ22JUd+rxI2RGXFrKYIqTY8XHmgeeAaTt0dr/AQ/nIOyBC8JGZ9Xoh7WA3SBGh1r0b4m6SQlNYhNKtjiTqGRl50WB9IOU/ZBRC1DrZh/qr4+FyNDsxKzuHhQuNBSs4m9MmcISWp9oo3UTLMSqk7q3qRmfqbeRVo3rJ6aD7lIbNbLmDsDGsNS1P2maMLds0YVYuq3SaJTUyKXwwmlganQjhe72KzK/tbnWka8tHZxDphRWjCRnSLWC4FJuQ78KyIgK4ypWQL2PPcLmdlrDVrcoLdgKk6ox52vKD3UoufHnE7XRNW+VZDtLufGvuWcqY7FsSNU1UA9Hfaw8acQ9uVpGRUeXzm6jPlmmFJqCqAWpKgLN1u2JsuIgvGCUMUz3TSJ/RX14sKoS4ysiGkBM8VbRTWwcFZHMZwpVSGFToTWLnq
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:09:54.3985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcd3773-d8f5-402f-826b-08df132aa276
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6821

Add an opt-in --warm-up=N option that runs N warm-up cycles on top of the
requested test. The warm-up cycles are executed but excluded from the
Min/Max/Avg statistics and, when a histogram is requested with -h, from the
histogram as well. This eliminates startup transients (cold cache, TLB
miss, mlockall page faults) from polluting steady-state latency
measurements.

The warm-up period is added on top of the run rather than taken from it:
the requested duration (-D) or loop count (--loops) is measured only after
the warm-up cycles complete. For example, "-D 1s --warm-up 10" runs the 10
warm-up cycles and then measures for one second, and "--loops 2000
--warm-up 300" runs 300 warm-up cycles followed by 2000 measured cycles.
Because warm-up always completes before measurement starts, a short run can
no longer end while still in the warm-up period, so no special-casing or
warning is needed for that. The option name matches RTLA's --warm-up for
consistency.

The option defaults to 0 (disabled), so the default behavior is unchanged:
with --warm-up=0 every cycle is counted and the histogram records every
sample, exactly as before. The feature only takes effect when the user
explicitly asks for it.

A dedicated option is used rather than leaving it to the user to trim
samples afterwards because the transient pollutes the running Min/Max/Avg
that cyclictest itself prints (and the histogram), which cannot be
post-processed away without re-deriving them from the raw samples.

Testing:
  Tested on a target board (kernel 6.6.142 PREEMPT_RT, isolated).

  - Loops on top: "--loops=2000 --warm-up=300" reports C:2000 (the 300
    warm-up cycles run before the 2000 measured ones).
  - Duration on top: "-D 2s -i100000 --warm-up=10" (10 x 100ms = 1s
    warm-up) ran for 3.15s wall clock, versus 2.05s with --warm-up=0,
    confirming warm-up is added on top of the duration.
  - Histogram consistency: with -h and --loops=2000, the histogram sample
    total was 2000 at both --warm-up=0 and --warm-up=300, so the warm-up
    cycles are excluded from the histogram (they are not simply added to
    it).

  Max latency (us), multi-threaded run reproducing the reported case
  (cyclictest -m -p80 -i1000 -d0 -t4 -a4-7 -D2s), first setup thread (T:0),
  three runs per setting:

    Setting          T:0 Max (3 runs)
    --warm-up=0      6 / 5 / 6
    --warm-up=500    2 / 3 / 2

  Without warm-up the first thread to start absorbs the one-time
  cold-cache/TLB/page-fault cost, inflating its Max, while the other
  threads report ~2us. With warm-up the first thread's Max drops back to
  the steady-state level of the other threads. The effective warm-up
  duration is platform-dependent and should be tuned per platform.

Signed-off-by: Jinnan Li <jinnan.a.li@ericsson.com>
---
 src/cyclictest/cyclictest.8 |  17 ++++
 src/cyclictest/cyclictest.c | 149 ++++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 31 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index fc6121aa..2af7cb7a 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -217,6 +217,23 @@ Set the number of loops. The default is 0 (endless). This option is useful
 for automated tests with a given number of test cycles. Cyclictest is
 stopped once the number of timer intervals has been reached.
 .
+.TP
+.B \-\-warm\-up=N
+Run N warm\-up cycles on top of the requested test before measurement
+begins. The warm\-up cycles are executed but excluded from the Min/Max/Avg
+statistics, and from the histogram when
+.B \-h
+is used, which keeps startup transients (cold cache, TLB misses, mlockall
+page faults) out of the reported steady\-state latency. The warm\-up cycles
+are added on top of the run, not taken from it: the requested duration
+.RB ( \-D )
+or loop count
+.RB ( \-\-loops )
+is measured only after warm\-up completes, so
+.B \-\-loops 2000 \-\-warm\-up 300
+runs 300 warm\-up cycles followed by 2000 measured cycles. The default is 0,
+which disables warm\-up (the historical behavior).
+.
 .SS "Output options"
 .
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 99194378..b7c41211 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -13,6 +13,7 @@
 #endif /* HAVE_LIBCPUPOWER_SUPPORT */
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdarg.h>
 #include <unistd.h>
@@ -189,6 +190,20 @@ static int lockall = 0;
 static int histogram = 0;
 static int histofall = 0;
 static int duration = 0;
+static int warmup_loops = 0;	/* warm-up cycles run on top, excluded from stats */
+
+/*
+ * Number of measured cycles for a thread, i.e. the cycles that were actually
+ * folded into Min/Max/Avg and the histogram. Warm-up cycles are run on top of
+ * the requested test and are excluded here.
+ */
+static inline unsigned long measured_cycles(const struct thread_stat *stat)
+{
+	unsigned long w = (unsigned long)warmup_loops;
+
+	return stat->cycles > w ? stat->cycles - w : 0;
+}
+
 static int use_nsecs = 0;
 static int refresh_on_max;
 static int force_sched_other;
@@ -651,6 +666,8 @@ static void *timerthread(void *param)
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
 	bool need_refresh_max = false;
+	bool in_warmup = false;
+	int stop_armed = 0;
 	int stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
@@ -737,9 +754,16 @@ static void *timerthread(void *param)
 	next.tv_nsec += interval.tv_nsec;
 	tsnorm(&next);
 
-	if (duration) {
+	/*
+	 * When no warm-up is requested, arm the duration deadline right away
+	 * so behavior is unchanged. With warm-up, the deadline is (re)armed in
+	 * the loop once the warm-up cycles are done, so the requested duration
+	 * is measured on top of the warm-up period.
+	 */
+	if (duration && warmup_loops == 0) {
 		stop = now;
 		stop.tv_sec += duration;
+		stop_armed = 1;
 	}
 	if (par->mode == MODE_CYCLIC) {
 		if (par->timermode == TIMER_ABSTIME)
@@ -842,26 +866,60 @@ static void *timerthread(void *param)
 			diff = calcdiff_ns(now, next);
 		else
 			diff = calcdiff(now, next);
-		if (diff < stat->min)
-			stat->min = diff;
-		if (diff > stat->max) {
-			stat->max = diff;
-			if (refresh_on_max)
-				need_refresh_max = true;
+		/*
+		 * During the warm-up period we let the timer run but do not
+		 * fold the sample into Min/Max/Avg (or the histogram, or the
+		 * ring buffer below). This keeps one-time startup transients
+		 * (cold cache, TLB, page faults, ...) out of the reported
+		 * steady-state statistics. Rather than collecting everything
+		 * and resetting afterwards, we simply suppress the processing
+		 * while in warm-up, which avoids the fragile reset/boundary
+		 * handling. warmup_loops == 0 disables warm-up entirely and the
+		 * behavior matches the historical one.
+		 */
+		in_warmup = warmup_loops > 0 &&
+			    stat->cycles < (unsigned long)warmup_loops;
+
+		if (!in_warmup) {
+			if (diff < stat->min)
+				stat->min = diff;
+			if (diff > stat->max) {
+				stat->max = diff;
+				if (refresh_on_max)
+					need_refresh_max = true;
+			}
+			if (need_refresh_max) {
+				if (!pthread_mutex_trylock(&refresh_on_max_lock)) {
+					pthread_cond_signal(&refresh_on_max_cond);
+					pthread_mutex_unlock(&refresh_on_max_lock);
+					need_refresh_max = false;
+				}
+			}
+			stat->avg += (double) diff;
 		}
-		if (need_refresh_max) {
-			if (!pthread_mutex_trylock(&refresh_on_max_lock)) {
-				pthread_cond_signal(&refresh_on_max_cond);
-				pthread_mutex_unlock(&refresh_on_max_lock);
-				need_refresh_max = false;
+
+		/*
+		 * The warm-up period is added on top of the requested run: the
+		 * duration deadline only starts counting once warm-up is done,
+		 * so e.g. "-D 1s --warm-up 10" runs for the 10 warm-up cycles
+		 * plus one second of measured time.
+		 */
+		if (duration && !stop_armed && !in_warmup) {
+			ret = clock_gettime(par->clock, &stop);
+			if (ret != 0) {
+				if (ret != EINTR)
+					warn("clock_gettime() failed. errno: %d\n",
+					     errno);
+				goto out;
 			}
+			stop.tv_sec += duration;
+			stop_armed = 1;
 		}
-		stat->avg += (double) diff;
 
 		if (trigger && (diff > trigger))
 			trigger_update(par, diff, calctime(now));
 
-		if (duration && (calcdiff(now, stop) >= 0))
+		if (duration && stop_armed && (calcdiff(now, stop) >= 0))
 			shutdown++;
 
 		if (!stopped && tracelimit && (diff > tracelimit)) {
@@ -879,14 +937,18 @@ static void *timerthread(void *param)
 		}
 		stat->act = diff;
 
-		if (par->bufmsk) {
+		if (!in_warmup && par->bufmsk) {
 			stat->values[stat->cycles & par->bufmsk] = diff;
 			if (smi)
 				stat->smis[stat->cycles & par->bufmsk] = diff_smi;
 		}
 
-		/* Update the histogram */
-		if (histogram)
+		/*
+		 * Update the histogram, skipping samples taken during the
+		 * warm-up period so the histogram stays consistent with the
+		 * suppressed Min/Max/Avg statistics.
+		 */
+		if (histogram && !in_warmup)
 			hist_sample(stat->hist, diff);
 
 		stat->cycles++;
@@ -906,7 +968,13 @@ static void *timerthread(void *param)
 			tsnorm(&next);
 		}
 
-		if (par->max_cycles && par->max_cycles == stat->cycles)
+		/*
+		 * The warm-up cycles are added on top of the requested loop
+		 * count, so a run of "--loops N --warm-up W" performs W warm-up
+		 * cycles followed by N measured cycles.
+		 */
+		if (par->max_cycles &&
+		    par->max_cycles + (unsigned long)warmup_loops == stat->cycles)
 			break;
 	}
 
@@ -991,6 +1059,10 @@ static void display_help(int error)
 	       "                           This value is written to /dev/cpu_dma_latency\n"
 	       "                           and affects c-states. The default is 0\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "         --warm-up=N       run N warm-up cycles on top of the test,\n"
+	       "                           excluded from min/max/avg and the histogram\n"
+	       "                           to exclude startup transients (cold cache,\n"
+	       "                           TLB miss, page faults): default=0(off)\n"
 	       "         --mainaffinity=CPUSET\n"
 	       "			   Run the main thread on CPU #N. This only affects\n"
 	       "                           the main thread and not the measurement threads\n"
@@ -1119,7 +1191,7 @@ enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
 	OPT_DEFAULT_SYSTEM, OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_MLOCKALL,
+	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_WARMUP, OPT_MLOCKALL,
 	OPT_REFRESH, OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
@@ -1158,6 +1230,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"json",             required_argument, NULL, OPT_JSON },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
 			{"loops",            required_argument, NULL, OPT_LOOPS },
+			{"warm-up",          required_argument, NULL, OPT_WARMUP },
 			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
@@ -1269,6 +1342,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'l':
 		case OPT_LOOPS:
 			max_cycles = atoi(optarg); break;
+		case OPT_WARMUP:
+			warmup_loops = atoi(optarg); break;
 		case OPT_MAINAFFINITY:
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &main_affinity_mask);
@@ -1460,6 +1535,11 @@ static void process_options(int argc, char *argv[], int max_cpus)
 	if (num_threads < 1)
 		error = 1;
 
+	if (warmup_loops < 0) {
+		warn("--warm-up must be >= 0, ignoring warm-up\n");
+		warmup_loops = 0;
+	}
+
 	if (aligned && secaligned)
 		error = 1;
 
@@ -1564,9 +1644,12 @@ static void print_hist(struct thread_param *par[], int nthreads)
 		fprintf(fd, " %05lu", par[j]->stats->min);
 	fprintf(fd, "\n");
 	fprintf(fd, "# Avg Latencies:");
-	for (j = 0; j < nthreads; j++)
-		fprintf(fd, " %05lu", par[j]->stats->cycles ?
-		       (long)(par[j]->stats->avg/par[j]->stats->cycles) : 0);
+	for (j = 0; j < nthreads; j++) {
+		unsigned long c = measured_cycles(par[j]->stats);
+
+		fprintf(fd, " %05lu", c ?
+		       (long)(par[j]->stats->avg / c) : 0);
+	}
 	fprintf(fd, "\n");
 	fprintf(fd, "# Max Latencies:");
 	maxmax = 0;
@@ -1610,6 +1693,7 @@ static void print_hist(struct thread_param *par[], int nthreads)
 static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet)
 {
 	struct thread_stat *stat = par->stats;
+	unsigned long avg_cycles = measured_cycles(stat);
 
 	if (!verbose) {
 		if (quiet != 1) {
@@ -1622,9 +1706,9 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
 
 			fprintf(fp, fmt, index, stat->tid, par->prio,
-				par->interval, stat->cycles, stat->min,
-				stat->act, stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
+				par->interval, avg_cycles, stat->min,
+				stat->act, avg_cycles ?
+				(long)(stat->avg / avg_cycles) : 0, stat->max);
 
 			if (smi)
 				fprintf(fp, " SMI:%8ld", stat->smi_count);
@@ -1666,6 +1750,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 {
 	struct thread_stat *stat = par->stats;
 	int fd = rstat_fd;
+	unsigned long avg_cycles = measured_cycles(stat);
 
 	if (!verbose) {
 		if (quiet != 1) {
@@ -1678,9 +1763,9 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
 
 			dprintf(fd, fmt, index, stat->tid, par->prio,
-				par->interval, stat->cycles, stat->min,
-				stat->act, stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
+				par->interval, avg_cycles, stat->min,
+				stat->act, avg_cycles ?
+				(long)(stat->avg / avg_cycles) : 0, stat->max);
 
 			if (smi)
 				dprintf(fd, " SMI:%8ld", stat->smi_count);
@@ -1921,10 +2006,11 @@ static void write_stats(FILE *f, void *data)
 			hist_print_json(s->hist, f);
 			fprintf(f, "      },\n");
 		}
-		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
+		fprintf(f, "      \"cycles\": %ld,\n", measured_cycles(s));
 		fprintf(f, "      \"min\": %ld,\n", s->min);
 		fprintf(f, "      \"max\": %ld,\n", s->max);
-		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
+		fprintf(f, "      \"avg\": %.2f,\n", measured_cycles(s) ?
+			s->avg / measured_cycles(s) : 0.0);
 		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
 		fprintf(f, "      \"node\": %d\n", par[i]->node);
 		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
@@ -2297,7 +2383,8 @@ int main(int argc, char **argv)
 		for (i = 0; i < num_threads; i++) {
 
 			print_stat(stdout, parameters[i], i, verbose, quiet);
-			if (max_cycles && statistics[i]->cycles >= max_cycles)
+			if (max_cycles && statistics[i]->cycles >=
+			    max_cycles + (unsigned long)warmup_loops)
 				allstopped++;
 		}
 
-- 
2.50.1

