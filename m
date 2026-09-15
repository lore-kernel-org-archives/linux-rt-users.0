Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B4318ED2
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435322; cv=fail; b=i8ka4L6T19rEeRhlFCJ96xDvrwdlrnw/euZOVWHhdPBKNYZK1DqaIL6LptB7oCld7ZiK52VxkumFlAiUo6QSqPWMI4DBfI9DLE+6k45YNUokIG7iyEOX5r1NHxv9JXJ5/rF24ikp6GNujS9vhzJso/9j2f/E29UDkP+SxQ1jwD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435322; c=relaxed/simple;
	bh=ZiEAc/dFzLep0fPxZzMwM4suyjneI1szbBRnhZcP8gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0pi+X3xzFUemzY15VoYmVCWv2OopX3uqN9/mCz6qsPYEO0QASjV+YM2MYlh6DaZUYPOrhnt2RyGpEUoCu3dHCmPrFcDf416en3j9wMw8jkW6WWVP/ORNQh7sNHslHwyoBA5PrEiEN/BwgcHnYTcxGE4bMb1PWk/YS4UMTddkTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=dHESvKZ5; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="dHESvKZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EodLOh3X4gynqpxhvh/DVjHlkR6zTcYSn8gibxbVSiEsLbHCwGXPvJuAZX40d/I7yX4H9H1lHgZ62U53D5A4PEJDMOuUI8JNnU5m/Rprft+3ifyN3sg2LnSL7aFAZMvS1aes3BR7OEKw6TrJ1hdTvXmY2NCJbSocQbThlSBME8psuV9BGKaKg2gVEkdLcw+dfI8d9C5vHi5ZzM+LpcB900pFPWytk81/kSYrQZKzSBZdGuHOG8eeuOkhyyGd1pfWppBoRDO9RySXtvM7CNSDWefQKmXXJpbc9gCOXG87P+xFjI2QMEDm1a9LPVUju5JzTgft1vCMhm7W1Cgngf1yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz/UXmzMLvMm6wxNbxjANNVs1ahdsa9lAN5ObAPK/hY=;
 b=wwlM+LHHCC53HjABW+kjDnyRlePp4Jwxbqd2V0RDM6p5Q7/WBjV2TgOGPBqym94zA8w3UBT7zDeCODfZ4xpsvGIDJBvRsK4uLiqD8t7Nb4ubYCmOsKh0dwYO5sGMRpxKrA2oTz7yLM09kmwaMydIgybsbxegrbcl1gsL9/5kt8cUTRC9phuTmOix8FdB9Tie0cWTqvYaPj7r89WZSWN8jmW/rsYUQhakDfq/rCcyjce9y1IhsEOZqc5YnWlrUZ0WyEQoJEVBezxqoi1OAWOW56eUWRCfI8nJnUskazisGpi+iNzBe1JNNFCQIWzexC4t2fhBS/MXIX7WiR0mYNgC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz/UXmzMLvMm6wxNbxjANNVs1ahdsa9lAN5ObAPK/hY=;
 b=dHESvKZ53hJe5F7EFVIK2EQPbJBxUz6A/XDWJTFRkT2wxy7U9PTmJIdEthDjxJpZMyAkvoChNISDypMGsqUbfUxlwtP3KC1r+Ul7TyNenIh0pfrXTFvIeSh/tT9yBiBQl3sRszHKOFDBQBGM/9fYpall+yRm/dsM8I5Kx4om/xGUWdAVOnK+bb5vqLK64TqTU+8u1Rllbs39GHc6FG4KH0TK5nXlNENPNXKLhu7f1iIvzGxmmYwvnDmCwct7Jadnhthg67rTcWct48Y+JD9G1TIm2KxBUzdjziuB3/E9J6pDEU8isPZHopJaUhXQHSPf9WUAfi3MCrMU1bZbsQjO2Q==
