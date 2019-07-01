Return-Path: <SRS0=4NjT=U6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2FAC0650E
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Jul 2019 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6993F206E0
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Jul 2019 21:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRVv9IsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfGAVew (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:34:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35657 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAVev (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Jul 2019 17:34:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so11227099oii.2;
        Mon, 01 Jul 2019 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xhAafXt+IxBm68ncbRDSjF5LGtfIcqGl8aIPkNVDLg=;
        b=QRVv9IsC8ZFWubDDJE73WMYjHjcq4/qn4/4bKOIgzEeNNGaL/bn+Wue04fW7EOGMO+
         GzbkXqPZyZ5jLm0rhsbSW1lX/dokKTEmzVXslw4vqRl2Y7nt5V8Ch1N8K8jwYfw7EE69
         lNlkFChn2Y7NrT6lk/QICWyid1hXaUrAg2TNxFPT9229qyh+DbQGWIwKvozsh4uwCED3
         N+ER/ohj+RygUnhbacHtoGAMOPETwKnLzWU6V8kM4cN62rK0fpCPC5RL82HctNTDVERx
         E7D94PudaANSXVoUmnajTG/aFV0eXOM4pWA3nurlzcTfonBeLhJd2HsibSYmJ8MSty+1
         Y04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=/xhAafXt+IxBm68ncbRDSjF5LGtfIcqGl8aIPkNVDLg=;
        b=tk/ig68I1AkUXXbUeVsyRaZWByRz1VIk4jC281/xldbn39Rmhu8qoa8iQQ86Rk5FUI
         JSooAwCNyRHXRJXYzk58auUyhdnxuJQOv9AAaulRCa92Hx6440I+L0C/m+mUYN+4z8hU
         XwyCEROIcn8ACal9VEjXDxoUYRnrQl9TO/5NTq3ipGbgX4kqAJdemSp6BxbBzyXt7BvP
         i8BcGB1e7FFFWgiVStarwgS5nBaVnlL9+vVRj6tevcTyfuXOSmeBO/kddtLTs3PVevC6
         czgELFqgzLCnJM3aR3U8ZjRs3okHjtlNhW3XknSbN7vUFkP3J3SlxaCVqWL+eDSztp9f
         6CqQ==
X-Gm-Message-State: APjAAAWztYyoIbTmtON3rjpcZyEk6qiRN13pu0G6DF/jdk7tJEcPIlGV
        vtl8HC55H5UJekAxIVYzDw==
X-Google-Smtp-Source: APXvYqxDyMTDotRySwO9Uv2LcUfCYZ2/L2tvak+dufB2yUyP0pR6Q0oubvE2hRyJQaajIEY3C6irPQ==
X-Received: by 2002:aca:eb57:: with SMTP id j84mr917136oih.17.1562016890538;
        Mon, 01 Jul 2019 14:34:50 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z69sm4303924oia.48.2019.07.01.14.34.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:34:50 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9575:16b6:1dd6:2173])
        by serve.minyard.net (Postfix) with ESMTPSA id 6CE221800D1;
        Mon,  1 Jul 2019 21:34:49 +0000 (UTC)
Date:   Mon, 1 Jul 2019 16:34:48 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Corey Minyard <cminyard@mvista.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190701213448.GC4336@minyard.net>
Reply-To: minyard@acm.org
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
 <20190701204325.GD5041@minyard.net>
 <20190701170602.2fdb35c2@gandalf.local.home>
 <20190701171333.37cc0567@gandalf.local.home>
 <20190701172825.7d861e85@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701172825.7d861e85@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jul 01, 2019 at 05:28:25PM -0400, Steven Rostedt wrote:
