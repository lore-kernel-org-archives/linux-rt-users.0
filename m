Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4FC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 07:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F8A60551
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 07:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhHJHlU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:41:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbhHJHlT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 03:41:19 -0400
Date:   Tue, 10 Aug 2021 09:40:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628581256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCBDh1Ms6q0qVn26oKGgyybf19fVGPHHnw6ajA7SOes=;
        b=JxvG3zF7N6EpGfBi3yiEQkkd1M1K26rCBFKIJwjqdU9Q0XfILiNHFQYg8xI7v69Aj4MMCJ
        JrHcYINFC92COfbyBMI6pOoyn/0yKfMedNNf4dU3ja/fddDRn4xN4zYnIiOh8yAoTKY3Km
        wHblwrDsa0ROrAUkzfQROrwvo3Fk0xxj21sbh4zlQlzC6IMqYuwFHHlEW2kcpX5OGMLQlG
        1BxFqFWZmVhtov4IUD0V9l1770vjheILK6Z3B4ACabAzQSSb8bFbYHDjUjsL8XQLIbUfUA
        i7Y9bJN0W28aMCdnMVlv/Agzx52JmhezxwWnGEsgHOc9El/EFbCp9988ybrG3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628581256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCBDh1Ms6q0qVn26oKGgyybf19fVGPHHnw6ajA7SOes=;
        b=Cb7thcKvRmb4jsOQ6A0Gje1ldvTlo0LNT3HrI/1zaq+tDueLQHkM0TrMHlDAjyxSKSgyJ6
        qx2jFo7oCElNIJAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210810074054.mll3snv7vqfhef6i@linutronix.de>
References: <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
 <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
 <20210804164735.sq6sjejusa37abkw@linutronix.de>
 <71d37a7d-af53-945e-0c49-3cb902487df4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71d37a7d-af53-945e-0c49-3cb902487df4@kernel.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 10:57:11 [-0600], Jens Axboe wrote:
> 
> 1 out of 2 is better than 0 ;-)

The patch at the end of the email is what I ended up after rebasing to
-rc5. Also after testing I figured out that tools/io_uring/io_uring-cp.c
is no longer working. The resulting file has a size of either 0 or 4KiB.
Then, tglx pointed out that the example in liburing shares the same file
name and is actually working.

From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 4 Aug 2021 08:43:43 -0600
Subject: [PATCH] io-wq: remove GFP_ATOMIC allocation off schedule out path

Daniel reports that the v5.14-rc4-rt4 kernel throws a BUG when running
stress-ng:

| [   90.202543] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
| [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2047, name: iou-wrk-2041
| [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W         5.14.0-rc4-rt4+ #89
| [   90.202559] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
| [   90.202561] Call Trace:
| [   90.202577]  dump_stack_lvl+0x34/0x44
| [   90.202584]  ___might_sleep.cold+0x87/0x94
| [   90.202588]  rt_spin_lock+0x19/0x70
| [   90.202593]  ___slab_alloc+0xcb/0x7d0
| [   90.202598]  ? newidle_balance.constprop.0+0xf5/0x3b0
| [   90.202603]  ? dequeue_entity+0xc3/0x290
| [   90.202605]  ? io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202610]  ? pick_next_task_fair+0xb9/0x330
| [   90.202612]  ? __schedule+0x670/0x1410
| [   90.202615]  ? io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
| [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202625]  io_wq_worker_sleeping+0x37/0x50
| [   90.202628]  schedule+0x30/0xd0
| [   90.202630]  schedule_timeout+0x8f/0x1a0
| [   90.202634]  ? __bpf_trace_tick_stop+0x10/0x10
| [   90.202637]  io_wqe_worker+0xfd/0x320
| [   90.202641]  ? finish_task_switch.isra.0+0xd3/0x290
| [   90.202644]  ? io_worker_handle_work+0x670/0x670
| [   90.202646]  ? io_worker_handle_work+0x670/0x670
| [   90.202649]  ret_from_fork+0x22/0x30

which is due to the RT kernel not liking a GFP_ATOMIC allocation inside
a raw spinlock. Besides that not working on RT, doing any kind of
allocation from inside schedule() is kind of nasty and should be avoided
if at all possible.

This particular path happens when an io-wq worker goes to sleep, and we
need a new worker to handle pending work. We currently allocate a small
data item to hold the information we need to create a new worker, but we
can instead include this data in the io_worker struct itself and just
protect it with a single bit lock. We only really need one per worker
anyway, as we will have run pending work between to sleep cycles.

https://lore.kernel.org/lkml/20210804082418.fbibprcwtzyt5qax@beryllium.lan/

Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Tested-by: Daniel Wagner <dwagner@suse.de>
Link: https://lore.kernel.org/r/a673a130-e0e4-5aa8-4165-f35d1262fc6a@kernel.dk
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/io-wq.c |   75 ++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -51,6 +51,10 @@ struct io_worker {
 
 	struct completion ref_done;
 
+	unsigned long create_state;
+	struct callback_head create_work;
+	int create_index;
+
 	struct rcu_head rcu;
 };
 
@@ -270,50 +274,54 @@ static void io_wqe_inc_running(struct io
 	atomic_inc(&acct->nr_running);
 }
 
-struct create_worker_data {
-	struct callback_head work;
-	struct io_wqe *wqe;
-	int index;
-};
-
 static void create_worker_cb(struct callback_head *cb)
 {
-	struct create_worker_data *cwd;
+	struct io_worker *worker;
 	struct io_wq *wq;
 	struct io_wqe *wqe;
 	struct io_wqe_acct *acct;
 
-	cwd = container_of(cb, struct create_worker_data, work);
-	wqe = cwd->wqe;
-	wq = wqe->wq;
-	acct = &wqe->acct[cwd->index];
+	worker = container_of(cb, struct io_worker, create_work);
+	wqe = worker->wqe;
+	wq = worker->wq;
+	acct = &wqe->acct[worker->create_index];
 	raw_spin_lock_irq(&wqe->lock);
 	if (acct->nr_workers < acct->max_workers)
 		acct->nr_workers++;
 	raw_spin_unlock_irq(&wqe->lock);
-	create_io_worker(wq, cwd->wqe, cwd->index);
-	kfree(cwd);
+	create_io_worker(wq, wqe, worker->create_index);
+	clear_bit_unlock(0, &worker->create_state);
+	io_worker_release(worker);
 }
 
-static void io_queue_worker_create(struct io_wqe *wqe, struct io_wqe_acct *acct)
+static void io_queue_worker_create(struct io_wqe *wqe, struct io_worker
+				   *worker, struct io_wqe_acct *acct)
 {
-	struct create_worker_data *cwd;
 	struct io_wq *wq = wqe->wq;
 
 	/* raced with exit, just ignore create call */
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state))
 		goto fail;
