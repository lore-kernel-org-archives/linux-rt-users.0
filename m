Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F122003DA
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498331; cv=none; b=UULqfqFoIg/y1B43WTrGJlLNvA429H+PuCkuqy2pd6a9pysPEqS9gjZHZND54K1+awJ3Jjk4niRUxkYzBG/Q8+tL36PSKvQq4yKN9V/xghfCjcku8vsAUawsbxAZ4dvt8+hr/eCr+jKLDlSUqeR5eM8fWekiOWwpZPU4Imikowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498331; c=relaxed/simple;
	bh=DQ5w3jX2yECFCVKiS445Kihgg8E9zaXHhZ7jkN94ye8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izxh4SCXWoaWTqlw0RLKHXg44mCuY1GPzk8QyHPp1nkLa6UJpm7FxXLzIxDNTMp7zOKbOJfjdpveYUul65lIF9Vx0r1wLTnChC5QIvW4CBr5StRCxNQycLvQl9d7vfTG3yxHObl2JDFdZskt3Um4+3fiF8QSXfSQN1ONzGWgNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhhwpEW+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhhwpEW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731498328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyJx5nAMhjg55R/VnN8BrbnmkzE4LZzAkx/bBa0AEzM=;
	b=DhhwpEW+CVCafVglh8BxphINoabyNx+jqgv8YRUKJZiPvD4JqJSfkZSWKTX7Xjq9deEzMq
	uQ1VoYiwrh8K7QhzmCCbfauJKenp3O5qpzpHWrznBSi0V1dOeFH8a3MMsAqnJsrt47uMAB
	9gycHTz6lDMZKUD5A0x5mefXPI+R5gk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-AGDWjsP5NJOj7PeX20ud-w-1; Wed,
 13 Nov 2024 06:45:27 -0500
X-MC-Unique: AGDWjsP5NJOj7PeX20ud-w-1
X-Mimecast-MFC-AGG-ID: AGDWjsP5NJOj7PeX20ud-w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75B8119540F1
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:26 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B99E19560A3;
	Wed, 13 Nov 2024 11:45:24 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling via libcpupower
Date: Wed, 13 Nov 2024 12:45:08 +0100
Message-ID: <20241113114509.1058593-3-tglozar@redhat.com>
In-Reply-To: <20241113114509.1058593-1-tglozar@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Tomas Glozar <tglozar@redhat.com>

cyclictest allows reducing latency on wake up from idle by setting
/dev/cpu_dma_latency during the measurement. This has an effect on
the idle states of all CPUs, including those which are not included
in the measurement.

Add option --deepest-idle-state that allows limiting the idle state
only on cpus where the measurement is running.

libcpupower is used to do the disabling of idle states via
the corresponding sysfs interface.

Note: The feature was first implemented for rtla-timerlat, this
implementation is based on the rtla one.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 src/cyclictest/cyclictest.c | 205 +++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1ce62cf..b1f8420 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -8,6 +8,9 @@
  * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
  *
  */
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+#include <cpuidle.h>
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -223,6 +226,8 @@ static void rstat_setup(void);
 static int latency_target_fd = -1;
 static int32_t latency_target_value = 0;
 
+static int deepest_idle_state = -2;
+
 static int rstat_ftruncate(int fd, off_t len);
 static int rstat_fd = -1;
 /* strlen("/cyclictest") + digits in max pid len + '\0' */
@@ -254,6 +259,11 @@ static void set_latency_target(void)
 		return;
 	}
 
