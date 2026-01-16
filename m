Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6B18872A
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Jan 2026 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566190; cv=none; b=bKRfWdKLFW5UZudKRtG78F3/dbUZHHPrvD6DRbmXiuFUJVaI7VnMHmDZ/KGANV4XP64CMM71RYBZpTXJI9mvAU8ganMVHcsGgYmTVtLy2uBxmVdBxfk7i82MVTIxiSGJgJQQkk4zVJ2rnhzxMEzHDy7GGOAOLjGeItc00TAfvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566190; c=relaxed/simple;
	bh=d1/pIW4TqY8JF32EJBYfttCDe8kUGhx260QJ0K6CRoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVMmZM5K6maF7PDSOJdGkiKuEI6ijb3DGd65DRRuyzo/dR+kC02SXmFnMtEvuonmcvX4UrP3DoRZX8DJ6qjR2e7moCh0F7I94rYEEncv2KCVbuq9kqPiax9tEs4szxryhd7Ky0/jXcGAPxZ3+8i3qhN77R2brfNXxYfcdKK0Sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfkMswMZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=geqR/BGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfkMswMZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="geqR/BGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768566187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUTW/d4zjyuIxaPGDEBG4C5Zo4JE9tyy+dw8+HCeNRo=;
	b=DfkMswMZXgNSAp4MRow6/veTESiDnSMla8fzIGbCmT7Wnkp2PfWwoTvfloXTE7aXhYsf4j
	CGS9gY328Qd4xN0J/GdfGw7R3OyKu7KHKf7FB0lAiZyEpT6I+SDkO+iHC+yvmlV5pzcIGG
	c8iOQrJv8BWF6S77MF8vmuWDnCAkchI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-y5HHl0-GM5iwPwxAn0YylQ-1; Fri, 16 Jan 2026 07:23:06 -0500
X-MC-Unique: y5HHl0-GM5iwPwxAn0YylQ-1
X-Mimecast-MFC-AGG-ID: y5HHl0-GM5iwPwxAn0YylQ_1768566185
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so14442765e9.1
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Jan 2026 04:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768566185; x=1769170985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUTW/d4zjyuIxaPGDEBG4C5Zo4JE9tyy+dw8+HCeNRo=;
        b=geqR/BGBYL18jt0GeVa6cU6eAGfGVRmlgs7r9HiVzqHiFs2qEzxxD7tQlgnyTOt0uo
         LBrCipdzG+XNZhnSUtxTc6QTKMxS08L7E+Nqgg6CxmA/UYkyiLEWUO11MEgt10LGTyO7
         Jwv0uS3+RyR7sk5hbu0sfruJfmQNoPHCPSPM6IQ+CmLusabNdRfaqtVfNONZa7omBbmq
         OFAxBO2YRxN0pG8WXvqlFbaCMr+K/ugmqMylarjI4mj87WkeZ0QXDNlQHBV46XrvJoqr
         uVBF23SPOd28r7Z119jKnq6bom0vuJT1nVvqJLl03evZ2zAimxp8xbZNpfosnKvQsFaS
         05/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768566185; x=1769170985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUTW/d4zjyuIxaPGDEBG4C5Zo4JE9tyy+dw8+HCeNRo=;
        b=kArZ8KWSz7SVg5AfYhoG9yzNtVA8ytWJB233clp1zqjBi/UJs7UDX49Xh/oUOW56nJ
         CJjwnid/9ThdKpvMG1NjzTq7AAcCCOdi5zL7n5OJVCVnXRbYIt77Bx7A7xxpQ3AN515K
         /ghaT9gkuLESXdYPIawKkpyBloa6vnNylLO69DGgCb+UWl+0t+T3N56DBKnKgjn6zV8W
         NP/7pU9Ka7yc30rC4DtH1Hn9TY8szLoyFZWHnvDuJ1XP1cxSjfWaKsGypItO2L9UgYjj
         XQUPE43jwuJmSWdDmk4kI4MDq8VIawQU+GZZWLrsPKF+C03UMXj56AZVM1Lbxj5KplCt
         Rclg==