+	if (!io_worker_get(worker))
+		goto fail;
+	/*
+	 * create_state manages ownership of create_work/index. We should
+	 * only need one entry per worker, as the worker going to sleep
+	 * will trigger the condition, and waking will clear it once it
+	 * runs the task_work.
+	 */
+	if (test_bit(0, &worker->create_state) ||
+	    test_and_set_bit_lock(0, &worker->create_state))
+		goto fail_release;
+
+	init_task_work(&worker->create_work, create_worker_cb);
+	worker->create_index = acct->index;
+	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL))
+		return;
 
-	cwd = kmalloc(sizeof(*cwd), GFP_ATOMIC);
-	if (cwd) {
-		init_task_work(&cwd->work, create_worker_cb);
-		cwd->wqe = wqe;
-		cwd->index = acct->index;
-		if (!task_work_add(wq->task, &cwd->work, TWA_SIGNAL))
-			return;
-
-		kfree(cwd);
-	}
+	clear_bit_unlock(0, &worker->create_state);
+fail_release:
+	io_worker_release(worker);
 fail:
 	atomic_dec(&acct->nr_running);
 	io_worker_ref_put(wq);
@@ -331,7 +339,7 @@ static void io_wqe_dec_running(struct io
 	if (atomic_dec_and_test(&acct->nr_running) && io_wqe_run_queue(wqe)) {
 		atomic_inc(&acct->nr_running);
 		atomic_inc(&wqe->wq->worker_refs);
-		io_queue_worker_create(wqe, acct);
+		io_queue_worker_create(wqe, worker, acct);
 	}
 }
 
@@ -992,12 +1000,12 @@ struct io_wq *io_wq_create(unsigned boun
 
 static bool io_task_work_match(struct callback_head *cb, void *data)
 {
-	struct create_worker_data *cwd;
+	struct io_worker *worker;
 
 	if (cb->func != create_worker_cb)
 		return false;
-	cwd = container_of(cb, struct create_worker_data, work);
-	return cwd->wqe->wq == data;
+	worker = container_of(cb, struct io_worker, create_work);
+	return worker->wqe->wq == data;
 }
 
 void io_wq_exit_start(struct io_wq *wq)
@@ -1014,12 +1022,13 @@ static void io_wq_exit_workers(struct io
 		return;
 
 	while ((cb = task_work_cancel_match(wq->task, io_task_work_match, wq)) != NULL) {
-		struct create_worker_data *cwd;
+		struct io_worker *worker;
 
-		cwd = container_of(cb, struct create_worker_data, work);
-		atomic_dec(&cwd->wqe->acct[cwd->index].nr_running);
+		worker = container_of(cb, struct io_worker, create_work);
+		atomic_dec(&worker->wqe->acct[worker->create_index].nr_running);
 		io_worker_ref_put(wq);
-		kfree(cwd);
+		clear_bit_unlock(0, &worker->create_state);
+		io_worker_release(worker);
 	}
 
 	rcu_read_lock();

Sebastian
