From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/1] cyclictest: Allow passing a list of cpus to affine
 threads to
Date: Thu, 13 Nov 2014 12:12:48 -0300
Message-ID: <20141113151248.GB3612@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44272 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbaKMPzu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Nov 2014 10:55:50 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For testing, for instance, running one thread per cpu in a CPU socket,
testing isolation of groups of cores that share memory cache.

[root@emilia ~]# ~acme/bin/cyclictest -nmu -p95 -a 1,3,5,7
policy: fifo: loadavg: 0.00 0.17 2.48 2/409 25640

T: 0 (25636) P:95 I:1000 C:  15503 Min:   4 Act:  4 Avg:  4 Max:  8
T: 1 (25637) P:95 I:1500 C:  10331 Min:   4 Act:  4 Avg:  4 Max:  7
T: 2 (25638) P:95 I:2000 C:   7745 Min:   4 Act:  4 Avg:  4 Max:  8
T: 3 (25639) P:95 I:2500 C:   6193 Min:   3 Act:  4 Avg:  4 Max:  8

[root@emilia ~]# tuna -t cyclictest -CP
                      thread       ctxt_switches
    pid SCHED_ rtpri affinity voluntary nonvoluntary            cmd
 25635    FIFO     2  0,2,4,6       449           16     cyclictest
  25636   FIFO    95        1      4471            1     cyclictest
  25637   FIFO    95        3      2977            1     cyclictest
  25638   FIFO    95        5      2230            1     cyclictest
  25639   FIFO    95        7      1782            1     cyclictest
[root@emilia ~]#

And generally to allow starting multiple threads spread over non
contiguous CPUs.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 src/cyclictest/cyclictest.8 |    3 ++-
 src/cyclictest/cyclictest.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index fbb6174..fc76e31 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -34,7 +34,8 @@ A summary of options is included below.
 .\" For a complete description, see the Info files.
 .TP
 .B \-a, \-\-affinity[=PROC]
-Run all threads on procesor number PROC. If PROC is not specified, run thread #N on processor #N.
+Run all threads on procesor number PROC. If PROC is not specified, run thread #N on processor #N. If a CSV PROC list is specified, start a thread on each,
+for starting multiple threads on non-contiguous (enumeration) CPUs.
 .TP
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 11b6cea..26ba18f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -980,11 +980,13 @@ static int quiet;
 static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
 static int affinity = 0;
+static int *affinities;
 static int smp = 0;
 
 enum {
 	AFFINITY_UNSPECIFIED,
 	AFFINITY_SPECIFIED,
+	AFFINITY_SPECIFIED_LIST,
 	AFFINITY_USEALL
 };
 static int setaffinity = AFFINITY_UNSPECIFIED;
@@ -1034,6 +1036,33 @@ static char *policyname(int policy)
 	return policystr;
 }
 
+static int read_affinities(char *list, int max_cpus)
+{
+	char *token = list;
+
+	affinities = malloc(sizeof(int) * max_cpus);
+
+	if (affinities == NULL)
+		return -1;
+
+	num_threads = 0;
+
+	do {
+		affinities[num_threads] = atoi(token);
+		if (affinities[num_threads] >= max_cpus)
+			return -1;
+		token = strchr(token, ',');
+		if (++num_threads > max_cpus)
+			goto out_free;
+	} while (token++ != NULL);
+
+	return 0;
+out_free:
+	free(affinities);
+	affinities = NULL;
+	return -1;
+}
+
 
 /* Process commandline options */
 static void process_options (int argc, char *argv[])
@@ -1097,6 +1126,10 @@ static void process_options (int argc, char *argv[])
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind<argc && strstr(argv[optind], ",")) {
+				if (read_affinities(argv[optind], max_cpus))
+					fatal("invalid affinity list\n");
+				setaffinity = AFFINITY_SPECIFIED_LIST;
 			} else if (optind<argc && atoi(argv[optind])) {
 				affinity = atoi(argv[optind]);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -1588,6 +1621,7 @@ int main(int argc, char **argv)
 		switch (setaffinity) {
 		case AFFINITY_UNSPECIFIED: par->cpu = -1; break;
 		case AFFINITY_SPECIFIED: par->cpu = affinity; break;
+		case AFFINITY_SPECIFIED_LIST: par->cpu = affinities[i]; break;
 		case AFFINITY_USEALL: par->cpu = i % max_cpus; break;
 		}
 		stat->min = 1000000;
-- 
1.7.1