> On Mon, 1 Jul 2019 17:13:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 1 Jul 2019 17:06:02 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Mon, 1 Jul 2019 15:43:25 -0500
> > > Corey Minyard <cminyard@mvista.com> wrote:
> > > 
> > >   
> > > > I show that patch is already applied at
> > > > 
> > > >     1921ea799b7dc561c97185538100271d88ee47db
> > > >     sched/completion: Fix a lockup in wait_for_completion()
> > > > 
> > > > git describe --contains 1921ea799b7dc561c97185538100271d88ee47db
> > > > v4.19.37-rt20~1
> > > > 
> > > > So I'm not sure what is going on.    
> > > 
> > > Bah, I'm replying to the wrong commit that I'm having issues with.
> > > 
> > > I searched your name to find the patch that is of trouble, and picked
> > > this one.
> > > 
> > > I'll go find the problem patch, sorry for the noise on this one.
> > >   
> > 
> > No, I did reply to the right email, but it wasn't the top patch I was
> > having issues with. It was the patch I replied to:
> > 
> > This change below that Sebastian marked as stable-rt is what is causing
> > me an issue. Not the patch that started the thread.
> > 
> 
> In fact, my system doesn't boot with this commit in 5.0-rt.
> 
> If I revert 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> wakeup occured") the machine boots again.
> 
> Sebastian, I think that's a bad commit, please revert it.

Yeah.  d_wait_lookup() does not use __SWAITQUEUE_INITIALIZER() to
intitialize it's queue item, but uses swake_up_all(), so it goes
into an infinite loop since it won't remove the item because remove
isn't set.

I'd suspect there are other places this is the case.

-corey

> 
> Thanks!
> 
> -- Steve
> 
> > 
> > 
> > > Now.. that will fix it, but I think it is also wrong.
> > > 
> > > The problem being that it violates FIFO, something that might be more
> > > important on -RT than elsewhere.
> > > 
> > > The regular wait API seems confused/inconsistent when it uses
> > > autoremove_wake_function and default_wake_function, which doesn't help,
> > > but we can easily support this with swait -- the problematic thing is
> > > the custom wake functions, we musn't do that.
> > > 
> > > (also, mingo went and renamed a whole bunch of wait_* crap and didn't do
> > > the same to swait_ so now its named all different :/)
> > > 
> > > Something like the below perhaps.
> > > 
> > > ---
> > > diff --git a/include/linux/swait.h b/include/linux/swait.h
> > > index 73e06e9986d4..f194437ae7d2 100644
> > > --- a/include/linux/swait.h
> > > +++ b/include/linux/swait.h
> > > @@ -61,11 +61,13 @@ struct swait_queue_head {
> > >  struct swait_queue {
> > >  	struct task_struct	*task;
> > >  	struct list_head	task_list;
> > > +	unsigned int		remove;
> > >  };
> > >  
> > >  #define __SWAITQUEUE_INITIALIZER(name) {				\
> > >  	.task		= current,					\
> > >  	.task_list	= LIST_HEAD_INIT((name).task_list),		\
> > > +	.remove		= 1,						\
> > >  }
> > >  
> > >  #define DECLARE_SWAITQUEUE(name)					\
> > > diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> > > index e83a3f8449f6..86974ecbabfc 100644
> > > --- a/kernel/sched/swait.c
> > > +++ b/kernel/sched/swait.c
> > > @@ -28,7 +28,8 @@ void swake_up_locked(struct swait_queue_head *q)
> > >  
> > >  	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
> > >  	wake_up_process(curr->task);
> > > -	list_del_init(&curr->task_list);
> > > +	if (curr->remove)
> > > +		list_del_init(&curr->task_list);
> > >  }
> > >  EXPORT_SYMBOL(swake_up_locked);
> > >  
> > > @@ -57,7 +58,8 @@ void swake_up_all(struct swait_queue_head *q)
> > >  		curr = list_first_entry(&tmp, typeof(*curr), task_list);
> > >  
> > >  		wake_up_state(curr->task, TASK_NORMAL);
> > > -		list_del_init(&curr->task_list);
> > > +		if (curr->remove)
> > > +			list_del_init(&curr->task_list);
> > >  
> > >  		if (list_empty(&tmp))
> > >  			break;  
> > 
> 