+	if (deepest_idle_state >= -1) {
+		warn("not setting cpu_dma_latency, --deepest-idle-state is set instead\n");
+		return;
+	}
+
 	errno = 0;
 	err = stat("/dev/cpu_dma_latency", &s);
 	if (err == -1) {
@@ -278,6 +288,161 @@ static void set_latency_target(void)
 	printf("# /dev/cpu_dma_latency set to %dus\n", latency_target_value);
 }
 
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+static unsigned int **saved_cpu_idle_disable_state;
+static size_t saved_cpu_idle_disable_state_alloc_ctr;
+
+/*
+ * save_cpu_idle_state_disable - save disable for all idle states of a cpu
+ *
+ * Saves the current disable of all idle states of a cpu, to be subsequently
+ * restored via restore_cpu_idle_disable_state.
+ *
+ * Return: idle state count on success, negative on error
+ */
+static int save_cpu_idle_disable_state(unsigned int cpu)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int disabled;
+	int nr_cpus;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	if (saved_cpu_idle_disable_state == NULL) {
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
+		if (!saved_cpu_idle_disable_state)
+			return -1;
+	}
+
+	saved_cpu_idle_disable_state[cpu] = calloc(nr_states, sizeof(unsigned int));
+	if (!saved_cpu_idle_disable_state[cpu])
+		return -1;
+	saved_cpu_idle_disable_state_alloc_ctr++;
+
+	for (state = 0; state < nr_states; state++) {
+		disabled = cpuidle_is_state_disabled(cpu, state);
+		if (disabled < 0)
+			return disabled;
+		saved_cpu_idle_disable_state[cpu][state] = disabled;
+	}
+
+	return nr_states;
+}
+
+/*
+ * restore_cpu_idle_disable_state - restore disable for all idle states of a cpu
+ *
+ * Restores the current disable state of all idle states of a cpu that was
+ * previously saved by save_cpu_idle_disable_state.
+ *
+ * Return: idle state count on success, negative on error
+ */
+static int restore_cpu_idle_disable_state(unsigned int cpu)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int disabled;
+	int result;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	if (!saved_cpu_idle_disable_state)
+		return -1;
+
+	for (state = 0; state < nr_states; state++) {
+		if (!saved_cpu_idle_disable_state[cpu])
+			return -1;
+		disabled = saved_cpu_idle_disable_state[cpu][state];
+		result = cpuidle_state_disable(cpu, state, disabled);
+		if (result < 0)
+			return result;
+	}
+
+	free(saved_cpu_idle_disable_state[cpu]);
+	saved_cpu_idle_disable_state[cpu] = NULL;
+	saved_cpu_idle_disable_state_alloc_ctr--;
+	if (saved_cpu_idle_disable_state_alloc_ctr == 0) {
+		free(saved_cpu_idle_disable_state);
+		saved_cpu_idle_disable_state = NULL;
+	}
+
+	return nr_states;
+}
+
+/*
+ * free_cpu_idle_disable_states - free saved idle state disable for all cpus
+ *
+ * Frees the memory used for storing cpu idle state disable for all cpus
+ * and states.
+ *
+ * Normally, the memory is freed automatically in
+ * restore_cpu_idle_disable_state; this is mostly for cleaning up after an
+ * error.
+ */
+static void free_cpu_idle_disable_states(void)
+{
+	int cpu;
+	int nr_cpus;
+
+	if (!saved_cpu_idle_disable_state)
+		return;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		free(saved_cpu_idle_disable_state[cpu]);
+		saved_cpu_idle_disable_state[cpu] = NULL;
+	}
+
+	free(saved_cpu_idle_disable_state);
+	saved_cpu_idle_disable_state = NULL;
+}
+
+/*
+ * set_deepest_cpu_idle_state - limit idle state of cpu
+ *
+ * Disables all idle states deeper than the one given in
+ * deepest_state (assuming states with higher number are deeper).
+ *
+ * This is used to reduce the exit from idle latency. Unlike
+ * set_cpu_dma_latency, it can disable idle states per cpu.
+ *
+ * Return: idle state count on success, negative on error
+ */
+static int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_state)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int result;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	for (state = deepest_state + 1; state < nr_states; state++) {
+		result = cpuidle_state_disable(cpu, state, 1);
+		if (result < 0)
+			return result;
+	}
+
+	return nr_states;
+}
+
+static inline int have_libcpupower_support(void) { return 1; }
+#else
+static inline int save_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
+static inline int restore_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
+static inline void free_cpu_idle_disable_states(void) { }
+static inline int set_deepest_cpu_idle_state(__attribute__((unused)) unsigned int cpu,
+											 __attribute__((unused)) unsigned int state) { return -1; }
+static inline int have_libcpupower_support(void) { return 0; }
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 
 enum {
 	ERROR_GENERAL	= -1,
@@ -779,6 +944,10 @@ static void display_help(int error)
 	       "-c CLOCK --clock=CLOCK     select clock\n"
 	       "                           0 = CLOCK_MONOTONIC (default)\n"
 	       "                           1 = CLOCK_REALTIME\n"
+	       "         --deepest-idle-state=n\n"
+	       "                           Reduce exit from idle latency by limiting idle state\n"
+	       "                           up to n on used cpus (-1 disables all idle states).\n"
+	       "                           Power management is not suppresed on other cpus.\n"
 	       "         --default-system  Don't attempt to tune the system from cyclictest.\n"
 	       "                           Power management is not suppressed.\n"
 	       "                           This might give poorer results, but will allow you\n"
@@ -919,7 +1088,7 @@ enum option_values {
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
-	OPT_TRACEMARK, OPT_POSIX_TIMERS,
+	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_DEEPEST_IDLE_STATE,
 };
 
 /* Process commandline options */
@@ -975,6 +1144,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"policy",           required_argument, NULL, OPT_POLICY },
 			{"help",             no_argument,       NULL, OPT_HELP },
 			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
+			{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
 			{NULL, 0, NULL, 0 },
 		};
 		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
@@ -1175,6 +1345,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			break;
 		case OPT_TRACEMARK:
 			trace_marker = 1; break;
+		case OPT_DEEPEST_IDLE_STATE:
+			deepest_idle_state = atoi(optarg);
+			break;
 		}
 	}
 
@@ -1782,6 +1955,26 @@ int main(int argc, char **argv)
 	/* use the /dev/cpu_dma_latency trick if it's there */
 	set_latency_target();
 
+	if (deepest_idle_state >= -1) {
+		if (!have_libcpupower_support()) {
+			fprintf(stderr, "cyclictest built without libcpupower, --deepest-idle-state is not supported\n");
+			goto out;
+		}
+
+		for (i = 0; i < max_cpus; i++) {
+			if (affinity_mask && !numa_bitmask_isbitset(affinity_mask, i))
+				continue;
+			if (save_cpu_idle_disable_state(i) < 0) {
+				fprintf(stderr, "Could not save cpu idle state.\n");
+				goto out;
+			}
+			if (set_deepest_cpu_idle_state(i, deepest_idle_state) < 0) {
+				fprintf(stderr, "Could not set deepest cpu idle state.\n");
+				goto out;
+			}
+		}
+	}
+
 	if (tracelimit && trace_marker)
 		enable_trace_mark();
 
@@ -2147,6 +2340,16 @@ int main(int argc, char **argv)
 	if (latency_target_fd >= 0)
 		close(latency_target_fd);
 
+	/* restore and free cpu idle disable states */
+	if (deepest_idle_state >= -1) {
+		for (i = 0; i < max_cpus; i++) {
+			if (affinity_mask && !numa_bitmask_isbitset(affinity_mask, i))
+				continue;
+			restore_cpu_idle_disable_state(i);
+		}
+	}
+	free_cpu_idle_disable_states();
+
 	if (affinity_mask)
 		rt_bitmask_free(affinity_mask);
 
-- 
2.47.0

