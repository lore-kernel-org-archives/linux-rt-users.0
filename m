From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH V2] rt/aio: fix rcu garbage collection might_sleep()
 splat
Date: Mon, 16 Feb 2015 18:59:10 +0100
Message-ID: <20150216175910.GH21649@linutronix.de>
References: <1402216538.31630.7.camel@marge.simpson.net>
 <5395172E.4010007@cn.fujitsu.com>
 <1402372048.5124.20.camel@marge.simpson.net>
 <20140610175001.GF27015@kvack.org>
 <20140612202602.GI10871@kmo-pixel>
 <20140625152445.GS23137@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kent Overstreet <kmo@daterainc.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140625152445.GS23137@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Benjamin LaHaise | 2014-06-25 11:24:45 [-0400]:

>I finally have some time to look at this patch in detail.  I'd rather do the 
>below variant that does what Kent suggested.  Mike, can you confirm that 
>this fixes the issue you reported?  It's on top of my current aio-next tree 
>at git://git.kvack.org/~bcrl/aio-next.git .  If that's okay, I'll queue it 
>up.  Does this bug fix need to end up in -stable kernels as well or would it 
>end up in the -rt tree?

This looks smaller compared to the RCU version. Since recently I have
simple-workqueue in -RT so I could replace schedule_work() with it. And
looking at the code I would have to do this change to free_ioctx_users()
and free_ioctx_reqs(). So here is what I am about to add for next -RT.

Ach. It compiles and I've never seen that splat so any feedback is
welcome :)

diff --git a/fs/aio.c b/fs/aio.c
index 14b93159ef83..551fcfe3fd58 100644
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
@@ -226,6 +227,7 @@ static int __init aio_setup(void)
 		.mount		= aio_mount,
 		.kill_sb	= kill_anon_super,
 	};
+	BUG_ON(swork_get());
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
@@ -505,9 +507,9 @@ static int kiocb_cancel(struct kiocb *kiocb)
 	return cancel(kiocb);
 }
 
-static void free_ioctx(struct work_struct *work)
+static void free_ioctx(struct swork_event *sev)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
+	struct kioctx *ctx = container_of(sev, struct kioctx, free_work);
 
 	pr_debug("freeing %p\n", ctx);
 
@@ -526,8 +528,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 	if (ctx->requests_done)
 		complete(ctx->requests_done);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	INIT_SWORK(&ctx->free_work, free_ioctx);
+	swork_queue(&ctx->free_work);
 }
 
 /*
@@ -535,9 +537,9 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
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
@@ -556,6 +558,14 @@ static void free_ioctx_users(struct percpu_ref *ref)
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