X-Gm-Message-State: AOJu0YzsbiCJLhRPLA9S95MIC4skL3tPAHwDaKWe0TysZrNGKrbEybBG
	+eBqMgCf+hAmLHACyFUX/h3K0DPKwY4M9ac4IfWFW0P/ERy7JHyyuAvvsrsXx4muNpw10cXL73L
	um90Rb4XEFgSZ5mFEpCGAEXCJqaZKPAIxYm7U+Vx2df3vZ7zyR9jK7/aO8VvJM3Kd/GOWmzRyh6
	623hyS/wVJ7lQfajtc7QA53DAdTOB4fpMUQHLUtKmSPr4Ed6Vd9uFwPiY=
X-Gm-Gg: AY/fxX4UplS6CDddO/X2iL1izs2YBe0hFUvq9Md+3qj2TPS6efFkY3XJZ1HcIkv1p5i
	2oR6WjhG19Ujz8zvaycgZMrUrLUMuAyCQKnNeFpIzfk8qn6YJh5XCXYp+N7hNrawB/3mlzejxaW
	2SQnsLotemmE1GSrMy2rT/P+sePi7NeoT331OTGVjEKqYAYw1ZcyPoT8quoKsnPjC+h1AbTirjC
	/LlUEO4zGahvY6AANWoe6zN88Rlz56M77fBKBFXxfTPCHbZFaM7bfAV8Sw0j0TJbsa65A3Mvezz
	nsOWahoD4iVoIQN+aASpGoNJPLnzRavkWNUnjQLGCAvp+VYzX6f1ymXwVUva40NF+So1emUmCnE
	SV/Z0op54GXdVKVXJV6riqA==
X-Received: by 2002:a05:600c:1d0b:b0:47d:333d:868a with SMTP id 5b1f17b1804b1-4801e349ac9mr36235165e9.33.1768566184546;
        Fri, 16 Jan 2026 04:23:04 -0800 (PST)
X-Received: by 2002:a05:600c:1d0b:b0:47d:333d:868a with SMTP id 5b1f17b1804b1-4801e349ac9mr36234465e9.33.1768566184041;
        Fri, 16 Jan 2026 04:23:04 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c00esm40716655e9.2.2026.01.16.04.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:23:03 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v2] cyclictest: Generate optstring dynamically from long_options
Date: Fri, 16 Jan 2026 14:23:00 +0200
Message-ID: <20260116122300.285693-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hard-coded optstring in cyclictest has become bloated and
error-prone, even resulting in a duplicate 'D:' entry.

Modify the long_options array to use the 'val' member of struct option
to store the corresponding short-option character. Add build_optstring()
to automatically construct the optstring from this array at runtime.

This eliminates the need to manually maintain a redundant optstring and
prevents synchronization errors when adding or modifying command-line
options.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---

v2: Address feedback from Crystal Wood and Sebastian Andrzej Siewior
- Start option_values from 0x100
- Fix description
- Count the long_options length and use malloc
- Die on out of memory
- Add range check

---
 Makefile                    |   3 +-
 src/cyclictest/cyclictest.c | 147 +++++++++++++++---------------------
 src/include/opt.h           |  11 +++
 src/lib/opt.c               |  40 ++++++++++
 4 files changed, 112 insertions(+), 89 deletions(-)
 create mode 100644 src/include/opt.h
 create mode 100644 src/lib/opt.c

diff --git a/Makefile b/Makefile
index e3d02cd25924..12bd42850bb1 100644
--- a/Makefile
+++ b/Makefile
@@ -194,7 +194,8 @@ oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
 	bzip2 -c $< > $@
 
 LIBOBJS =$(addprefix $(OBJDIR)/,rt-error.o rt-get_cpu.o rt-sched.o rt-utils.o \
-	histogram.o)
+	histogram.o opt.o)
+
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
 
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b4bce8915b43..5a749d3290b3 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -17,7 +17,6 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <getopt.h>
 #include <pthread.h>
 #include <signal.h>
 #include <sched.h>
