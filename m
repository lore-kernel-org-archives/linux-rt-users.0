From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/7] rtmutex: Have slowfn of rt_mutex_timed_fastlock() use enum
Date: Fri, 26 Feb 2016 16:44:14 -0500
Message-ID: <20160226214428.898614153@goodmis.org>
References: <20160226214408.590103414@goodmis.org>
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
Content-Disposition: inline; filename=0006-rtmutex-Have-slowfn-of-rt_mutex_timed_fastlock-use-e.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.77-rt111-rc1 stable review patch.
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
index 2a4c34bb586f..e836b05093a1 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1657,7 +1657,7 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
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
