From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/10] rtmutex: Have slowfn of rt_mutex_timed_fastlock() use enum
Date: Fri, 26 Feb 2016 16:41:09 -0500
Message-ID: <20160226214120.498049504@goodmis.org>
References: <20160226214100.390136141@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-rtmutex-Have-slowfn-of-rt_mutex_timed_fastlock-use-e.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.97-rt106-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The backport of commit 8930ed80f970 "rtmutex: Cleanup deadlock detector
debug logic" had conflicts, and the conflict resolution changed
rt_mutex_timed_fastlock()'s parameter to an enum, but missed changing its
slowfn's prototype.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 8c29e48afa3a..a809539f443c 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1636,7 +1636,7 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 			enum rtmutex_chainwalk chwalk,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock))
+				      enum rtmutex_chainwalk chwalk))
 {
 	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
 	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
-- 
2.7.0
