Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AFBC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9B160EBC
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 14:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhHDOYd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhHDOY3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 10:24:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8DC0617A1
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 07:23:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a8so3202491pjk.4
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2021 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9Sjp3wNbFl86/XHeOuraYarVkTi/7NfVhRkUt1wBME=;
        b=fSg2IayWjI1QRrJGyWeIVQvi9pK7Tw+DW6gjYLYIh6rEBaDWsCvU00wBku/+w7f/Ma
         0qR6ayZg10WgK7FjgeXKSipfyMTLM2UDbx6A+HyOwIwDtj/+hdW+kzNTLqqj5w2jU3gt
         CcBQv/61DSjjO/RMsHCmbHpalxlXEE56yWjTllXUYpjedBlw580tgDgEMl1d47x6gZ9e
         Mm2mDHJfZ8yvYUmqsEEMeGR/McRAH0fdSzCU3++fZ6Ho6bW1nLVdCiw60g9OIoskrUDE
         ITyNR++EzlzkMDKhOpc3f1v5yeADIgOokrz4gjeNs7ClNOPWx3vITkAqn7esyDbX2r1c
         TOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9Sjp3wNbFl86/XHeOuraYarVkTi/7NfVhRkUt1wBME=;
        b=qRCw3MQ9tAfVkm4w4Yknvmo3syJZIFbMoR/fZVxagZjwwuUJXKJU0gp9h4klilXNim
         0ULle/TIjjAbxUuk0PxU/T2Tr39gHA6AAL731LhNliMAD55/1642MAJQfw93Yomt6Qgy
         raq645uC3NmeUcdUXDYBpt0keNb6p1Da0GYaq63Pu3E0d9rFNkR1y7j6GbxDSd8SCX1U
         DtwaVdF6vUxkOjvUy1F3EYQy1omrXf8GGbIvIpXjbUrHYIiI985qsLgWevc3M5QVROaW
         Eb83UGfHzDHD3hNjffZW1/O9pa03bVxgxCYoGG5K+GhX40CY91/7Hd8CO1n4m8G2VWMs
         U6zQ==
X-Gm-Message-State: AOAM533zIEFdeXLa3Mdk9DkSb6FUdR/WCdaNlqw/PVDnJx9H2jTfU3Hk
        NiWJP3D+Cefbj0wc5o1UGMlM/w==
X-Google-Smtp-Source: ABdhPJwn01+nAxEB5rtni8GWzTwRlTULTpk8L17F2g8qv/r78pqSWXZGJxKOAGe91KFfATjHEP32CQ==
X-Received: by 2002:a17:90a:bc89:: with SMTP id x9mr10409045pjr.52.1628087038257;
        Wed, 04 Aug 2021 07:23:58 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id mr18sm2766391pjb.39.2021.08.04.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:23:57 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
