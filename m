Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803220EA5E
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Nov 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992883; cv=none; b=GKLv66YcWFsLoOiq714kyGW1/+UEiiEH6os4y9ZFUHT38U7hj0nCSDf5cAz7vxGNCzE+awu3YanrGjy9rDIst6j1nuWCxZPvlHFEbldoZ7kMnwI5ROlNmd2mzTARP2gKEgQdcAGvDz/xBWNUsZ8loxQeQqLF/fgUh78h7hHT9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992883; c=relaxed/simple;
	bh=8j0RhSoI8pvyijp+X/QSRZbBJ7XbWX3yaSNrJnPbXQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pInmJMLdgBojTL63VAk05lZede7JJysRzKAyw/3h301rBxqnARSfFBp/m9QSG07x9iGMH2il1nEHaIJvHBs1feflgyG8UQzHVtnqPV+p4TAnncuZJT31MkAJ7xJSNcpUE0oBYiYjF/5PT0EwxMmq5d7KVe/HYsJtpKz4t13lCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYMXUrEh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYMXUrEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730992880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6++3XU7pAUFZ+sbCUf4ZLaIG5nodS4ZvVVHsuBE5z3w=;
	b=cYMXUrEhYsvOrI8SP/CZKkXFwI6TWSB8qUfIh8gZF8JXmQp4dImWGvtqIq34pVPjVXhMMS
	bG+d3aRZVXrdL14L9Hr1PU0f+vpE4EW+6Od1kKV6BON5XDXNrioM3TyrGQ0HDzcxxt79YI
	ceJoainL0DLxxwGmbemDdP+IPKTrdEA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-6u2-0XgbOH6F6xtLZgf88w-1; Thu,
 07 Nov 2024 10:21:19 -0500
X-MC-Unique: 6u2-0XgbOH6F6xtLZgf88w-1
X-Mimecast-MFC-AGG-ID: 6u2-0XgbOH6F6xtLZgf88w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 584D719560AF
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Nov 2024 15:21:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA83E1955F3D;
	Thu,  7 Nov 2024 15:21:15 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/2] rt-tests: cyclictest: Support idle state disabling via libcpupower
Date: Thu,  7 Nov 2024 16:20:49 +0100
Message-ID: <20241107152049.822810-2-tglozar@redhat.com>
In-Reply-To: <20241107152049.822810-1-tglozar@redhat.com>
References: <20241107152049.822810-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 src/cyclictest/cyclictest.c | 198 +++++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1ce62cf..0eb3098 100644
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
@@ -278,6 +281,161 @@ static void set_latency_target(void)
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
@@ -840,6 +998,9 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n"
 	       "-x	 --posix_timers    use POSIX timers instead of clock_nanosleep.\n"
+	       "	 --deepest-idle-state=n\n"
+	       "                           reduce exit from idle latency by limiting idle state\n"
+	       "                           up to n on used cpus (-1 disables all idle states)\n"
 		);
 	if (error)
 		exit(EXIT_FAILURE);
@@ -861,6 +1022,7 @@ static struct bitmask *affinity_mask = NULL;
 static struct bitmask *main_affinity_mask = NULL;
 static int smp = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
+static int deepest_idle_state = -2;
 
 static int clocksources[] = {
 	CLOCK_MONOTONIC,
@@ -919,7 +1081,7 @@ enum option_values {
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
-	OPT_TRACEMARK, OPT_POSIX_TIMERS,
+	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_DEEPEST_IDLE_STATE,
 };
 
 /* Process commandline options */
@@ -975,6 +1137,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"policy",           required_argument, NULL, OPT_POLICY },
 			{"help",             no_argument,       NULL, OPT_HELP },
 			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
+			{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
 			{NULL, 0, NULL, 0 },
 		};
 		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
@@ -1175,6 +1338,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			break;
 		case OPT_TRACEMARK:
 			trace_marker = 1; break;
+		case OPT_DEEPEST_IDLE_STATE:
+			deepest_idle_state = atoi(optarg);
+			break;
 		}
 	}
 
@@ -1782,6 +1948,26 @@ int main(int argc, char **argv)
 	/* use the /dev/cpu_dma_latency trick if it's there */
 	set_latency_target();
 
+    if (deepest_idle_state >= -1) {
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
 
@@ -2147,6 +2333,16 @@ int main(int argc, char **argv)
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

