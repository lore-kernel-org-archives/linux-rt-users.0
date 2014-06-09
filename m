From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC PATCH] rt/aio: fix rcu garbage collection might_sleep()
 splat
Date: Mon, 09 Jun 2014 08:22:08 +0200
Message-ID: <1402294928.6316.38.camel@marge.simpson.net>
References: <1402216538.31630.7.camel@marge.simpson.net>
	 <5395172E.4010007@cn.fujitsu.com>
	 <1402283822.5195.3.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:40859 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaFIGWL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2014 02:22:11 -0400
In-Reply-To: <1402283822.5195.3.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2014-06-09 at 05:17 +0200, Mike Galbraith wrote: 
> On Mon, 2014-06-09 at 10:08 +0800, Lai Jiangshan wrote: 
> > Hi, rt-people
> > 
> > I don't think it is the correct direction.
> 
> Yup, it's a band-aid, ergo RFC.

Making aio play by the rules is safe.  Another option is to bend the
rules up a little.  With the below, ltp aio-stress testcases haven't yet
griped or exploded either.. which somehow isn't quite as comforting as
"is safe" :)

---
 fs/aio.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -509,7 +509,9 @@ static void free_ioctx_reqs(struct percp
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
 
 	INIT_WORK(&ctx->free_work, free_ioctx);
+	preempt_enable_rt();
 	schedule_work(&ctx->free_work);
+	preempt_disable_rt();
 }
 
 /*
@@ -522,7 +524,9 @@ static void free_ioctx_users(struct perc
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct kiocb *req;
 
+	preempt_enable_rt();
 	spin_lock_irq(&ctx->ctx_lock);
+	local_irq_disable_rt();
 
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
@@ -536,6 +540,8 @@ static void free_ioctx_users(struct perc
 
 	percpu_ref_kill(&ctx->reqs);
 	percpu_ref_put(&ctx->reqs);
+	preempt_disable_rt();
+	local_irq_enable_rt();
 }
 
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)


