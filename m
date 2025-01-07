Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63819DF75
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287366; cv=none; b=Pt0f5+XfKjZNPGSJ9TPrqnmK9HMKJGay2cmlOpdvqnJbeHxMvBk5Kce6p4k4ojg8SDAGUnwS7kbTMARgb6PXmHTB5IZGn3TXVqMsguIKIU83hk3Wv3po3cccJX9F2FbmKPHZk8Wfa4OLWkYCPWFflwEZ3VwhC7IxVCV20dfAWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287366; c=relaxed/simple;
	bh=S/hkyA3IK6yih3oPigfrvFkSLcgj+ZH05r6ygCg1wGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJBfRanmWO+9A1hITpCTGemQmNoOdHf0OHx/sM/tvVejt8swea4UcoCOHxkg4If1FkyaMabCQJgulmGdAGVX99IFY1i42WkK1Ge2nLJYDUA8h6+auppQmuNK9g1Fn0nNY53eah500XnKNVvLbNq5fyPHwZJteXPQAbv4GWmfD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC7lcMFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC7lcMFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736287363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSEiIik3zcm6NmQk0jZxOrTLs6OJWnvpTRjr2/AWbJ4=;
	b=OC7lcMFilNiGTuYf90wdcREKznA9vdK5rXk+OiwMHTH7pLLgLHgu1F4jOB3SIcvgEDcLx/
	a6v4TqnpkwgX5jZ1JrttuT6ylixYw6kw7ifTMxsNOQqZ23VTitenLRlhvV7Cq8ZsG4Vb5S
	xouPrCayLbP7qOrGnG4HJT4hvvnRXJY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-2AxRaRBwOWiWannhWX9k3Q-1; Tue, 07 Jan 2025 17:02:42 -0500
X-MC-Unique: 2AxRaRBwOWiWannhWX9k3Q-1
X-Mimecast-MFC-AGG-ID: 2AxRaRBwOWiWannhWX9k3Q
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-468f7e0aef7so375696901cf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jan 2025 14:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287362; x=1736892162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSEiIik3zcm6NmQk0jZxOrTLs6OJWnvpTRjr2/AWbJ4=;
        b=PdUsRTCYCQb5BSxAMhf9G81Oi7PZ2aN+oC2H89kK0eSZr5EoGiuJVWxiRMQc548fet
         At/V6vI5cY+xXbsHjy/41sFU4EU1nz3A6q51dp8PL+TZRqYTxYVSsvC/XjLYdXbmKaLD
         9Urbtk3Qd8fXukJffhyPW7J6cdp59oR2IiAPYe7hHcPlHV2mSd4hrq1FGBqh7ZrXOJQe
         MXBQl/sbEo1cjGTUynLnI5/eadH+8F9dIDoueyGqkIFJNa2yXriyhZBeL3xPYeTiYTt3
         ObpJPR0/8zPNBtmvsTtZr+n/blM0nbKSVXKZrjS5T8BingG0FeFPXqlb5YQV+hyFpFi2
         mCmw==
X-Gm-Message-State: AOJu0YwObZ/IRpN/0t+MUh0nw8rxZZo8XMRNvhVxCZJ2M9D31HXz8sl4
	nBBKQFty7wc7F4LRApuZTYEFB/LiHnG4GMSxlzj/WB31aZixvE7VFQ9P1OwnXB2V5F3lAMRSLNL
	OxDe2/bcAGGTAwcIuJI2RGI2gnMZbo1Ow7LVYOXuXfRddafXUpn4cQMcNTAsaowTQ
X-Gm-Gg: ASbGnctcJxD3Jpb4KVNyK8sIffFYCm6uvbrK18CN00k3POFDV1Hr2xwYQinOEfWbOTn
	dB3fqsLC2VEPMdLwyhWAe2a1SyrCjAz3Y0C36xYfq9JkoUzdjJ4X+YDJgHt+dOlKYnQxRMdH8Ue
	RbGFS/OS4O8FCjQarbA0q1yQ3267IDiZgtYw5JWmgn4oqV9mvl2VqolJBOuoRUz9EdNtqfD2FgS
	9/Y4M2ZhbXRiCHkyQlzOLRDody9kYQ0QIEDniw5R/CQTIC2HUuCpU50yRskhsputXFHjW+Pi/ZG
	hol9J7Iizb/HhIx/7EKrIG4OMESYfaknBEEGdXFRFjrU6w==