@@ -39,6 +38,7 @@
 #include "rt-numa.h"
 #include "rt-error.h"
 #include "histogram.h"
+#include "opt.h"
 
 #include <bionic.h>
 
@@ -1078,17 +1078,10 @@ static char *policyname(int policy)
 
 
 enum option_values {
-	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
-	OPT_DEFAULT_SYSTEM, OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
-	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_MLOCKALL,
-	OPT_REFRESH, OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
-	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
-	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
-	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
-	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
-	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
-	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_DEEPEST_IDLE_STATE,
+	OPT_DEFAULT_SYSTEM = 0x100, OPT_LATENCY, OPT_HISTFILE, OPT_JSON,
+	OPT_MAINAFFINITY, OPT_PRIOSPREAD, OPT_SECALIGNED, OPT_SMI,
+	OPT_TRIGGER, OPT_TRIGGER_NODES, OPT_TRACEMARK, OPT_DBGCYCLIC,
+	OPT_POLICY, OPT_HELP, OPT_LAPTOP, OPT_DEEPEST_IDLE_STATE,
 };
 
 /* Process commandline options */
@@ -1097,63 +1090,63 @@ static void process_options(int argc, char *argv[], int max_cpus)
 	int error = 0;
 	int option_affinity = 0;
 
+	/*
+	 * Options for getopt
+	 * Ordered alphabetically by single letter name
+	 */
+	static struct option long_options[] = {
+		{"affinity",         optional_argument, NULL, 'a'},
+		{"aligned",          optional_argument, NULL, 'A'},
+		{"breaktrace",       required_argument, NULL, 'b'},
+		{"clock",            required_argument, NULL, 'c'},
+		{"default-system",   no_argument,       NULL, OPT_DEFAULT_SYSTEM },
+		{"distance",         required_argument, NULL, 'd'},
+		{"duration",         required_argument, NULL, 'D'},
+		{"latency",          required_argument, NULL, OPT_LATENCY },
+		{"fifo",             required_argument, NULL, 'F'},
+		{"histogram",        required_argument, NULL, 'h'},
+		{"histofall",        required_argument, NULL, 'H'},
+		{"histfile",	     required_argument, NULL, OPT_HISTFILE },
+		{"interval",         required_argument, NULL, 'i'},
+		{"json",             required_argument, NULL, OPT_JSON },
+		{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
+		{"loops",            required_argument, NULL, 'l'},
+		{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
+		{"mlockall",         no_argument,       NULL, 'm'},
+		{"refresh_on_max",   no_argument,       NULL, 'M'},
+		{"nsecs",            no_argument,       NULL, 'N'},
+		{"oscope",           required_argument, NULL, 'o'},
+		{"priority",         required_argument, NULL, 'p'},
+		{"quiet",            no_argument,       NULL, 'q'},
+		{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
+		{"relative",         no_argument,       NULL, 'r'},
+		{"resolution",       no_argument,       NULL, 'R'},
+		{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
+		{"system",           no_argument,       NULL, 's'},
+		{"smi",              no_argument,       NULL, OPT_SMI },
+		{"smp",              no_argument,       NULL, 'S'},
+		{"spike",	     required_argument, NULL, OPT_TRIGGER },
+		{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
+		{"threads",          optional_argument, NULL, 't'},
+		{"tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
+		{"unbuffered",       no_argument,       NULL, 'u'},
+		{"verbose",          no_argument,       NULL, 'v'},
+		{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
+		{"policy",           required_argument, NULL, OPT_POLICY },
+		{"help",             no_argument,       NULL, OPT_HELP },
+		{"posix_timers",     no_argument,	NULL, 'x'},
+		{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
+		{NULL, 0, NULL, 0 },
+	};
+	char *opts = build_optstring(long_options);
+
 	for (;;) {
-		int option_index = 0;
-		/*
-		 * Options for getopt
-		 * Ordered alphabetically by single letter name
-		 */
-		static struct option long_options[] = {
-			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
-			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
-			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
-			{"clock",            required_argument, NULL, OPT_CLOCK },
-			{"default-system",   no_argument,       NULL, OPT_DEFAULT_SYSTEM },
-			{"distance",         required_argument, NULL, OPT_DISTANCE },
-			{"duration",         required_argument, NULL, OPT_DURATION },
-			{"latency",          required_argument, NULL, OPT_LATENCY },
-			{"fifo",             required_argument, NULL, OPT_FIFO },
-			{"histogram",        required_argument, NULL, OPT_HISTOGRAM },
-			{"histofall",        required_argument, NULL, OPT_HISTOFALL },
-			{"histfile",	     required_argument, NULL, OPT_HISTFILE },
-			{"interval",         required_argument, NULL, OPT_INTERVAL },
-			{"json",             required_argument, NULL, OPT_JSON },
-			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
-			{"loops",            required_argument, NULL, OPT_LOOPS },
-			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
-			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
-			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
-			{"nsecs",            no_argument,       NULL, OPT_NSECS },
-			{"oscope",           required_argument, NULL, OPT_OSCOPE },
-			{"priority",         required_argument, NULL, OPT_PRIORITY },
-			{"quiet",            no_argument,       NULL, OPT_QUIET },
-			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
-			{"relative",         no_argument,       NULL, OPT_RELATIVE },
-			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
-			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
-			{"system",           no_argument,       NULL, OPT_SYSTEM },
-			{"smi",              no_argument,       NULL, OPT_SMI },
-			{"smp",              no_argument,       NULL, OPT_SMP },
-			{"spike",	     required_argument, NULL, OPT_TRIGGER },
-			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
-			{"threads",          optional_argument, NULL, OPT_THREADS },
-			{"tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
-			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
-			{"verbose",          no_argument,       NULL, OPT_VERBOSE },
-			{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
-			{"policy",           required_argument, NULL, OPT_POLICY },
-			{"help",             no_argument,       NULL, OPT_HELP },
-			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
-			{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
-			{NULL, 0, NULL, 0 },
-		};
-		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
-				    long_options, &option_index);
+		int c = getopt_long(argc, argv, opts, long_options, NULL);
+
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'a':
-		case OPT_AFFINITY:
 			option_affinity = 1;
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
@@ -1181,7 +1174,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 					numa_bitmask_weight(affinity_mask));
 			break;
 		case 'A':
-		case OPT_ALIGNED:
 			aligned = 1;
 			if (optarg != NULL)
 				offset = atoi(optarg) * 1000;
@@ -1191,29 +1183,22 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				offset = 0;
 			break;
 		case 'b':
-		case OPT_BREAKTRACE:
 			tracelimit = atoi(optarg); break;
 		case 'c':
-		case OPT_CLOCK:
 			clocksel = atoi(optarg); break;
 		case OPT_DEFAULT_SYSTEM:
 			power_management = 1; break;
 		case 'd':
-		case OPT_DISTANCE:
 			distance = atoi(optarg); break;
 		case 'D':
-		case OPT_DURATION:
 			duration = parse_time_string(optarg); break;
 		case 'F':
-		case OPT_FIFO:
 			use_fifo = 1;
 			strncpy(fifopath, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case 'H':
-		case OPT_HISTOFALL:
 			histofall = 1; /* fall through */
 		case 'h':
-		case OPT_HISTOGRAM:
 			histogram = atoi(optarg);
 			if (!histogram)
 				display_help(1);
@@ -1223,13 +1208,11 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			strncpy(histfile, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case 'i':
-		case OPT_INTERVAL:
 			interval = atoi(optarg); break;
 		case OPT_JSON:
 			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case 'l':
-		case OPT_LOOPS:
 			max_cycles = atoi(optarg); break;
 		case OPT_MAINAFFINITY:
 			if (optarg) {
@@ -1242,31 +1225,23 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			}
 			break;
 		case 'm':
-		case OPT_MLOCKALL:
 			lockall = 1; break;
 		case 'M':
-		case OPT_REFRESH:
 			refresh_on_max = 1; break;
 		case 'N':
-		case OPT_NSECS:
 			use_nsecs = 1; break;
 		case 'o':
-		case OPT_OSCOPE:
 			oscope_reduction = atoi(optarg); break;
 		case 'p':
-		case OPT_PRIORITY:
 			priority = atoi(optarg);
 			if (policy != SCHED_FIFO && policy != SCHED_RR)
 				policy = SCHED_FIFO;
 			break;
 		case 'q':
-		case OPT_QUIET:
 			quiet = 1; break;
 		case 'r':
-		case OPT_RELATIVE:
 			timermode = TIMER_RELTIME; break;
 		case 'R':
-		case OPT_RESOLUTION:
 			check_clock_resolution = 1; break;
 		case OPT_SECALIGNED:
 			secaligned = 1;
@@ -1278,10 +1253,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				offset = 0;
 			break;
 		case 's':
-		case OPT_SYSTEM:
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
-		case OPT_SMP: /* SMP testing */
 			if (numa)
 				fatal("numa and smp options are mutually exclusive\n");
 			smp = 1;
@@ -1289,7 +1262,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			setaffinity = AFFINITY_USEALL;
 			break;
 		case 't':
-		case OPT_THREADS:
 			if (smp) {
 				warn("-t ignored due to smp mode\n");
 				break;
@@ -1309,12 +1281,10 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				trigger_list_size = atoi(optarg);
 			break;
 		case 'u':
-		case OPT_UNBUFFERED:
 			setvbuf(stdout, NULL, _IONBF, 0); break;
 		case 'v':
-		case OPT_VERBOSE: verbose = 1; break;
+			verbose = 1; break;
 		case 'x':
-		case OPT_POSIX_TIMERS:
 			use_nanosleep = MODE_CYCLIC; break;
 		case '?':
 		case OPT_HELP:
@@ -1437,6 +1407,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			rt_bitmask_free(affinity_mask);
 		display_help(1);
 	}
+	free(opts);
 }
 
 static int check_timer(void)
diff --git a/src/include/opt.h b/src/include/opt.h
new file mode 100644
index 000000000000..1bb572f6d8f5
--- /dev/null
+++ b/src/include/opt.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#pragma once
+
+#include <getopt.h>
+
+/*
+ * build_optstring - allocate and build optstring from long_options
+ *
+ * Free resulting optstring after use.
+ */
+char *build_optstring(const struct option *long_opts);
diff --git a/src/lib/opt.c b/src/lib/opt.c
new file mode 100644
index 000000000000..ed93f63c5d55
--- /dev/null
+++ b/src/lib/opt.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "opt.h"
+#include "rt-error.h"
+
+char *build_optstring(const struct option *long_opts)
+{
+	char *opts;
+	int n = 0;
+	int i;
+
+	for (i = 0; long_opts[i].name; i++)
+		;
+
+	opts = malloc(i * 3 + 1);
+	if (!opts)
+		fatal("Failed to allocate memory for optstring\n");
+
+	for (i = 0; long_opts[i].name; i++) {
+		if (long_opts[i].flag || long_opts[i].val >= 0x100)
+			continue;
+
+		if (long_opts[i].val < 32 || long_opts[i].val > 127) {
+			warn("Error: option '%s' has invalid val %d (must be 32-127 or >= 0x100)\n",
+				long_opts[i].name, long_opts[i].val);
+			continue;
+		}
+
+		opts[n++] = long_opts[i].val;
+
+		if (long_opts[i].has_arg == required_argument)
+			opts[n++] = ':';
+		else if (long_opts[i].has_arg == optional_argument) {
+			opts[n++] = ':';
+			opts[n++] = ':';
+		}
+	}
+	opts[n] = '\0';
+
+	return opts;
+}
-- 
2.52.0