From:   Jens Axboe <axboe@kernel.dk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
Message-ID: <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
Date:   Wed, 4 Aug 2021 08:23:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 7:32 AM, Jens Axboe wrote:
> On 8/4/21 7:17 AM, Peter Zijlstra wrote:
>> On Wed, Aug 04, 2021 at 01:00:57PM +0200, Sebastian Andrzej Siewior wrote:
>>> On 2021-08-04 12:48:05 [+0200], To Daniel Wagner wrote:
>>>> On 2021-08-04 12:43:42 [+0200], To Daniel Wagner wrote:
>>>>> Odd. Do you have a config for that, please?
>>>>
>>>> No need.
>>>> | [   90.202543] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
>>>> | [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2047, name: iou-wrk-2041
>>>> | [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W         5.14.0-rc4-rt4+ #89
>>>> | [   90.202561] Call Trace:
>>> …
>>>> | [   90.202588]  rt_spin_lock+0x19/0x70
>>>> | [   90.202593]  ___slab_alloc+0xcb/0x7d0
>>> …
>>>> | [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
>>>> | [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
>>>> | [   90.202625]  io_wq_worker_sleeping+0x37/0x50
>>>> | [   90.202628]  schedule+0x30/0xd0
>>>>
>>>> le look.
>>>
>>> So this is due to commit
>>>   685fe7feedb96 ("io-wq: eliminate the need for a manager thread")
>>>
>>> introduced in the v5.13-rc1 merge window. The call chain is
>>>   schedule()
>>>    sched_submit_work()
>>>     preempt_disable();
>>>     io_wq_worker_sleeping()
>>>       raw_spin_lock_irq(&worker->wqe->lock);
>>>       io_wqe_dec_running(worker);
>>>        io_queue_worker_create()
>>>         kmalloc(sizeof(*cwd), GFP_ATOMIC);
>>>
>>> The lock wqe::lock has been turned into a raw_spinlock_t in commit
>>>    95da84659226d ("io_wq: Make io_wqe::lock a raw_spinlock_t")
>>>
>>> after a careful analysis of the code at that time. This commit breaks
>>> things. Is this really needed?
>>
>> Urgh, doing allocs from schedule seems really yuck. Can we please not do
>> this?
> 
> Agree, I have an idea of how to get rid of it. Let me experiment a bit...

Something like this should do it - the only thing we need the allocation for
is short lived, queueing a task_work item to create a new worker. We can
manage this on a per-existing worker basis, and just have the tw/index
stored in the worker itself. That avoids an allocation off schedule ->
going to sleep.

Totally untested, but I think the principle is sound. I'll run it through
some testing.


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 50dc93ffc153..97eaaf25a429 100644
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
 
@@ -261,42 +265,44 @@ static void io_wqe_inc_running(struct io_worker *worker)
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
 
-	cwd = container_of(cb, struct create_worker_data, work);
-	wq = cwd->wqe->wq;
-	create_io_worker(wq, cwd->wqe, cwd->index);
-	kfree(cwd);
+	worker = container_of(cb, struct io_worker, create_work);
+	wq = worker->wqe->wq;
+	create_io_worker(wq, worker->wqe, worker->create_index);
+	clear_bit_unlock(0, &worker->create_state);
+	io_worker_release(worker);
 }
 
-static void io_queue_worker_create(struct io_wqe *wqe, struct io_wqe_acct *acct)
+static void io_queue_worker_create(struct io_wqe *wqe, struct io_worker *worker,
+				   struct io_wqe_acct *acct)
 {
-	struct create_worker_data *cwd;
 	struct io_wq *wq = wqe->wq;
 
 	/* raced with exit, just ignore create call */
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state))
 		goto fail;
+	/*
+	 * create_state manages ownership of create_work/index. We should
+	 * only need one entry per worker, as the worker going to sleep
+	 * will trigger the condition, and waking will clear it once it
+	 * runs the task_work.
+	 */
+	if (test_bit(0, &worker->create_state) ||
+	    test_and_set_bit_lock(0, &worker->create_state))
+		goto fail;
 
-	cwd = kmalloc(sizeof(*cwd), GFP_ATOMIC);
-	if (cwd) {
-		init_task_work(&cwd->work, create_worker_cb);
-		cwd->wqe = wqe;
-		cwd->index = acct->index;
-		if (!task_work_add(wq->task, &cwd->work, TWA_SIGNAL))
-			return;
+	io_worker_get(worker);
+	init_task_work(&worker->create_work, create_worker_cb);
+	worker->create_index = acct->index;
+	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL))
+		return;
 
-		kfree(cwd);
-	}
+	clear_bit_unlock(0, &worker->create_state);
+	io_worker_release(worker);
 fail:
 	atomic_dec(&acct->nr_running);
 	io_worker_ref_put(wq);
@@ -314,7 +320,7 @@ static void io_wqe_dec_running(struct io_worker *worker)
 	if (atomic_dec_and_test(&acct->nr_running) && io_wqe_run_queue(wqe)) {
 		atomic_inc(&acct->nr_running);
 		atomic_inc(&wqe->wq->worker_refs);
-		io_queue_worker_create(wqe, acct);
+		io_queue_worker_create(wqe, worker, acct);
 	}
 }
 
@@ -973,12 +979,12 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
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
@@ -995,12 +1001,13 @@ static void io_wq_exit_workers(struct io_wq *wq)
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

-- 
Jens Axboe

