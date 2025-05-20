Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA2258CC7
	for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713416; cv=none; b=FiJ/Ztq66g3w+gJeDyHmr4cCDP5iVWJdP8j7O57R5RRl67qGS3URhJNMr7QGz7dMTDUfunEV2B+I+1U94QEN6hglSP9cottvbQwNppx2FR4LzLdH78PknaXvbPlOG75uJtaLlQjMkClXxxo6tMiLE1d+SYG0mVs+wiaYEfDli54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713416; c=relaxed/simple;
	bh=ZpL7DmyGKa6We49KdLksdMHXtagFsLQfvAe6cdfxJFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nc+3scMeKMhbHgqF6mqrrImJ53SFQiUuMMbha2o8A6ByGaFvADVeXZx90drJ4kbfC6exMC7RmPoKtdV4Hti4XqAVXgqRboww0IAqnSqPE2+K1gC5tVcyj5UDQOOydGhg4xWK5Qz8afELJJK3V2Q4n2A4pmhfN6onfo7eHmec5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMwndbfQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMwndbfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747713412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X5OY3Ou/8UMEpwyB4HH82rsshiH7tzC9TadZrf9KR6A=;
	b=BMwndbfQ5wvs39zoej93gTWzcK1yYs9/jfBcgoGCYkVlBmVjltj3qV4vkZ6SAXZUoNopqE
	6PsYs48/MHH8pG9rArnQTQkuLnAerEaOlbOm6P9SwPUCQtEJgczI13XcvoXSnaQ2TcGyaE
	mDsjWTCR3h//MG/N3jAUFJJL9iGtAsU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-rYTM4vI_Nm-zJZK0cWY1cQ-1; Mon, 19 May 2025 23:56:50 -0400
X-MC-Unique: rYTM4vI_Nm-zJZK0cWY1cQ-1
X-Mimecast-MFC-AGG-ID: rYTM4vI_Nm-zJZK0cWY1cQ_1747713410
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-52e3867e141so386866e0c.3
        for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2025 20:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713410; x=1748318210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5OY3Ou/8UMEpwyB4HH82rsshiH7tzC9TadZrf9KR6A=;
        b=Eq9ryCYvQIZV2PTCkoBv88MrFYsc7LvbQkoY6DtPdDN1hKkILssacBJuwxTxY+lAYi
         EdPnA8OhuhjkxQOBAEuhJ7XO0z40ZEYVlqNG9p7TIn+kljVc0SjhWcu1CO5kX5X73doT
         BgLZxPgwU/H1DlLvJSqaMeNs4B8oR5epeAAlyQ/+VryQ/2wCgpAJO0MRMSn1zPnZz2f0
         ZmFqkRRzz+45fAOdR7f9OTGPqhjnRZQ73DAkRLoI/6zpblWSML10bRpUeGYJx4OPcT3d
         +7eware7CkE3lE7WFKKyyMxhaeR6aZwhUwHt3F8yC5riooxIIg8aRe8vtkxj8HIRArHK
         I+ng==
X-Forwarded-Encrypted: i=1; AJvYcCVkum8Sk+gWI1gTXiBvweGRVSKmNQNpzxJpxwyDomM8Dio4VAyyDGUPYM5vbDGHuZVS1EdaY/tUprhpJ8F3XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/jwcjWYRZrgV0Nv3mQ3xjAOX3/KJPwu/8WIg6Td8+psAkAlG
	LgMFmy++fDCznegk2hf1Vz68gTtm9nxJlEEwb49yr/440boZrgAPEBcFrmmNccHFUe0TioTUXkr
	y5nMaU3FC5B9F808g5uxE1FFR25NXt4Qg48RPaw/2lBkU4eAp/VOjXt9UjO+JNCqHsJ2+
X-Gm-Gg: ASbGncvgSbkqQRKSV1mnqw9qEptqMTUsiAkpUqZnzJpcDwPaB+iyjDCoBllQnpXuiTL
	0QSRoNyxWk6nGfR3Pgi3gaOkvcbKGq82nbsbbq5ete7j9CBXtt+5v6V43LOirdI5w03wqiOJU7j
	/V/HweY39pPkyglKWD+EySCEShzFl8f3uFP4E3Ab+ED5PVYFdFIXsKR87dkfr4uvF4QQEFMNyzq
	hRKQQvX+z5qQ2Kalwvzd2KIDmjIn7SsOyOLNrx8CeF/SL/psbD6goCXHw6MqBUltYy0e4ZAgHTk
	ixUKLV8Fj3xrSqOXpn0=
X-Received: by 2002:a05:6122:d18:b0:529:995:5aec with SMTP id 71dfb90a1353d-52dbcc85543mr13002369e0c.4.1747713409783;
        Mon, 19 May 2025 20:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwVp5TSae6EVnOtitKumMn4WbICQsYY6kJYATGfpzVo9vm5k0s96TFA4pbeitLdEZA6oQWyA==
X-Received: by 2002:a05:6122:d18:b0:529:995:5aec with SMTP id 71dfb90a1353d-52dbcc85543mr13002363e0c.4.1747713409420;
        Mon, 19 May 2025 20:56:49 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:1fb:40c5:4929:490c:3e60])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba910b9dsm7831401e0c.4.2025.05.19.20.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:56:48 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Sana Sharma <sansshar@redhat.com>
