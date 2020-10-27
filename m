Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33298C55179
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 09:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43BF2225C
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 09:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2d+JeKFm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Al+1deZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895230AbgJ0JAX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:00:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406413AbgJ0JAX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 05:00:23 -0400
Date:   Tue, 27 Oct 2020 10:00:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603789221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhFXv1BRUKRnsS9ExGJBDAdxNamEG0cPUveqq9dD0aQ=;
        b=2d+JeKFmrjaKpZBSJEHmG2kCauwy3OgCERQ1hpndwsYke2PmzCfR4pPbwcH+IeJj7B5bE8
        Hbbo5sODvHRyaqtMM4be11LjmOzNN+Jou/slTP8Sb5EUz3vAL4Qfb1ZRcPVfFKMBqxZX1Z
        haLHmB1KEMQBpOD2mxHAoj3UKKYZsUD/s9hEZwvAbk4Wkm2NLAopZciYCeaYYI3KhfhP8T
        9Vj+fVYsDKGKjYtTpWWLvp63PyvMMdXzblors7Scx6bnbkouFA+wjLSD9khZAW6CU98DVZ
        Ulw+O79TmwzjyHIq4kwCGqq0u1sBeQuZC1EUwxKoe1Nptcv++eeQdn8FITPmWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603789221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhFXv1BRUKRnsS9ExGJBDAdxNamEG0cPUveqq9dD0aQ=;
        b=Al+1deZf1TJ9yM8BZB1nWmTwGerGXKo3tMU81KhDWg+V/rfJ0VkuEmVB49EHuG4s6eDdmj
        rEuAPwBb+6f2k1Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201027090019.3vteojm43ljqqe33@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
 <20201023090108.5lunh4vqfpkllmap@linutronix.de>
 <20201024022236.19608-1-hdanton@sina.com>
 <20201024050000.8104-1-hdanton@sina.com>
 <20201026173107.quylcy6fgjvrqat6@linutronix.de>
 <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
 <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
 <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-27 07:03:38 [+0100], Mike Galbraith wrote:
> On Mon, 2020-10-26 at 20:53 +0100, Sebastian Andrzej Siewior wrote:
> >
> > Could you try this, please?
> 
> Nogo, first call of sched_setscheduler() is via kthread_create().  I
> confirmed that nuking that (gratuitous user foot saving override) call
> on top of moving sched_set_fifo() does shut it up, but that won't fly.

mkay. but this then, too. Let me try if I can figure out when this
broke.

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b4..64d6afb127239 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -244,6 +244,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 static int kthread(void *_create)
 {
 	/* Copy data: it's on kthread's stack */
+	static const struct sched_param param = { .sched_priority = 0 };
 	struct kthread_create_info *create = _create;
 	int (*threadfn)(void *data) = create->threadfn;
 	void *data = create->data;
@@ -273,6 +274,13 @@ static int kthread(void *_create)
 	init_completion(&self->parked);
 	current->vfork_done = &self->exited;
 
+	/*
+	 * root may have changed our (kthreadd's) priority or CPU mask.
+	 * The kernel thread should not inherit these properties.
+	 */
+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
@@ -370,7 +378,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	}
 	task = create->result;
 	if (!IS_ERR(task)) {
-		static const struct sched_param param = { .sched_priority = 0 };
 		char name[TASK_COMM_LEN];
 
 		/*
@@ -379,13 +386,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 */
 		vsnprintf(name, sizeof(name), namefmt, args);
 		set_task_comm(task, name);
-		/*
-		 * root may have changed our (kthreadd's) priority or CPU mask.
-		 * The kernel thread should not inherit these properties.
-		 */
-		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task,
-				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;

Sebastian
