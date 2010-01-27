From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/5] rt-tests: Separate the #ifdef LIBNUMA_API_VERSION functions.
Date: Wed, 27 Jan 2010 21:24:25 +0100
Message-ID: <1264623868-23595-3-git-send-email-jkacur@redhat.com>
References: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Carsten Emde <C.Emde@osadl.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755266Ab0A0UZs@vger.kernel.org>
In-Reply-To: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Separate the #ifdef LIBNUMA_API_VERSION of function rt_numa_numa_node_of_cpu,
it is slightly cleaner this way.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 14837ff..8d44097 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -58,15 +58,20 @@ static void numa_on_and_available()
 		fatal("--numa specified and numa functions not available.\n");
 }
 
+#if LIBNUMA_API_VERSION >= 2
 static int rt_numa_numa_node_of_cpu(int cpu)
 {
-#if LIBNUMA_API_VERSION >= 2
 	int node;
 	node = numa_node_of_cpu(cpu);
 	if (node == -1)
 		fatal("invalid cpu passed to numa_node_of_cpu(%d)\n", cpu);
 	return node;
-#else
+}
+
+#else	/* LIBNUMA_API_VERSION == 1 */
+
+static int rt_numa_numa_node_of_cpu(int cpu)
+{
 	unsigned char cpumask[16];
         int node, ret, idx, bit;
 	int max_node, max_cpus;
@@ -96,10 +101,10 @@ static int rt_numa_numa_node_of_cpu(int cpu)
         errno = EINVAL;
 end:
         return ret;
-
-#endif
 }
 
+#endif	/* LIBNUMA_API_VERSION */
+
 static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
 {
 	void *stack;
-- 
1.6.6
