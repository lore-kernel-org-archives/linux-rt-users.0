From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 33/39] fs/aio: simple simple work
Date: Thu, 12 Mar 2015 15:13:40 -0400
Message-ID: <20150312191412.453854040@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Benjamin LaHaise <bcrl@kvack.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0033-fs-aio-simple-simple-work.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:768
|in_atomic(): 1, irqs_disabled(): 0, pid: 26, name: rcuos/2
|2 locks held by rcuos/2/26:
| #0:  (rcu_callback){.+.+..}, at: [<ffffffff810b1a12>] rcu_nocb_kthread+0x1e2/0x380
| #1:  (rcu_read_lock_sched){.+.+..}, at: [<ffffffff812acd26>] percpu_ref_kill_rcu+0xa6/0x1c0
|Preemption disabled at:[<ffffffff810b1a93>] rcu_nocb_kthread+0x263/0x380
|Call Trace:
| [<ffffffff81582e9e>] dump_stack+0x4e/0x9c
| [<ffffffff81077aeb>] __might_sleep+0xfb/0x170
| [<ffffffff81589304>] rt_spin_lock+0x24/0x70
| [<ffffffff811c5790>] free_ioctx_users+0x30/0x130
| [<ffffffff812ace34>] percpu_ref_kill_rcu+0x1b4/0x1c0
| [<ffffffff810b1a93>] rcu_nocb_kthread+0x263/0x380
| [<ffffffff8106e046>] kthread+0xd6/0xf0
| [<ffffffff81591eec>] ret_from_fork+0x7c/0xb0

replace this preempt_disable() friendly swork.

Cc: stable-rt@vger.kernel.org
Reported-By: Mike Galbraith <umgwanakikbuti@gmail.com>
Suggested-by: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/aio.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2f7e8c2e3e76..5cddcbfe1b71 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -40,6 +40,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/work-simple.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -110,7 +111,7 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct work_struct	free_work;
+	struct swork_event	free_work;
 
 	/*
 	 * signals when all in-flight requests are done
@@ -227,6 +228,7 @@ static int __init aio_setup(void)
 		.mount		= aio_mount,
 		.kill_sb	= kill_anon_super,
 	};
+	BUG_ON(swork_get());
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
@@ -506,9 +508,9 @@ static int kiocb_cancel(struct kioctx *ctx, struct kiocb *kiocb)
 	return cancel(kiocb);
 }
 
-static void free_ioctx(struct work_struct *work)
+static void free_ioctx(struct swork_event *sev)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
+	struct kioctx *ctx = container_of(sev, struct kioctx, free_work);
 
 	pr_debug("freeing %p\n", ctx);
 
@@ -525,8 +527,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 	if (ctx->requests_done)
 		complete(ctx->requests_done);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	INIT_SWORK(&ctx->free_work, free_ioctx);
+	swork_queue(&ctx->free_work);
 }
 
 /*
@@ -534,9 +536,9 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
  * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
  * now it's safe to cancel any that need to be.
  */
-static void free_ioctx_users(struct percpu_ref *ref)
+static void free_ioctx_users_work(struct swork_event *sev)
 {
-	struct kioctx *ctx = container_of(ref, struct kioctx, users);
+	struct kioctx *ctx = container_of(sev, struct kioctx, free_work);
 	struct kiocb *req;
 
 	spin_lock_irq(&ctx->ctx_lock);
@@ -555,6 +557,14 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	percpu_ref_put(&ctx->reqs);
 }
 
+static void free_ioctx_users(struct percpu_ref *ref)
+{
+	struct kioctx *ctx = container_of(ref, struct kioctx, users);
+
+	INIT_SWORK(&ctx->free_work, free_ioctx_users_work);
+	swork_queue(&ctx->free_work);
+}
+
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
 	unsigned i, new_nr;
-- 
2.1.4
