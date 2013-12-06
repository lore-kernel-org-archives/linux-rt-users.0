From: Aaron Fabbri <ajfabbri@gmail.com>
Subject: [patch] cyclictest: CPU affinity now takes arbitrary set of cpus.
Date: Thu, 5 Dec 2013 16:29:37 -0800
Message-ID: <CAF+KLxtyOC7jWcnr1XoF6Su3LeywYpVq5Sac258mUJ9hGrEtKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60031 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3LFA3i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 19:29:38 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so25799426pdj.29
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Dec 2013 16:29:37 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[This patch is rebased on latest rt-tests.git, and is available in the
"delivery" branch at https://github.com/ajfabbri/af-rt-tests.git]

Change -a (affinity) option to take a set of CPUs, instead of just one.

e.g.
  cyclictest -a4,6-8 -t5

will use 5 threads, assigned round-robin to the set of CPUs {4,6,7,8}.
CPU 4 will get threads 1 and 5, CPU 6 gets thread 2, CPU 7 gets thread 3, and
CPU 8 gets thread 4.

Although this builds without libnuma,  libnuma >= v2 is required for these
arbitrary CPU sets.  With libnuma v1, the -a option behaves as before.  As
before, compiling without libnuma is supported. The command usage help is fixed
up at compile time to always show the correct usage of the -a option.

Also note that, since numa_parse_cpustring_all() wasn't available in early
libnuma v2 versions, we use numa_parse_cpustring().  This means you'll have to
use taskset in some cases (isolcpus kernel parameter) to add the desired CPUs to
the set of allowed cores, e.g.:

  taskset -c4-6 cyclictest -a4-6

Tested without libnuma (numactl), and with versions 1.0.2 and 2.0.9-rc3.

Signed-off-by: Aaron Fabbri <ajfabbri@gmail.com>
---
 src/cyclictest/cyclictest.8 | 19 +++++++---
 src/cyclictest/cyclictest.c | 92 ++++++++++++++++++++++++++++++++++++---------
 src/cyclictest/rt_numa.h    | 92 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 22 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 60102df..4e169aa 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -33,8 +33,18 @@ options starting with two dashes ('\-\-').
 A summary of options is included below.
 .\" For a complete description, see the Info files.
 .TP
-.B \-a, \-\-affinity[=PROC]
-Run all threads on procesor number PROC. If PROC is not specified,
run thread #N on processor #N.
+.B \-a, \-\-affinity[=PROC-SET]
+Run threads on the set of procesors given by PROC-SET.  If PROC-SET is not
+specified, all processors will be used.  Threads will be assigned to processors
+in the set in numeric order, in a round-robin fashion.
+.br
+The set of processors can be specified as A,B,C, or A-C, or A-B,D-F,
and so on*.
+The ! character can be used to negate a set.  For example, !B-D means
to use all
+available CPUs except B through D.  The cpu numbers are the same as
shown in the
+.I processor
+field in /proc/cpuinfo.  See numa(3) for more information on
specifying CPU sets.
+* Support for CPU sets requires libnuma version >= 2.  For libnuma
v1, PROC-SET,
+if specified, must be a single CPU number.
 .TP
 .B \-A, \-\-align=USEC
 Align measurement thread wakeups to a specific offset in microseconds
@@ -178,9 +188,8 @@ memory allocations using the numa(3) policy
library. Thread stacks and
 data structures are allocated from the NUMA node local to the core to
 which the thread is bound. Requires the underlying kernel to have NUMA
 support compiled in.
-.\" .SH SEE ALSO
-.\" .BR bar (1),
-.\" .BR baz (1).
+.SH SEE ALSO
+.BR numactl (8),
 .\" .br
 .\" The programs are documented fully by
 .\" .IR "The Rise and Fall of a Fooish Bar" ,
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7ca621b..ca3286f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -975,9 +975,18 @@ static void display_help(int error)
        printf("cyclictest V %1.2f\n", VERSION_STRING);
        printf("Usage:\n"
               "cyclictest <options>\n\n"
+#if LIBNUMA_API_VERSION >= 2
+              "-a [CPUSET] --affinity     Run thread #N on processor
#N, if possible, or if CPUSET\n"
+              "                           given, pin threads to that
set of processors in round-\n"
+              "                           robin order.  E.g. -a 2
pins all threads to CPU 2,\n"
+              "                           but -a 3-5,0 -t 5 will run
the first and fifth\n"
+              "                           threads on CPU (0),thread
#2 on CPU 3, thread #3\n"
+              "                           on CPU 4, and thread #5 on CPU 5.\n"
+#else
               "-a [NUM] --affinity        run thread #N on processor
#N, if possible\n"
               "                           with NUM pin all threads to
the processor NUM\n"
               "-A USEC  --aligned=USEC    align thread wakeups to a
specific offset\n"
+#endif
               "-b USEC  --breaktrace=USEC send break trace command
when latency > USEC\n"
               "-B       --preemptirqs     both preempt and irqsoff
tracing (used with -b)\n"
               "-c CLOCK --clock=CLOCK     select clock\n"
@@ -1050,7 +1059,7 @@ static int clocksel = 0;
 static int quiet;
 static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
-static int affinity = 0;
+static struct bitmask *affinity_mask = NULL;
 static int smp = 0;

 enum {
@@ -1065,6 +1074,50 @@ static int clocksources[] = {
        CLOCK_REALTIME,
 };

+static unsigned int is_cpumask_zero(const struct bitmask *mask)
+{
+       return (rt_numa_bitmask_count(mask) == 0);
+}
+
+static int cpu_for_thread(int thread_num, int max_cpus)
+{
+       unsigned int m, cpu, i, num_cpus;
+       num_cpus = rt_numa_bitmask_count(affinity_mask);
+
+       m = thread_num % num_cpus;
+
+       /* there are num_cpus bits set, we want position of m'th one */
+       for (i = 0, cpu = 0; i < max_cpus; i++) {
+               if (rt_numa_bitmask_isbitset(affinity_mask, i)) {
+                       if (cpu == m)
+                               return i;
+                       cpu++;
+               }
+       }
+       fprintf(stderr, "Bug in cpu mask handling code.\n");
+       return 0;
+}
+
+
+static void parse_cpumask(const char *option, const int max_cpus)
+{
+       affinity_mask = rt_numa_parse_cpustring(option, max_cpus);
+       if (affinity_mask) {
+               if (is_cpumask_zero(affinity_mask)) {
+                       rt_bitmask_free(affinity_mask);
+                       affinity_mask = NULL;
+               }
+       }
+       if (!affinity_mask)
+               display_help(1);
+
+       if (verbose) {
+               printf("%s: Using %u cpus.\n", __func__,
+                       rt_numa_bitmask_count(affinity_mask));
+       }
+}
+
+
 static void handlepolicy(char *polname)
 {
        if (strncasecmp(polname, "other", 5) == 0)
@@ -1119,11 +1172,10 @@ enum option_values {
 };

 /* Process commandline options */
-static void process_options (int argc, char *argv[])
+static void process_options (int argc, char *argv[], int max_cpus)
 {
        int error = 0;
        int option_affinity = 0;
-       int max_cpus = sysconf(_SC_NPROCESSORS_CONF);

        for (;;) {
                int option_index = 0;
@@ -1187,10 +1239,10 @@ static void process_options (int argc, char *argv[])
                        if (smp || numa)
                                break;
                        if (optarg != NULL) {
-                               affinity = atoi(optarg);
+                               parse_cpumask(optarg, max_cpus);
                                setaffinity = AFFINITY_SPECIFIED;
                        } else if (optind<argc && atoi(argv[optind])) {
-                               affinity = atoi(argv[optind]);
+                               parse_cpumask(argv[optind], max_cpus);
                                setaffinity = AFFINITY_SPECIFIED;
                        } else {
                                setaffinity = AFFINITY_USEALL;
@@ -1389,15 +1441,7 @@ static void process_options (int argc, char *argv[])
                }
        }

-       if (setaffinity == AFFINITY_SPECIFIED) {
-               if (affinity < 0)
-                       error = 1;
-               if (affinity >= max_cpus) {
-                       warn("CPU #%d not found, only %d CPUs available\n",
-                           affinity, max_cpus);
-                       error = 1;
-               }
-       } else if (tracelimit)
+       if (tracelimit)
                fileprefix = procfileprefix;

        if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
@@ -1450,8 +1494,11 @@ static void process_options (int argc, char *argv[])
                pthread_barrier_init(&align_barr, NULL, num_threads);
        }

-       if (error)
+       if (error) {
+               if (affinity_mask)
+                       rt_bitmask_free(affinity_mask);
                display_help(1);
+       }
 }

 static int check_kernel(void)
@@ -1693,11 +1740,14 @@ int main(int argc, char **argv)
        int i, ret = -1;
        int status;

-       process_options(argc, argv);
+       process_options(argc, argv, max_cpus);

        if (check_privs())
                exit(EXIT_FAILURE);

+       if (verbose)
+               printf("Max CPUs = %d\n", max_cpus);
+
        /* Checks if numa is on, program exits if numa on but not available */
        numa_on_and_available();

@@ -1929,7 +1979,12 @@ int main(int argc, char **argv)
                par->tnum = i;
                switch (setaffinity) {
                case AFFINITY_UNSPECIFIED: par->cpu = -1; break;
-               case AFFINITY_SPECIFIED: par->cpu = affinity; break;
+               case AFFINITY_SPECIFIED:
+                       par->cpu = cpu_for_thread(i, max_cpus);
+                       if (verbose)
+                               printf("Thread %d using cpu %d.\n", i,
+                                       par->cpu);
+                       break;
                case AFFINITY_USEALL: par->cpu = i % max_cpus; break;
                }
                stat->min = 1000000;
@@ -2073,5 +2128,8 @@ int main(int argc, char **argv)
        if (latency_target_fd >= 0)
                close(latency_target_fd);

+       if (affinity_mask)
+               rt_bitmask_free(affinity_mask);
+
        exit(ret);
 }
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 4ae10ee..31a2b16 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -26,6 +26,14 @@ static int numa = 0;
 #define LIBNUMA_API_VERSION 1
 #endif

+#if LIBNUMA_API_VERSION < 2
+struct bitmask {
+       unsigned long size; /* number of bits in the map */
+       unsigned long *maskp;
+};
+#define BITS_PER_LONG  (8*sizeof(long))
+#endif
+
 static void *
 threadalloc(size_t size, int node)
 {
@@ -112,14 +120,98 @@ static void *rt_numa_numa_alloc_onnode(size_t
size, int node, int cpu)
        return stack;
 }

+
+static inline unsigned int rt_numa_bitmask_isbitset( const struct
bitmask *mask,
+       unsigned long i)
+{
+#if LIBNUMA_API_VERSION >= 2
+       return numa_bitmask_isbitset(mask,i);
+#else
+       long bit = mask->maskp[i/BITS_PER_LONG] & (1<<(i % BITS_PER_LONG));
+       return (bit != 0);
+#endif
+}
+
+/** Returns number of bits set in mask. */
+static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
+{
+       unsigned int num_bits = 0, i;
+       for (i = 0; i < mask->size; i++) {
+               if (rt_numa_bitmask_isbitset(mask, i))
+                       num_bits++;
+       }
+       /* Could stash this instead of recomputing every time. */
+       return num_bits;
+}
+
+static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
+       int max_cpus)
+{
+#if LIBNUMA_API_VERSION >= 2
+
+#ifdef HAVE_PARSE_CPUSTRING_ALL                /* Currently not
defined anywhere.  No
+                                          autotools build. */
+       return numa_parse_cpustring_all(s);
 #else
+       /* We really need numa_parse_cpustring_all(), so we can assign threads
+        * to cores which are part of an isolcpus set, but early 2.x versions of
+        * libnuma do not have this function.  A work around should be to run
+        * your command with e.g. taskset -c 9-15 <command>
+        */
+       return numa_parse_cpustring(s);
+#endif
+
+#else /* LIBNUMA_API_VERSION == 1 */
+       int cpu;
+       struct bitmask *mask = NULL;
+       cpu = atoi(s);
+       if (0 <= cpu && cpu < max_cpus) {
+               mask = malloc(sizeof(*mask));
+               if (mask) {
+                       /* Round up to integral number of longs to contain
+                        * max_cpus bits */
+                       int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
+
+                       mask->maskp = calloc(nlongs, sizeof(long));
+                       if (mask->maskp) {
+                               mask->maskp[cpu/BITS_PER_LONG] |=
+                                       (1UL << (cpu % BITS_PER_LONG));
+                               mask->size = max_cpus;
+                       } else {
+                               free(mask);
+                               mask = NULL;
+                       }
+               }
+       }
+       return mask;
+#endif
+}
+
+static inline void rt_bitmask_free(struct bitmask *mask)
+{
+#if LIBNUMA_API_VERSION >= 2
+       numa_bitmask_free(mask);
+#else /* LIBNUMA_API_VERSION == 1 */
+       free(mask->maskp);
+       free(mask);
+#endif
+}

+#else /* ! NUMA */
+struct bitmask { };
 static inline void *threadalloc(size_t size, int n) { return malloc(size); }
 static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
 static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
 static inline void numa_on_and_available() { };
 static inline int rt_numa_numa_node_of_cpu(int cpu) { return -1; }
 static void *rt_numa_numa_alloc_onnode(size_t s, int n, int c) { return NULL; }
+static inline unsigned int rt_numa_bitmask_isbitset(
+       const struct bitmask *affinity_mask, unsigned long i) { return 0; }
+static inline struct bitmask* rt_numa_parse_cpustring(const char* s, int m)
+{ return NULL; }
+static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
+{ return 0; }
+static inline void rt_bitmask_free(struct bitmask *mask) { return; }

 #endif /* NUMA */

--
1.8.1.2