X-Received: by 2002:ac8:7d96:0:b0:467:5a54:877a with SMTP id d75a77b69052e-46c7102c9damr9306771cf.28.1736287361780;
        Tue, 07 Jan 2025 14:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYH3HVmxuzMDY4npNXU0Fcafi3oI76Lds+mfi/uwbc7MsdBeJei3ELfG3LLcZKXcJewKDyaQ==
X-Received: by 2002:ac8:7d96:0:b0:467:5a54:877a with SMTP id d75a77b69052e-46c7102c9damr9306041cf.28.1736287361239;
        Tue, 07 Jan 2025 14:02:41 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6ada4fsm189884261cf.52.2025.01.07.14.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:02:40 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/3] rt-tests: Remove unused parameter annotations
Date: Tue,  7 Jan 2025 17:02:29 -0500
Message-ID: <20250107220229.156201-4-crwood@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107220229.156201-1-crwood@redhat.com>
References: <20250107220229.156201-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are no longer necessary with -Wno-unused-parameter

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 src/cyclictest/cyclictest.c           | 11 +++++------
 src/oslat/oslat.c                     |  4 ++--
 src/pi_tests/pi_stress.c              |  4 ++--
 src/pmqtest/pmqtest.c                 |  7 +++----
 src/ptsematest/ptsematest.c           |  7 +++----
 src/queuelat/queuelat.c               |  2 +-
 src/rt-migrate-test/rt-migrate-test.c |  4 ++--
 src/sched_deadline/cyclicdeadline.c   |  2 +-
 src/signaltest/signaltest.c           |  2 +-
 src/sigwaittest/sigwaittest.c         |  4 ++--
 src/ssdd/ssdd.c                       |  2 +-
 src/svsematest/svsematest.c           |  5 +++--
 12 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b1f8420..890da5d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -436,11 +436,10 @@ static int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_sta
 
 static inline int have_libcpupower_support(void) { return 1; }
 #else
-static inline int save_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
-static inline int restore_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
+static inline int save_cpu_idle_disable_state(unsigned int cpu) { return -1; }
+static inline int restore_cpu_idle_disable_state(unsigned int cpu) { return -1; }
 static inline void free_cpu_idle_disable_states(void) { }
-static inline int set_deepest_cpu_idle_state(__attribute__((unused)) unsigned int cpu,
-											 __attribute__((unused)) unsigned int state) { return -1; }
+static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state) { return -1; }
 static inline int have_libcpupower_support(void) { return 0; }
 #endif /* HAVE_LIBCPUPOWER_SUPPORT */
 
@@ -1687,7 +1686,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
  * thread that creates a named fifo and hands out run stats when someone
  * reads from the fifo.
  */
-static void *fifothread(void *param __attribute__ ((unused)))
+static void *fifothread(void *param)
 {
 	int ret;
 	int fd;
@@ -1868,7 +1867,7 @@ rstat_err:
 	return;
 }
 
