From: "Gary S. Robertson" <gary.robertson@linaro.org>
Subject: [PATCH 1/2] Restore CPU affinity function for non-NUMA builds
Date: Tue, 25 Mar 2014 18:05:31 -0500
Message-ID: <1395788732-7311-2-git-send-email-gary.robertson@linaro.org>
References: <1395788732-7311-1-git-send-email-gary.robertson@linaro.org>
Cc: "Gary S. Robertson" <gary.robertson@linaro.org>
To: clark.williams@gmail.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:42961 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbaCYXGY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Mar 2014 19:06:24 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so1324457yhz.36
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Mar 2014 16:06:23 -0700 (PDT)
In-Reply-To: <1395788732-7311-1-git-send-email-gary.robertson@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Gary S. Robertson" <gary.robertson@linaro.org>

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 src/cyclictest/rt_numa.h |  188 +++++++++++++++++++++++++++++-----------------
 1 file changed, 119 insertions(+), 69 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 31a2b16..13f5140 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -6,6 +6,12 @@
  * They should also work correctly with older versions of the numactl lib
  * such as the one found on RHEL5, or with the newer version 2 and above.
  *
+ * The difference in behavior hinges on whether LIBNUMA_API_VERSION >= 2,
+ * in which case we will employ the bitmask affinity behavior -or-
+ * either LIBNUMA_API_VERSION < 2 or NUMA support is missing altogether,
+ * in which case we retain the older affinity behavior which can either
+ * specify a single CPU core or else use all cores.
+ *
  * (C) 2010 John Kacur <jkacur@redhat.com>
  * (C) 2010 Clark Williams <williams@redhat.com>
  *
@@ -19,19 +25,17 @@
 
 static int numa = 0;
 
-#ifdef NUMA
-#include <numa.h>
-
-#ifndef LIBNUMA_API_VERSION
-#define LIBNUMA_API_VERSION 1
-#endif
-
-#if LIBNUMA_API_VERSION < 2
 struct bitmask {
 	unsigned long size; /* number of bits in the map */
 	unsigned long *maskp;
 };
 #define BITS_PER_LONG	(8*sizeof(long))
+
+#ifdef NUMA
+#include <numa.h>
+
+#ifndef LIBNUMA_API_VERSION
+#define LIBNUMA_API_VERSION 1
 #endif
 
 static void *
@@ -61,13 +65,21 @@ static void rt_numa_set_numa_run_on_node(int node, int cpu)
 	return;
 }
 
-static void numa_on_and_available()
+static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
 {
-	if (numa && numa_available() == -1)
-		fatal("--numa specified and numa functions not available.\n");
+	void *stack;
+	stack = numa_alloc_onnode(size, node);
+	if (stack == NULL)
+		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
+				size, node, cpu);
+	return stack;
 }
 
 #if LIBNUMA_API_VERSION >= 2
+
+/*
+ * Use new bit mask CPU affinity behavior
+ */
 static int rt_numa_numa_node_of_cpu(int cpu)
 {
 	int node;
@@ -77,8 +89,38 @@ static int rt_numa_numa_node_of_cpu(int cpu)
 	return node;
 }
 
+static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
+	unsigned long i)
+{
+	return numa_bitmask_isbitset(mask,i);
+}
+
+static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
+	int max_cpus) 
+{
+#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
+					   autotools build. */
+	return numa_parse_cpustring_all(s);
+#else
+	/* We really need numa_parse_cpustring_all(), so we can assign threads
+	 * to cores which are part of an isolcpus set, but early 2.x versions of
+	 * libnuma do not have this function.  A work around should be to run
+	 * your command with e.g. taskset -c 9-15 <command>
+	 */
+	return numa_parse_cpustring(s);
+#endif 
+}
+
+static inline void rt_bitmask_free(struct bitmask *mask)
+{
+	numa_bitmask_free(mask);
+}
+
 #else	/* LIBNUMA_API_VERSION == 1 */
 
+/*
+ * Map legacy CPU affinity behavior onto bit mask infrastructure
+ */
 static int rt_numa_numa_node_of_cpu(int cpu)
 {
 	unsigned char cpumask[256];
@@ -108,60 +150,16 @@ static int rt_numa_numa_node_of_cpu(int cpu)
 	return -1;
 }
 