Received: from MA3P292CA0018.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:47::19)
 by DU0PR07MB10634.eurprd07.prod.outlook.com (2603:10a6:10:5a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 01:21:56 +0000
Received: from MAD0EPF000008C7.eurprd05.prod.outlook.com
 (2603:10a6:250:47:cafe::7b) by MA3P292CA0018.outlook.office365.com
 (2603:10a6:250:47::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Tue, 15
 Sep 2026 01:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008C7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 01:21:55 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 15 Sep 2026 03:21:55 +0200
Received: from seroiuvd01221.sero.gic.ericsson.se (seroiuvd01221.sero.gic.ericsson.se [10.86.87.142])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id E43854020B40;
	Tue, 15 Sep 2026 03:21:54 +0200 (CEST)
Received: by seroiuvd01221.sero.gic.ericsson.se (Postfix, from userid 7162142)
	id BAD9960968CF; Tue, 15 Sep 2026 03:21:54 +0200 (CEST)
From: Jinnan Li <jinnan.a.li@ericsson.com>
To: <jkacur@redhat.com>, <williams@redhat.com>
CC: <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH 1/1] cyclictest: add --warmup option to skip initial cycles from stats
Date: Tue, 15 Sep 2026 03:21:54 +0200
Message-ID: <20260915012154.2172762-2-jinnan.a.li@ericsson.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260915012154.2172762-1-jinnan.a.li@ericsson.com>
References: <20260915012154.2172762-1-jinnan.a.li@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C7:EE_|DU0PR07MB10634:EE_
X-MS-Office365-Filtering-Correlation-Id: 886f1810-009c-4bb7-95a4-08df12c7bb54
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|3023799007|56012099006|5023799004|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5Gky0NfLQszFCgLqkdv9CzDvWVcdOQyv65kxwXBQRxcuNXfZn6vtWWZvlyyiOt04oDQJ9TLOPFZt8WIsLiFNQ/C0cddLY6TaursNsZMTNHDoyvmK3PZJTSPm6YxCA/cUeZZR6FzJk6hDfBcCjba9ltinmTZV1a4gHe9p99nG/YQh979n4O3bwF9DWdRd4HtXOp95WGZiB4mmeUsRkiotZ79pVsYrs3R0unRQaWzKVHMyf/ovhitOL6aKB8/M5TFabuSrQtbj5nhccqBSYtEGPXOsL63eKskB8XoJHb/H4rkFPOG50w3fWmm7lPWeG/Ity5EVEum9kHYUAQqmNlUCwJVZbRXfKFIzJ2XdTS4HZjwiM3PaxL9NSiGxaxkf6G+vYI1mYdGQQTSDCQcwMVUWbNQjpj4Er2xgIRFNyFrJneAthErsxt3KgvfaweuQ0hzjiPJZVLZ9kuDd1brHLveC2QKhv8xDwDoMe3yEr9p7XsD8MaaE2fGjYTrdZnuy2vC+ScaznwEbHk32Z4jALN5imiT733u9WsBJuzx9oc5LRjtYxoIumYgF1W34KBjOySlayV8PDgNAphjPnh3H7NudfT5mTjbu1FQJoNqgXWAJ8xzea5mFUBfrmNr22+GiqYvHnLhhn0gDaVp/T215s7UonP+ejfkrj1zjpKj0o8tqwiluCnIH7ptc8Q7rQRXvZGHiRB2EI4HZZAb2fF6XfMAjdQ==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0TeXuRqYlSUI9kKVNuninlLm/lsEG3SkKFd+D3aGO0dZoon6v9DA79DAV51xz0L0w7MQamyiIhkiLCTZ9fF3BrFMOHfa93xQDAzcF+Mir4XWxM0ArIVcN8MPieOjaXMmJEcMTrVAr7O3l8/jP6ZVYr4ytYBuNpSO47W9RPUwMISpf+I3NYzLWkFey/WZd3HVSjmu0jdlsdtkS8se38e/FX2KpjREg//zG89u18AtVO/h8EKpdf3XvofmaKVa5GUryHTzR8J6OQd8vz+04UidWVKccgMYmbqB+Y1Y4+3SeWK35rW9Au5otW/3O0XIqACtdkll7iCqu4lCzeRQaZe63j1kgRFth6nt7t4oeQf7Ur5dBP/qHKKGA0aOOfIJDm80aNUkK0SP6kvVpdrXT2RDfUNqbuUQUDTj1LjIneZpm9aPEwkPRiVJsP882rZUB0bD
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:21:55.9373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886f1810-009c-4bb7-95a4-08df12c7bb54
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10634

Add an opt-in --warmup=N option that resets Min/Max/Avg statistics after
the first N cycles. This eliminates startup transients (cold cache, TLB
miss, mlockall page faults) from polluting steady-state latency
measurements.

The option defaults to 0 (disabled), so the default behavior is
unchanged: with --warmup=0 every cycle is counted and the histogram
records every sample, exactly as before. The feature only takes effect
when the user explicitly asks for it.

This addresses a real observation: in a multi-threaded run such as

  cyclictest -m -p 80 -i 1000 -d 0 -t18 --affinity=6-23 -D 3s -q

only the first setup thread shows an inflated Max (e.g. 7us) while all
other threads report Max 2us. The first thread to start absorbs the
one-time cold-cache/TLB/page-fault cost, which then dominates its Max
for the entire run. Discarding the initial cycles removes this artifact
so the reported statistics reflect steady state.

A dedicated option is used rather than leaving it to the user to trim
samples afterwards because the transient pollutes the running Min/Max/Avg
that cyclictest itself prints (and the histogram), which cannot be
post-processed away without re-deriving them from the raw samples.

When a histogram is requested with -h, the warmup cycles are excluded
from the histogram too, so all reported statistics stay consistent. If
warmup is disabled the histogram path is byte-for-byte identical to the
previous behavior.

Testing:
  Test on a target board (kernel 6.16.0-rc7) with 8 measurement threads
  pinned to isolated CPUs
  (cyclictest -m -p80 -i1000 -d0 -t8 -D2s, 5 runs per setting).
  Histogram consistency was confirmed with -l2000: the histogram total
  was 1999 samples at --warmup=0 and 1699 at --warmup=300 (difference
  300, exactly the warmup count), so the histogram excludes precisely
  the warmup cycles.

  Latency (us), per-run worst-case over the 8 threads:

    Setting        Min   Median Max   Avg Max   Peak Max
    --warmup=0      1        6.0         5.8        6
    --warmup=200    1        2.0         2.0        2
    --warmup=400    1        2.0         2.0        2

  The Min floor is unchanged while the median and max drop once the
  startup transient is discarded. The effective warmup duration is
  platform-dependent: on this platform the transient is fully absorbed
  by ~200 cycles, so warmup=400 gives no improvement over warmup=200.
  Other platforms (slower memory, larger caches, different interval)
  may need more or fewer cycles, so N should be tuned per platform
  rather than assumed from these numbers.

Signed-off-by: Jinnan Li <jinnan.a.li@ericsson.com>
---
 src/cyclictest/cyclictest.8 | 22 +++++++++++++++
 src/cyclictest/cyclictest.c | 55 +++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index fc6121aa..4e7b0873 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -217,6 +217,28 @@ Set the number of loops. The default is 0 (endless). This option is useful
 for automated tests with a given number of test cycles. Cyclictest is
 stopped once the number of timer intervals has been reached.
 .
+.TP
+.B \-\-warmup=N
+Skip the first N cycles from the Min/Max/Avg statistics. This eliminates
+startup transients (cold cache, TLB misses, mlockall page faults) from
+polluting steady-state latency measurements. The Min/Max/Avg values are
+reset after cycle N, and the average divisor excludes the warmup cycles.
+When a histogram is requested with
+.B \-h
+the warmup cycles are likewise excluded from the histogram, so all
+reported statistics reflect steady state consistently.
+The default is 0, which disables warmup so all cycles are counted
+(preserving the historical behavior).
+.IP
+Note: if the run stops before N cycles complete (for example
+.B \-\-loops
+is smaller than N, or a short
+.B \-D
+duration ends first) the statistics are never reset and still include the
+startup transients. In the
+.B \-\-loops
+case a warning is printed.
+.
 .SS "Output options"
 .
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 99194378..94b3a2f1 100644
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
@@ -189,6 +190,7 @@ static int lockall = 0;
 static int histogram = 0;
 static int histofall = 0;
 static int duration = 0;
+static int warmup_loops = 0;	/* skip first N cycles from min/max/avg stats */
 static int use_nsecs = 0;
 static int refresh_on_max;
 static int force_sched_other;
@@ -858,6 +860,13 @@ static void *timerthread(void *param)
 		}
 		stat->avg += (double) diff;
 
