Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D718500950
	for <linux-rt-users@vger.kernel.org>; Sat, 10 Jan 2026 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045080; cv=none; b=oMDIpt8YmWs5dg9wnYEqkdXOE2MyKOaUVcTM7CmLzQ4dADJ+SMzI4y2n9NGPChCOG5SighyxsJGoUxlXLPBdz8MtdrPvQlLKJrR3r47DiXGfDCqRFYYqKGJe5YMB6tNBcApklWQk8dK3GlRuwVJzn+8Pu2NwQcbwezxsnvIgdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045080; c=relaxed/simple;
	bh=ySEW2OIsdKnZz3eF1QSRE4kTkdc8GCdIJQ0EKPAsvO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ra7BhERB1EcrE+2EAKTCqBP+t+F0ccN9IETSHvwsE4TLMvyBVMz14GH4hmuEHbxNjVlxinLTSKJA96R6nDu/s7cecbmsn+o/HEnYU95fl6t0Civ+vycPv1+7GlLKj1UdsonIRZ0fuSIwD/WvMqkhTXDAv1OMGkrIp7k0sGyFU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPzLq6bP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHsJffmC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPzLq6bP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHsJffmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768045077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O6SGrGXtWhcgplr+4feeDn6UCMHyb9Ll/7ydcMO/Cqw=;
	b=cPzLq6bPUcWr4MBNKkN7DRSC24LLWCKlzHVZR2dMpUiU8uKi8q9KwhDA34WkK8MzvBt1vU
	mkI3PVuEerX4Xrsp2GpqWu6WmVBhDlCD/UbxxTeU45xx6uWgUCnlWQ6IqsZvUJfp2TtoPb
	/vWFRXCpCbbPBnc+5MXl4xpSAeYXNYE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-mIPg7p2wO5eTI7PnzwV66w-1; Sat, 10 Jan 2026 06:37:56 -0500
X-MC-Unique: mIPg7p2wO5eTI7PnzwV66w-1
X-Mimecast-MFC-AGG-ID: mIPg7p2wO5eTI7PnzwV66w_1768045075
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f527f5easo2048179f8f.1
        for <linux-rt-users@vger.kernel.org>; Sat, 10 Jan 2026 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768045074; x=1768649874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6SGrGXtWhcgplr+4feeDn6UCMHyb9Ll/7ydcMO/Cqw=;
        b=cHsJffmCv/xpY2WybenWeNHwhbZ81jw5m5WHq63Tx2+ASlLgwIvVLVzt1kJt2Ue1Zu
         9yftDxVh9OLoqy0+CqJlRqBx/FYiRceptKDd+GwzhAhKXgc8eMkD54JrXENm14dAY/+3
         LKFgLb86LZJkw9OY4CSIO4QRROUySkPDiRZhW9wONItMnPvlkhUl7TSNwO0XsNqPg+Xo
         GBOIrrmU9qnjvkGrmUH1rj3TXn+dF1rkdgMruaMp5EeQ2wjl0q5H8pFZkfBkgUdo0IKz
         wSoL4QOljPi0Mf6pCFIUjA3YmR5f84SYgvrrk+3n1/WH81fuJgIfDOzaQ3gxuFEoGyaw
         cUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768045074; x=1768649874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6SGrGXtWhcgplr+4feeDn6UCMHyb9Ll/7ydcMO/Cqw=;
        b=t0YBih1FgUlSC9bHK0HqLNtr2UVRMP7wo/Ny6oYBm5IB3fpr3+EOzfHs50JoHCB3CA
         RE+HDU/sXHPPPTmeUE7ZD9Eyo/Cx0++L/KS6VBv+lT0tiQwbulMEtmQLW0hxxBQOMxws
         UtqgoYgz/EZzSzqWiLojuPzIIdJCFJ3M1ti3VRGz73CMv8A1ONGUxX30KXv5NU3Kdr+3
         UMCvc771jZpBAIUHc72B2NL9w7RzCPGcjBxRrivcf4iAFkmXFbd+JnB7Qi7+pjfxFaY2
         ZQUwy4wCK/br9//wzHWKS8k67isaedpQg48wduzv5Biz2RMfDvX28WWchsRJFZwTQh6p
         LLZw==
