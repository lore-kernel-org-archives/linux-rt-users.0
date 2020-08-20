Return-Path: <SRS0=8WjD=B6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0112C433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Aug 2020 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FF22076E
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Aug 2020 14:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVHAIOrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1T+A9NB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgHTOag (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgHTOa2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Aug 2020 10:30:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71936C061385;
        Thu, 20 Aug 2020 07:30:27 -0700 (PDT)
Date:   Thu, 20 Aug 2020 16:30:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597933817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=N8EdoB1lhPpf9AReHfpGyiWn/cMqgKOpag4sdmb0hAM=;
        b=lVHAIOrFdRhRsE28otEDHUbLIHug/1imWE49pcv86n4YmkeHVW5XVwXPXU0E9o59WaU4oC
        +XbIQxOuvAfGUyqNilKi56nAkPZVhIMMglFB03csRFZl6oji+Zud3i4+Cg0sT6q4AOOjLj
        VrhxCsGcOJdbHi0+QGf06grj2UrPyOOdmnP8462bXV7W525zKn5fPMKEMsQ6fqOhmslC1f
        g0ShKxer1Ve355bkA3n6IqOGoz7kU+BI8K+2YfSx617i4Vz/XeOODUmC/OO6XaEPflB7Hj
        Z1kTH1kIzggETCX+vwtAN33BZ+xh9sMlKFEAnCaooeXjazM8GVV/wev+lQyf5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597933817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=N8EdoB1lhPpf9AReHfpGyiWn/cMqgKOpag4sdmb0hAM=;
        b=1T+A9NB4YkVAplFSt46wkWQKKswad6JjNUQaDRXUDC4bn1LaWAvxfvE178IRyFqbfuGfna
        Onbzz9HpIUGzk5AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.19-rt12
Message-ID: <20200820143016.y3c5rsa57smwkum5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.19-rt12 patch set. 

Changes since v5.6.19-rt11:

  - Use a raw_spinlock_t in io-wq. This avoids acquiring a sleeping lock
    in atomic context. 

  - Address ifnullfree.cocci warnings in printk. Patch by Julia Lawall.

  - Add "dev: Defer free of skbs in flush_backlog" from upstream.

  - As a result of the previous patch, the "skbufhead-raw-lock.patch"
    can be shrunken by removing the now no longer required
    softnet_data::tofree_queue and the special IRQ-off handling.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.6.19-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.19-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.19-rt12

The RT patch against v5.6.19 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.19-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.19-rt12.tar.xz

Sebastian

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 5cef075c0b379..4a7cbf46213e9 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -85,7 +85,7 @@ enum {
  */
 struct io_wqe {
 	struct {
-		spinlock_t lock;
+		raw_spinlock_t lock;
 		struct io_wq_work_list work_list;
 		unsigned long hash_map;
 		unsigned flags;
@@ -145,7 +145,7 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
 
 	if (current->files != worker->restore_files) {
 		__acquire(&wqe->lock);
-		spin_unlock_irq(&wqe->lock);
+		raw_spin_unlock_irq(&wqe->lock);
 		dropped_lock = true;
 
 		task_lock(current);
@@ -163,7 +163,7 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
 	if (worker->mm) {
 		if (!dropped_lock) {
 			__acquire(&wqe->lock);
-			spin_unlock_irq(&wqe->lock);
+			raw_spin_unlock_irq(&wqe->lock);
 			dropped_lock = true;
 		}
 		__set_current_state(TASK_RUNNING);
@@ -218,17 +218,17 @@ static void io_worker_exit(struct io_worker *worker)
 	worker->flags = 0;
 	preempt_enable();
 
-	spin_lock_irq(&wqe->lock);
+	raw_spin_lock_irq(&wqe->lock);
 	hlist_nulls_del_rcu(&worker->nulls_node);
 	list_del_rcu(&worker->all_list);
 	if (__io_worker_unuse(wqe, worker)) {
 		__release(&wqe->lock);
-		spin_lock_irq(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 	}
 	acct->nr_workers--;
 	nr_workers = wqe->acct[IO_WQ_ACCT_BOUND].nr_workers +
 			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers;
-	spin_unlock_irq(&wqe->lock);
+	raw_spin_unlock_irq(&wqe->lock);
 
 	/* all workers gone, wq exit can proceed */
 	if (!nr_workers && refcount_dec_and_test(&wqe->wq->refs))
@@ -463,7 +463,7 @@ static void io_worker_handle_work(struct io_worker *worker)
 		else if (!wq_list_empty(&wqe->work_list))
 			wqe->flags |= IO_WQE_FLAG_STALLED;
 
-		spin_unlock_irq(&wqe->lock);
+		raw_spin_unlock_irq(&wqe->lock);
 		if (put_work && wq->put_work)
 			wq->put_work(old_work);
 		if (!work)
@@ -514,14 +514,14 @@ static void io_worker_handle_work(struct io_worker *worker)
 		worker->cur_work = NULL;
 		spin_unlock_irq(&worker->lock);
 
-		spin_lock_irq(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 
 		if (hash != -1U) {
 			wqe->hash_map &= ~BIT_ULL(hash);
 			wqe->flags &= ~IO_WQE_FLAG_STALLED;
 		}
 		if (work && work != old_work) {
-			spin_unlock_irq(&wqe->lock);
+			raw_spin_unlock_irq(&wqe->lock);
 
 			if (put_work && wq->put_work) {
 				wq->put_work(put_work);
@@ -546,7 +546,7 @@ static int io_wqe_worker(void *data)
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 loop:
-		spin_lock_irq(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 		if (io_wqe_run_queue(wqe)) {
 			__set_current_state(TASK_RUNNING);
 			io_worker_handle_work(worker);
@@ -557,7 +557,7 @@ static int io_wqe_worker(void *data)
 			__release(&wqe->lock);
 			goto loop;
 		}
-		spin_unlock_irq(&wqe->lock);
+		raw_spin_unlock_irq(&wqe->lock);
 		if (signal_pending(current))
 			flush_signals(current);
 		if (schedule_timeout(WORKER_IDLE_TIMEOUT))
@@ -569,11 +569,11 @@ static int io_wqe_worker(void *data)
 	}
 
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
-		spin_lock_irq(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 		if (!wq_list_empty(&wqe->work_list))
 			io_worker_handle_work(worker);
 		else
-			spin_unlock_irq(&wqe->lock);
+			raw_spin_unlock_irq(&wqe->lock);
 	}
 
 	io_worker_exit(worker);
@@ -613,9 +613,9 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 
 	worker->flags &= ~IO_WORKER_F_RUNNING;
 
-	spin_lock_irq(&wqe->lock);
+	raw_spin_lock_irq(&wqe->lock);
 	io_wqe_dec_running(wqe, worker);
-	spin_unlock_irq(&wqe->lock);
+	raw_spin_unlock_irq(&wqe->lock);
 }
 
 static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
@@ -639,7 +639,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 		return false;
 	}
 
-	spin_lock_irq(&wqe->lock);
+	raw_spin_lock_irq(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
@@ -648,7 +648,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (!acct->nr_workers && (worker->flags & IO_WORKER_F_BOUND))
 		worker->flags |= IO_WORKER_F_FIXED;
 	acct->nr_workers++;
-	spin_unlock_irq(&wqe->lock);
+	raw_spin_unlock_irq(&wqe->lock);
 
 	if (index == IO_WQ_ACCT_UNBOUND)
 		atomic_inc(&wq->user->processes);
@@ -700,12 +700,12 @@ static int io_wq_manager(void *data)
 			if (!node_online(node))
 				continue;
 
-			spin_lock_irq(&wqe->lock);
+			raw_spin_lock_irq(&wqe->lock);
 			if (io_wqe_need_worker(wqe, IO_WQ_ACCT_BOUND))
 				fork_worker[IO_WQ_ACCT_BOUND] = true;
 			if (io_wqe_need_worker(wqe, IO_WQ_ACCT_UNBOUND))
 				fork_worker[IO_WQ_ACCT_UNBOUND] = true;
-			spin_unlock_irq(&wqe->lock);
+			raw_spin_unlock_irq(&wqe->lock);
 			if (fork_worker[IO_WQ_ACCT_BOUND])
 				create_io_worker(wq, wqe, IO_WQ_ACCT_BOUND);
 			if (fork_worker[IO_WQ_ACCT_UNBOUND])
@@ -776,10 +776,10 @@ static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
 	}
 
 	work_flags = work->flags;
-	spin_lock_irqsave(&wqe->lock, flags);
+	raw_spin_lock_irqsave(&wqe->lock, flags);
 	wq_list_add_tail(&work->list, &wqe->work_list);
 	wqe->flags &= ~IO_WQE_FLAG_STALLED;
-	spin_unlock_irqrestore(&wqe->lock, flags);
+	raw_spin_unlock_irqrestore(&wqe->lock, flags);
 
 	if ((work_flags & IO_WQ_WORK_CONCURRENT) ||
 	    !atomic_read(&acct->nr_running))
@@ -897,7 +897,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 	unsigned long flags;
 	bool found = false;
 
-	spin_lock_irqsave(&wqe->lock, flags);
+	raw_spin_lock_irqsave(&wqe->lock, flags);
 	wq_list_for_each(node, prev, &wqe->work_list) {
 		work = container_of(node, struct io_wq_work, list);
 
@@ -907,7 +907,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&wqe->lock, flags);
+	raw_spin_unlock_irqrestore(&wqe->lock, flags);
 
 	if (found) {
 		io_run_cancel(work);
@@ -972,7 +972,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 	 * from there. CANCEL_OK means that the work is returned as-new,
 	 * no completion will be posted for it.
 	 */
-	spin_lock_irqsave(&wqe->lock, flags);
+	raw_spin_lock_irqsave(&wqe->lock, flags);
 	wq_list_for_each(node, prev, &wqe->work_list) {
 		work = container_of(node, struct io_wq_work, list);
 
@@ -982,7 +982,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&wqe->lock, flags);
+	raw_spin_unlock_irqrestore(&wqe->lock, flags);
 
 	if (found) {
 		io_run_cancel(work);
@@ -1097,7 +1097,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		}
 		atomic_set(&wqe->acct[IO_WQ_ACCT_UNBOUND].nr_running, 0);
 		wqe->wq = wq;
-		spin_lock_init(&wqe->lock);
+		raw_spin_lock_init(&wqe->lock);
 		INIT_WQ_LIST(&wqe->work_list);
 		INIT_HLIST_NULLS_HEAD(&wqe->free_list, 0);
 		INIT_LIST_HEAD(&wqe->all_list);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 43240d8534686..6c3f7032e8d9d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3090,7 +3090,6 @@ struct softnet_data {
 	unsigned int		dropped;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
-	struct sk_buff_head	tofree_queue;
 
 };
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6296d348f3008..5a5363877f946 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1458,10 +1458,8 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	if (clear && !seq)
 		syslog_clear();
 
-	if (text)
-		kfree(text);
-	if (msgbuf)
-		kfree(msgbuf);
+	kfree(text);
+	kfree(msgbuf);
 	return len;
 }
 
@@ -1614,10 +1612,8 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	}
 out:
-	if (msgbuf)
-		kfree(msgbuf);
-	if (text)
-		kfree(text);
+	kfree(msgbuf);
+	kfree(text);
 	return error;
 }
 
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
diff --git a/net/core/dev.c b/net/core/dev.c
index fbf66f197cf3d..643b81cd42610 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5507,7 +5507,7 @@ static void flush_backlog(struct work_struct *work)
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
-			__skb_queue_tail(&sd->tofree_queue, skb);
+			dev_kfree_skb_irq(skb);
 			input_queue_head_incr(sd);
 		}
 	}
@@ -5517,14 +5517,11 @@ static void flush_backlog(struct work_struct *work)
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
-			__skb_queue_tail(&sd->tofree_queue, skb);
+			kfree_skb(skb);
 			input_queue_head_incr(sd);
 		}
 	}
-	if (!skb_queue_empty(&sd->tofree_queue))
-		raise_softirq_irqoff(NET_RX_SOFTIRQ);
 	local_bh_enable();
-
 }
 
 static void flush_all_backlogs(void)
@@ -6145,9 +6142,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 	while (again) {
 		struct sk_buff *skb;
 
-		local_irq_disable();
 		while ((skb = __skb_dequeue(&sd->process_queue))) {
-			local_irq_enable();
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
@@ -6155,9 +6150,9 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			if (++work >= quota)
 				return work;
 
-			local_irq_disable();
 		}
 
+		local_irq_disable();
 		rps_lock(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
 			/*
@@ -6639,21 +6634,13 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	unsigned long time_limit = jiffies +
 		usecs_to_jiffies(netdev_budget_usecs);
 	int budget = netdev_budget;
-	struct sk_buff_head tofree_q;
-	struct sk_buff *skb;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
-	__skb_queue_head_init(&tofree_q);
-
 	local_irq_disable();
-	skb_queue_splice_init(&sd->tofree_queue, &tofree_q);
 	list_splice_init(&sd->poll_list, &list);
 	local_irq_enable();
 
-	while ((skb = __skb_dequeue(&tofree_q)))
-		kfree_skb(skb);
-
 	for (;;) {
 		struct napi_struct *n;
 
@@ -10205,13 +10192,10 @@ static int dev_cpu_dead(unsigned int oldcpu)
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = __skb_dequeue(&oldsd->tofree_queue))) {
-		kfree_skb(skb);
-	}
 
 	return 0;
 }
@@ -10525,8 +10509,7 @@ static int __init net_dev_init(void)
 		INIT_WORK(flush, flush_backlog);
 
 		skb_queue_head_init_raw(&sd->input_pkt_queue);
-		skb_queue_head_init_raw(&sd->process_queue);
-		skb_queue_head_init_raw(&sd->tofree_queue);
+		skb_queue_head_init(&sd->process_queue);
 #ifdef CONFIG_XFRM_OFFLOAD
 		skb_queue_head_init(&sd->xfrm_backlog);
 #endif