+		if (warmup_loops > 0 && stat->cycles == (unsigned long)warmup_loops) {
+			/* Reset stats after warmup period */
+			stat->min = UINT64_MAX;
+			stat->max = 0;
+			stat->avg = 0.0;
+		}
+
 		if (trigger && (diff > trigger))
 			trigger_update(par, diff, calctime(now));
 
@@ -885,8 +894,18 @@ static void *timerthread(void *param)
 				stat->smis[stat->cycles & par->bufmsk] = diff_smi;
 		}
 
-		/* Update the histogram */
-		if (histogram)
+		/*
+		 * Update the histogram. When warmup is enabled, skip samples
+		 * collected during the warmup period so the histogram stays
+		 * consistent with the Min/Max/Avg statistics, which are reset
+		 * after warmup. The reset at cycle warmup_loops zeroes the
+		 * average, so exclude that boundary cycle here too (use '>' not
+		 * '>=') to keep the histogram sample count and the average
+		 * divisor aligned. When warmup is disabled (warmup_loops == 0)
+		 * every sample is recorded, matching the historical behavior.
+		 */
+		if (histogram &&
+		    (warmup_loops == 0 || stat->cycles > (unsigned long)warmup_loops))
 			hist_sample(stat->hist, diff);
 
 		stat->cycles++;