X-Gm-Message-State: AOJu0YzpQHoqY5yFhrQ6P/7e7lSlJzHsCuGTd/QdUKWUX8eelysln5hH
	lED/JQuLkU0ZyaiTJ238tdEduu87yGn1P6tzM3iFIxsdsUxSYjnrpvCz+wJIjrNo8ywOC2NQwB4
	szXVJt58vWJ2fvURgeTF4Wtg/F6NkdijME/ZfBhMxeA+eTvlEDgTuMkc5HwcHolkxZAe0QWK4E6
	WAlub4kIDp3Cz44Ir+XWgyA3Lf64EFs+7upa8Zb4fRKtPGGHEia0b5bxs=
X-Gm-Gg: AY/fxX4QQcl3Yg/wT/3IZSabxTwgyngNp1b72WYeQT+QrcFghLqyFPlkzxq95RpTsSk
	/Qqh80RPiQMsucBPSTb6s6QU9MXa73CFQOjmj5EubXmHMSOu5HGUewVFIRXEXpZttgpXRhd2STF
	lCHHf0tv68iBaEFwUYT81O3SnDheOc3t53H+sOF7o9Zd+Krl1dnH5TlbDHuEdJgIK8d5nvgFkBZ
	tbozBjAxdGtGq5BvVzREL/ApBMFNgwFFKqt6Sktys6Tb87T3CyXcpN2NeJT0v6Z3vtb8r4mc3iR
	+pc6aR2PJ7zEI2AqThyt5eddXPn8cxhEZEO43cMZwLTE3PYWAdIUUP6cxDhynyYRoCn9gu/xOS9
	Y4G7G3btQ1KG8J7x8bOtoYg==
X-Received: by 2002:a05:6000:250e:b0:430:fd0e:a502 with SMTP id ffacd0b85a97d-432bcfde843mr18440413f8f.22.1768045074432;
        Sat, 10 Jan 2026 03:37:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZbG3e4Zk19s1MWj2zJjCchsWXGNivrUFa1oGDWbVdGJ3cWLI99AX68DF0ejFitu4qoZ601Q==
X-Received: by 2002:a05:6000:250e:b0:430:fd0e:a502 with SMTP id ffacd0b85a97d-432bcfde843mr18440392f8f.22.1768045073957;
        Sat, 10 Jan 2026 03:37:53 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e6784sm27679335f8f.19.2026.01.10.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 03:37:53 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] cyclictest: Generate optstring dynamically from long_options
Date: Sat, 10 Jan 2026 13:37:38 +0200
Message-ID: <20260110113738.2376456-1-costa.shul@redhat.com>
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
to store the corresponding short-option character. Add getopt_auto() to
automatically construct the optstring from this array at runtime.

This eliminates the need to manually maintain a redundant optstring and
prevents synchronization errors when adding or modifying command-line
options.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Makefile                    |   3 +-
 src/cyclictest/cyclictest.c | 147 +++++++++++++++---------------------
 src/include/opt.h           |  11 +++
 src/lib/opt.c               |  29 +++++++
 4 files changed, 101 insertions(+), 89 deletions(-)
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
index b4bce8915b43..a1566159d398 100644
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
+	OPT_DEFAULT_SYSTEM, OPT_LATENCY, OPT_HISTFILE, OPT_JSON,
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
index 000000000000..4d01917be024
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
+ * Free resulted optstring aftre use.
+ */
+char *build_optstring(const struct option *long_opts);
diff --git a/src/lib/opt.c b/src/lib/opt.c
new file mode 100644
index 000000000000..d235788001d9
--- /dev/null
+++ b/src/lib/opt.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <stdlib.h>
+
+#include "opt.h"
+
+char *build_optstring(const struct option *long_opts)
+{
+	char *opts = NULL;
+	int n = 0;
+
+	for (int i = 0; long_opts[i].name; i++) {
+		opts = realloc(opts, n + 4);
+
+		if (long_opts[i].flag || long_opts[i].val < 32 || long_opts[i].val > 127)
+			continue;
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