Subject: [RFC PATCH] cyclictest: Add skip_sec option
Date: Tue, 20 May 2025 00:56:41 -0300
Message-ID: <20250520035641.533706-1-leobras@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running cyclictest with break trace (-b) option, wait for skip_sec
seconds before issuing the break.

Cyclictest may present high latency on the initial cycles, which can be
caused by initial resource allocations, and may not represent the
expected latency for the running workload.

So add skip_sec so user can make cyclictest ignore any break that may
happen in those inital sseconds.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---

This behavior was found by Sana and me when we were testing cyclictest
on an ARM KVM VM, while running trace-cmd at host and guest
(with trace-cmd agent).

 src/cyclictest/cyclictest.c | 11 ++++++++++-
 src/cyclictest/cyclictest.8 |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 890da5d..26e181a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -183,20 +183,21 @@ static int use_nsecs = 0;
 static int refresh_on_max;
 static int force_sched_other;
 static int priospread = 0;
 static int check_clock_resolution;
 static int ct_debug;
 static int use_fifo = 0;
 static pthread_t fifo_threadid;
 static int laptop = 0;
 static int power_management = 0;
 static int use_histfile = 0;
+static int skip_sec = 0;
 
 #ifdef ARCH_HAS_SMI_COUNTER
 static int smi = 0;
 #else
 #define smi	0
 #endif
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -637,20 +638,21 @@ static void *timerthread(void *param)
 	sigset_t sigset;
 	timer_t timer;
 	struct timespec now, next, interval, stop = { 0 };
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
 	int stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
 	unsigned long smi_now, smi_old = 0;
+	unsigned long skip_cycles = skip_sec * USEC_PER_SEC / par->interval;
 
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
 		rt_numa_set_numa_run_on_node(par->node, par->cpu);
 
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
 		thread = pthread_self();
 		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) != 0)
@@ -837,21 +839,21 @@ static void *timerthread(void *param)
 				pthread_cond_signal(&refresh_on_max_cond);
 		}
 		stat->avg += (double) diff;
 
 		if (trigger && (diff > trigger))
 			trigger_update(par, diff, calctime(now));
 
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
 
-		if (!stopped && tracelimit && (diff > tracelimit)) {
+		if (!stopped && tracelimit && (diff > tracelimit) && stat->cycles > skip_cycles) {
 			stopped++;
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
 			if (break_thread_id == 0) {
 				break_thread_id = stat->tid;
 				tracemark("hit latency threshold (%llu > %d)",
 					  (unsigned long long) diff, tracelimit);
 				break_thread_value = diff;
 			}
 			pthread_mutex_unlock(&break_thread_id_lock);
@@ -1081,20 +1083,21 @@ enum option_values {
 	OPT_DEFAULT_SYSTEM, OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
 	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_MLOCKALL,
 	OPT_REFRESH, OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
 	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_DEEPEST_IDLE_STATE,
+	OPT_SKIP_SEC
 };
 
 /* Process commandline options */
 static void process_options(int argc, char *argv[], int max_cpus)
 {
 	int error = 0;
 	int option_affinity = 0;
 
 	for (;;) {
 		int option_index = 0;
@@ -1137,20 +1140,21 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
 			{"tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
 			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
 			{"verbose",          no_argument,       NULL, OPT_VERBOSE },
 			{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
 			{"policy",           required_argument, NULL, OPT_POLICY },
 			{"help",             no_argument,       NULL, OPT_HELP },
 			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
 			{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
+			{"skip_sec",         required_argument,	NULL, OPT_SKIP_SEC },
 			{NULL, 0, NULL, 0 },
 		};
 		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'a':
 		case OPT_AFFINITY:
 			option_affinity = 1;
@@ -1340,20 +1344,25 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			smi = 1;
 #else
 			fatal("--smi is not available on your arch\n");
 #endif
 			break;
 		case OPT_TRACEMARK:
 			trace_marker = 1; break;
 		case OPT_DEEPEST_IDLE_STATE:
 			deepest_idle_state = atoi(optarg);
 			break;
+		case OPT_SKIP_SEC:
+			skip_sec = atoi(optarg);
+			if (skip_sec < 0)
+				skip_sec = 0;
+			break;
 		}
 	}
 
 	if ((use_system == MODE_SYS_OFFSET) && (use_nanosleep == MODE_CYCLIC)) {
 		warn("The system option requires clock_nanosleep\n");
 		warn("and is not compatible with posix_timers\n");
 		warn("Using clock_nanosleep\n");
 		use_nanosleep = MODE_CLOCK_NANOSLEEP;
 	}
 
diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6becd19..a0eaf7e 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -174,20 +174,22 @@ Output values on stdout for statistics. This option is used to gather statistica
 
 n:c:v
 
 where n=task number c=count v=latency value in us.
 .TP
 .B \-\-dbg_cyclictest
 Print info userful for debugging cyclictest
 .TP
 .B \-x, \-\-posix_timers
 Use POSIX timers instead of clock_nanosleep.
+.B \-\-skip_sec=SEC
+When using -b, skip sending break trace command for the first SEC seconds.
 
 .SH SEE ALSO
 .BR numa (3),
 .BR numactl (8),
 .\" .br
 .\" The programs are documented fully by
 .\" .IR "The Rise and Fall of a Fooish Bar" ,
 .\" available via the Info system.
 .SH AUTHOR
 cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
-- 
2.49.0

