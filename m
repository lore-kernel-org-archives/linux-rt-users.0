From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/13] work-simple: drop a shit statement in SWORK_EVENT_PENDING
Date: Mon, 07 Jan 2019 14:52:53 -0500
Message-ID: <20190107195331.608898679@goodmis.org>
References: <20190107195252.599921907@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 22f41ebe5579cc847a7bb6c71916be92c8926216 ]

Dan Carpenter reported
| smatch warnings:
|kernel/sched/swork.c:63 swork_kthread() warn: test_bit() takes a bit number

This is not a bug because we shift by zero (and use the same value in
both places).
Nevertheless I'm dropping that shift by zero to keep smatch quiet.

Cc: Daniel Wagner <daniel.wagner@siemens.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/swork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/swork.c b/kernel/sched/swork.c
index 1950f40ca725..5559c22f664c 100644
--- a/kernel/sched/swork.c
+++ b/kernel/sched/swork.c
@@ -12,7 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
-#define SWORK_EVENT_PENDING     (1 << 0)
+#define SWORK_EVENT_PENDING     1
 
 static DEFINE_MUTEX(worker_mutex);
 static struct sworker *glob_worker;
-- 
2.19.2
