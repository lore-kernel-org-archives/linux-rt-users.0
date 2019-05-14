Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF97C04AB4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 08:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7520818
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 08:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jvnw4koa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfENIoI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 04:44:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfENIoI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 04:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZFukSCaXEzzob4O1ASywHJ/kDWha8dAc33N1Kx8msEI=; b=Jvnw4koacudV2mpSex+Jp9PVU
        u+p3BJnbpc+ernQ/5r/gu+G/f78E44NbLceEeuslh5phii0ZNJAnMFy//Yg55x1RWr011U6oq1+Ys
        Pl10ZvgyOygdKjQs0rlUJzQd+lsb14oxc/1h3f75GCZVFTvRmexCAfrMUKvLlCdHw4+j+hthkxuAS
        50nhiDj/g2m+LIyoMwpCTI95tF652/74rS0OiUUQAFnt7fj78zaev08CHr7GsQrClv15G0X88Czsm
        t/E0BWT11XTbznL34YZPN8TuZBaH6gD3YMz9XwW0qMn/LibbMSiTRwh/cz7gTDC6SAgmGWmXT/Ual
        cmNWCij7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQT2U-00069x-HM; Tue, 14 May 2019 08:43:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9B252029F87A; Tue, 14 May 2019 10:43:56 +0200 (CEST)
Date:   Tue, 14 May 2019 10:43:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509161925.kul66w54wpjcinuc@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 09, 2019 at 06:19:25PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-08 15:57:28 [-0500], minyard@acm.org wrote:

> >  kernel/sched/completion.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> > index 755a58084978..4f9b4cc0c95a 100644
> > --- a/kernel/sched/completion.c
> > +++ b/kernel/sched/completion.c
> > @@ -70,20 +70,20 @@ do_wait_for_common(struct completion *x,
> >  		   long (*action)(long), long timeout, int state)
> >  {
> >  	if (!x->done) {
> > -		DECLARE_SWAITQUEUE(wait);
> > -
> > -		__prepare_to_swait(&x->wait, &wait);
> 
> you can keep DECLARE_SWAITQUEUE remove just __prepare_to_swait()
> 
> >  		do {
> > +			DECLARE_SWAITQUEUE(wait);
> > +
> >  			if (signal_pending_state(state, current)) {
> >  				timeout = -ERESTARTSYS;
> >  				break;
> >  			}
> > +			__prepare_to_swait(&x->wait, &wait);
> 
> add this, yes and you are done.
> 
> >  			__set_current_state(state);
> >  			raw_spin_unlock_irq(&x->wait.lock);
> >  			timeout = action(timeout);
> >  			raw_spin_lock_irq(&x->wait.lock);
> > +			__finish_swait(&x->wait, &wait);
> >  		} while (!x->done && timeout);
> > -		__finish_swait(&x->wait, &wait);
> >  		if (!x->done)
> >  			return timeout;
> >  	}

Now.. that will fix it, but I think it is also wrong.

The problem being that it violates FIFO, something that might be more
important on -RT than elsewhere.

The regular wait API seems confused/inconsistent when it uses
autoremove_wake_function and default_wake_function, which doesn't help,
but we can easily support this with swait -- the problematic thing is
the custom wake functions, we musn't do that.

(also, mingo went and renamed a whole bunch of wait_* crap and didn't do
the same to swait_ so now its named all different :/)

Something like the below perhaps.

---
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 73e06e9986d4..f194437ae7d2 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -61,11 +61,13 @@ struct swait_queue_head {
 struct swait_queue {
 	struct task_struct	*task;
 	struct list_head	task_list;
+	unsigned int		remove;
 };
 
 #define __SWAITQUEUE_INITIALIZER(name) {				\
 	.task		= current,					\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+	.remove		= 1,						\
 }
 
 #define DECLARE_SWAITQUEUE(name)					\
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e83a3f8449f6..86974ecbabfc 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -28,7 +28,8 @@ void swake_up_locked(struct swait_queue_head *q)
 
 	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
 	wake_up_process(curr->task);
-	list_del_init(&curr->task_list);
+	if (curr->remove)
+		list_del_init(&curr->task_list);
 }
 EXPORT_SYMBOL(swake_up_locked);
 
@@ -57,7 +58,8 @@ void swake_up_all(struct swait_queue_head *q)
 		curr = list_first_entry(&tmp, typeof(*curr), task_list);
 
 		wake_up_state(curr->task, TASK_NORMAL);
-		list_del_init(&curr->task_list);
+		if (curr->remove)
+			list_del_init(&curr->task_list);
 
 		if (list_empty(&tmp))
 			break;