@@ -991,6 +1010,9 @@ static void display_help(int error)
 	       "                           This value is written to /dev/cpu_dma_latency\n"
 	       "                           and affects c-states. The default is 0\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "         --warmup=N        skip first N cycles from min/max/avg stats\n"
+	       "                           to exclude startup transients (cold cache,\n"
+	       "                           TLB miss, page faults): default=0(off)\n"
 	       "         --mainaffinity=CPUSET\n"
 	       "			   Run the main thread on CPU #N. This only affects\n"
 	       "                           the main thread and not the measurement threads\n"
@@ -1119,7 +1141,7 @@ enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
 	OPT_DEFAULT_SYSTEM, OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_MLOCKALL,
+	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_WARMUP, OPT_MLOCKALL,
 	OPT_REFRESH, OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
@@ -1158,6 +1180,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"json",             required_argument, NULL, OPT_JSON },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
 			{"loops",            required_argument, NULL, OPT_LOOPS },
+			{"warmup",           required_argument, NULL, OPT_WARMUP },
 			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
@@ -1269,6 +1292,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'l':
 		case OPT_LOOPS:
 			max_cycles = atoi(optarg); break;
+		case OPT_WARMUP:
+			warmup_loops = atoi(optarg); break;
 		case OPT_MAINAFFINITY:
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &main_affinity_mask);
@@ -1460,6 +1485,22 @@ static void process_options(int argc, char *argv[], int max_cpus)
 	if (num_threads < 1)
 		error = 1;
 
+	if (warmup_loops < 0) {
+		warn("--warmup must be >= 0, ignoring warmup\n");
+		warmup_loops = 0;
+	}
+
+	/*
+	 * If the run stops before the warmup period completes, the stats are
+	 * never reset, so Min/Max/Avg still include the startup transients the
+	 * warmup was meant to discard. Warn the user; -D (duration) can't be
+	 * compared to a cycle count here, so we only catch the --loops case.
+	 */
+	if (warmup_loops > 0 && max_cycles && max_cycles <= warmup_loops)
+		warn("--loops=%d <= --warmup=%d: warmup never completes, "
+		     "reported Min/Max/Avg still include startup transients\n",
+		     max_cycles, warmup_loops);
+
 	if (aligned && secaligned)
 		error = 1;
 
@@ -1610,6 +1651,8 @@ static void print_hist(struct thread_param *par[], int nthreads)
 static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet)
 {
 	struct thread_stat *stat = par->stats;
+	unsigned long avg_cycles = stat->cycles > (unsigned long)warmup_loops ?
+			stat->cycles - (unsigned long)warmup_loops : stat->cycles;
 
 	if (!verbose) {
 		if (quiet != 1) {
@@ -1624,7 +1667,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 			fprintf(fp, fmt, index, stat->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
 				stat->act, stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
+				(long)(stat->avg / avg_cycles) : 0, stat->max);
 
 			if (smi)
 				fprintf(fp, " SMI:%8ld", stat->smi_count);
@@ -1666,6 +1709,8 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 {
 	struct thread_stat *stat = par->stats;
 	int fd = rstat_fd;
+	unsigned long avg_cycles = stat->cycles > (unsigned long)warmup_loops ?
+			stat->cycles - (unsigned long)warmup_loops : stat->cycles;
 
 	if (!verbose) {
 		if (quiet != 1) {
@@ -1680,7 +1725,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 			dprintf(fd, fmt, index, stat->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
 				stat->act, stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
+				(long)(stat->avg / avg_cycles) : 0, stat->max);
 
 			if (smi)
 				dprintf(fd, " SMI:%8ld", stat->smi_count);
-- 
2.50.1

