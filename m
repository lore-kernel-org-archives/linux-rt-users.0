From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 5/9] work-simple: drop a shit statement in SWORK_EVENT_PENDING
Date: Fri, 21 Dec 2018 09:21:17 -0600
Message-ID: <eee0dde6de03de4a7adfe1119c9a2575d8109df5.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

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
[ tom.zanussi: applied to work-simple.c instead of swork.c ]
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/sched/work-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
index c996f755dba6..4284dd37aebe 100644
--- a/kernel/sched/work-simple.c
+++ b/kernel/sched/work-simple.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#define SWORK_EVENT_PENDING     (1 << 0)
+#define SWORK_EVENT_PENDING     1
 
 static DEFINE_MUTEX(worker_mutex);
 static struct sworker *glob_worker;
-- 
2.14.1
