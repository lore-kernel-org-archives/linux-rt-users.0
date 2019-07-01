Return-Path: <SRS0=4NjT=U6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D143FC0650E
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Jul 2019 21:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B154D21721
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Jul 2019 21:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGAVNh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAVNg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Jul 2019 17:13:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58C521479;
        Mon,  1 Jul 2019 21:13:34 +0000 (UTC)
Date:   Mon, 1 Jul 2019 17:13:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Corey Minyard <minyard@acm.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190701171333.37cc0567@gandalf.local.home>
In-Reply-To: <20190701170602.2fdb35c2@gandalf.local.home>
References: <20190509193320.21105-1-minyard@acm.org>
        <20190510103318.6cieoifz27eph4n5@linutronix.de>
        <20190628214903.6f92a9ea@oasis.local.home>
        <20190701190949.GB4336@minyard.net>
        <20190701161840.1a53c9e4@gandalf.local.home>
        <20190701204325.GD5041@minyard.net>
        <20190701170602.2fdb35c2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 1 Jul 2019 17:06:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Jul 2019 15:43:25 -0500
> Corey Minyard <cminyard@mvista.com> wrote:
> 
> 
> > I show that patch is already applied at
> > 
> >     1921ea799b7dc561c97185538100271d88ee47db
> >     sched/completion: Fix a lockup in wait_for_completion()
> > 
> > git describe --contains 1921ea799b7dc561c97185538100271d88ee47db
> > v4.19.37-rt20~1
> > 
> > So I'm not sure what is going on.  
> 
> Bah, I'm replying to the wrong commit that I'm having issues with.
> 
> I searched your name to find the patch that is of trouble, and picked
> this one.
> 
> I'll go find the problem patch, sorry for the noise on this one.
> 

No, I did reply to the right email, but it wasn't the top patch I was
having issues with. It was the patch I replied to:

This change below that Sebastian marked as stable-rt is what is causing
me an issue. Not the patch that started the thread.

-- Steve


> Now.. that will fix it, but I think it is also wrong.
> 
> The problem being that it violates FIFO, something that might be more
> important on -RT than elsewhere.
> 
> The regular wait API seems confused/inconsistent when it uses
> autoremove_wake_function and default_wake_function, which doesn't help,
> but we can easily support this with swait -- the problematic thing is
> the custom wake functions, we musn't do that.
> 
> (also, mingo went and renamed a whole bunch of wait_* crap and didn't do
> the same to swait_ so now its named all different :/)
> 
> Something like the below perhaps.
> 
> ---
> diff --git a/include/linux/swait.h b/include/linux/swait.h
> index 73e06e9986d4..f194437ae7d2 100644
> --- a/include/linux/swait.h
> +++ b/include/linux/swait.h
> @@ -61,11 +61,13 @@ struct swait_queue_head {
>  struct swait_queue {
>  	struct task_struct	*task;
>  	struct list_head	task_list;
> +	unsigned int		remove;
>  };
>  
>  #define __SWAITQUEUE_INITIALIZER(name) {				\
>  	.task		= current,					\
>  	.task_list	= LIST_HEAD_INIT((name).task_list),		\
> +	.remove		= 1,						\
>  }
>  
>  #define DECLARE_SWAITQUEUE(name)					\
> diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> index e83a3f8449f6..86974ecbabfc 100644
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -28,7 +28,8 @@ void swake_up_locked(struct swait_queue_head *q)
>  
>  	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
>  	wake_up_process(curr->task);
> -	list_del_init(&curr->task_list);
> +	if (curr->remove)
> +		list_del_init(&curr->task_list);
>  }
>  EXPORT_SYMBOL(swake_up_locked);
>  
> @@ -57,7 +58,8 @@ void swake_up_all(struct swait_queue_head *q)
>  		curr = list_first_entry(&tmp, typeof(*curr), task_list);
>  
>  		wake_up_state(curr->task, TASK_NORMAL);
> -		list_del_init(&curr->task_list);
> +		if (curr->remove)
> +			list_del_init(&curr->task_list);
>  
>  		if (list_empty(&tmp))
>  			break;