-#endif	/* LIBNUMA_API_VERSION */
-
-static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
-{
-	void *stack;
-	stack = numa_alloc_onnode(size, node);
-	if (stack == NULL)
-		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
-				size, node, cpu);
-	return stack;
-}
-
-
 static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
 	unsigned long i)
 {
-#if LIBNUMA_API_VERSION >= 2
-	return numa_bitmask_isbitset(mask,i);
-#else
 	long bit = mask->maskp[i/BITS_PER_LONG] & (1<<(i % BITS_PER_LONG));
 	return (bit != 0);
-#endif
-}
-
-/** Returns number of bits set in mask. */
-static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
-{
-	unsigned int num_bits = 0, i;
-	for (i = 0; i < mask->size; i++) {
-		if (rt_numa_bitmask_isbitset(mask, i))
-			num_bits++;
-	}
-	/* Could stash this instead of recomputing every time. */
-	return num_bits;
 }
 
 static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
 	int max_cpus) 
 {
-#if LIBNUMA_API_VERSION >= 2
-
-#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
-					   autotools build. */
-	return numa_parse_cpustring_all(s);
-#else
-	/* We really need numa_parse_cpustring_all(), so we can assign threads
-	 * to cores which are part of an isolcpus set, but early 2.x versions of
-	 * libnuma do not have this function.  A work around should be to run
-	 * your command with e.g. taskset -c 9-15 <command>
-	 */
-	return numa_parse_cpustring(s);
-#endif 
-
-#else /* LIBNUMA_API_VERSION == 1 */
 	int cpu;
 	struct bitmask *mask = NULL;
 	cpu = atoi(s);
@@ -184,35 +182,87 @@ static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
 		}
 	}
 	return mask;
-#endif
 }
 
 static inline void rt_bitmask_free(struct bitmask *mask)
 {
-#if LIBNUMA_API_VERSION >= 2
-	numa_bitmask_free(mask);
-#else /* LIBNUMA_API_VERSION == 1 */
 	free(mask->maskp);
 	free(mask);
-#endif
 }
 
+#endif	/* LIBNUMA_API_VERSION */
+
 #else /* ! NUMA */
-struct bitmask { };
 static inline void *threadalloc(size_t size, int n) { return malloc(size); }
 static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
 static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
-static inline void numa_on_and_available() { };
 static inline int rt_numa_numa_node_of_cpu(int cpu) { return -1; }
 static void *rt_numa_numa_alloc_onnode(size_t s, int n, int c) { return NULL; }
-static inline unsigned int rt_numa_bitmask_isbitset(
-	const struct bitmask *affinity_mask, unsigned long i) { return 0; }
-static inline struct bitmask* rt_numa_parse_cpustring(const char* s, int m) 
-{ return NULL; }
-static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
-{ return 0; }
-static inline void rt_bitmask_free(struct bitmask *mask) { return; }
+
+/*
+ * Map legacy CPU affinity behavior onto bit mask infrastructure
+ */
+static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
+	unsigned long i)
+{
+	long bit = mask->maskp[i/BITS_PER_LONG] & (1<<(i % BITS_PER_LONG));
+	return (bit != 0);
+}
+
+static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
+	int max_cpus) 
+{
+	int cpu;
+	struct bitmask *mask = NULL;
+	cpu = atoi(s);
+	if (0 <= cpu && cpu < max_cpus) {
+		mask = malloc(sizeof(*mask));
+		if (mask) {
+			/* Round up to integral number of longs to contain
+			 * max_cpus bits */
+			int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
+
+			mask->maskp = calloc(nlongs, sizeof(long));
+			if (mask->maskp) {
+				mask->maskp[cpu/BITS_PER_LONG] |=
+					(1UL << (cpu % BITS_PER_LONG));
+				mask->size = max_cpus;
+			} else {
+				free(mask);
+				mask = NULL;
+			}
+		}
+	}
+	return mask;
+}
+
+static inline void rt_bitmask_free(struct bitmask *mask)
+{
+	free(mask->maskp);
+	free(mask);
+}
 
 #endif	/* NUMA */
 
+/*
+ * Any behavioral differences above are transparent to these functions
+ */
+static void numa_on_and_available()
+{
+	if (numa && (numa_available() == -1))
+		fatal("--numa specified and numa functions not available.\n");
+}
+
+/** Returns number of bits set in mask. */
+static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
+{
+	unsigned int num_bits = 0, i;
+	for (i = 0; i < mask->size; i++) {
+		if (rt_numa_bitmask_isbitset(mask, i))
+			num_bits++;
+	}
+	/* Could stash this instead of recomputing every time. */
+	return num_bits;
+}
+
 #endif	/* _RT_NUMA_H */
-- 
1.7.9.5