-static void write_stats(FILE *f, void *data __attribute__ ((unused)))
+static void write_stats(FILE *f, void *data)
 {
 	struct thread_param **par = parameters;
 	int i;
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 0863297..9e5a08a 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -220,7 +220,7 @@ struct global {
 
 static struct global g;
 
-static void workload_nop(char *dst __attribute__ ((unused)), char *src __attribute__ ((unused)), size_t size __attribute__ ((unused)))
+static void workload_nop(char *dst, char *src, size_t size)
 {
 	/* Nop */
 }
@@ -596,7 +596,7 @@ static void run_expt(struct thread *threads, int runtime_secs, bool preheat)
 		pthread_join(threads[i].thread_id, NULL);
 }
 
-static void handle_alarm(int code __attribute__ ((unused)))
+static void handle_alarm(int code)
 {
 	g.cmd = STOP;
 }
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 1116ee6..6f8c563 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -388,7 +388,7 @@ int pending_interrupt(void)
  *   1. report progress
  *   2. check for deadlocks
  */
-void *reporter(void *arg __attribute__ ((unused)))
+void *reporter(void *arg)
 {
 	int status;
 	int end = 0;
@@ -1334,7 +1334,7 @@ void summary(void)
 	       t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
 }
 
-void write_stats(FILE *f, void *data __attribute__ ((unused)))
+void write_stats(FILE *f, void *data)
 {
 	fprintf(f, "  \"inversion\": %lu\n", total_inversions());
 }
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index b21dfa0..04e36a1 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -418,14 +418,13 @@ static void process_options(int argc, char *argv[])
 
 static int volatile shutdown;
 
-static void sighand(int sig __attribute__ ((unused)))
+static void sighand(int sig)
 {
 	shutdown = 1;
 }
 
-static void print_stat(FILE *fp __attribute__ ((unused)),
-		       struct params *receiver, struct params *sender,
-		       int verbose __attribute__ ((unused)), int quiet)
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
 {
 	int i;
 
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 5a29718..d211669 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -321,14 +321,13 @@ static void process_options(int argc, char *argv[])
 
 static int volatile shutdown;
 
-static void sighand(int sig __attribute__ ((unused)))
+static void sighand(int sig)
 {
 	shutdown = 1;
 }
 
-static void print_stat(FILE *fp __attribute__ ((unused)),
-		       struct params *receiver, struct params *sender,
-		       int verbose __attribute__ ((unused)), int quiet)
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
 {
 	int i;
 
diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index c057389..28cf7ab 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -520,7 +520,7 @@ void main_loop(void)
 	free(src);
 }
 
-void sig_handler(int sig __attribute__ ((unused)))
+void sig_handler(int sig)
 {
 	print_exit_info();
 	exit(0);
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 7b1917d..8afe083 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -354,7 +354,7 @@ static void print_results(void)
 	}
 }
 
-static void write_stats(FILE *f, void *data __attribute__ ((unused)))
+static void write_stats(FILE *f, void *data)
 {
 	int i;
 	int t;
@@ -489,7 +489,7 @@ static int check_times(int l)
 	return 0;
 }
 
-static void stop_log(int sig __attribute__ ((unused)))
+static void stop_log(int sig)
 {
 	stop = 1;
 }
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 631d57e..32fd0d0 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1073,7 +1073,7 @@ static int calc_nr_cpus(const char *setcpu, char **buf)
 	return -1;
 }
 
-static void sighand(int sig __attribute__ ((unused)))
+static void sighand(int sig)
 {
 	shutdown = 1;
 }
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 5412c50..d8cda97 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -353,7 +353,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 	}
 }
 
-static void sighand(int sig __attribute__ ((unused)))
+static void sighand(int sig)
 {
 	shutdown = 1;
 }
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 8c1c16f..026cc81 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -370,13 +370,13 @@ static void process_options(int argc, char *argv[])
 
 static int volatile mustshutdown;
 
-static void sighand(int sig __attribute__ ((unused)))
+static void sighand(int sig)
 {
 	mustshutdown = 1;
 }
 
 static void print_stat(struct params *receiver, struct params *sender,
-		       int verbose __attribute__ ((unused)), int quiet)
+		       int verbose, int quiet)
 {
 	int i;
 
diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 45f6a23..50f7424 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -152,7 +152,7 @@ static pid_t parent;
 static int nforks = 10;
 static int nsteps = 10000;
 
-static void sigchld(int sig __attribute__ ((unused)), siginfo_t *info __attribute__ ((unused)), void *arg __attribute__ ((unused)))
+static void sigchld(int sig, siginfo_t *info, void *arg)
 {
 	got_sigchld = 1;
 }
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 3c857dc..f3cddf8 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -416,7 +416,7 @@ static void process_options(int argc, char *argv[])
 
 static int volatile mustshutdown;
 
-static void sighand(int sig __attribute__ ((unused)))
+static void sighand(int sig)
 {
 	mustshutdown = 1;
 }
@@ -456,7 +456,8 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
-static void print_stat(FILE *fp __attribute__ ((unused)), struct params *receiver, struct params *sender, int verbose __attribute__ ((unused)), int quiet)
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
 {
 	int i;
 
-- 
2.47.1

