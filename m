Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADFC04AB6
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887252147A
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="gKMZt+rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENMN7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 08:13:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44844 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENMN7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 08:13:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id z65so4679765oia.11
        for <linux-rt-users@vger.kernel.org>; Tue, 14 May 2019 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6T7mgXIvnET5l/tpGXLopOXL/eCRoBVjJ8wVdjfvJM=;
        b=gKMZt+rmO48Wd6LixwSFA5uP+tnHbIOOzUMW7+cBpiXeFZOAPzh53vAAif3AgkqbCQ
         1qOovLLoGbwFNYLJHR9YWAxqooTAwxUakSopoiggHN/gyfCHB9iSN5+ffCnzv5xHnSSY
         1HX5wrQvZ28MsrkDdHaV9KzwQSClciBtzVYJV+CzkD0V87c/OW4S9UkgNiWaUm00HP6O
         inW6jQyHzZS5r4rWyYh2cWIY5bhfa2eYUZvyrJwh7jBdJse1t06e3uVksOSgWbViKwtI
         wuadLwR/wSvMZP+RSe9VR5YNWctqW6aqDOo1HpmPgILV98ku9QPoARijDhLUJb+vUJ4R
         ujNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6T7mgXIvnET5l/tpGXLopOXL/eCRoBVjJ8wVdjfvJM=;
        b=dY+iMZYsAbLQgN08vMWM6f15vZhkAj+id2BMhUMgfTU8dLQZWyVb8RCOUzuUM5gvM+
         oaLkQLJQXHcblQAQ2dH76Oc1vnsIYo/MAsMPHFjNaw0fY/+Q0K1YbujqqI07c6eC2vvr
         Otn1P64/c5nX1hul+qdFXXd7Dnufj0fTeSkzsUmNdoP0h/CXTiqW27rdYJtHnMW59qFa
         SDnZnDtIvrLn6xBKuZQ5kXBjtyWMTy8YzZrcg1F0OJMdsxtRl3ltBW1un33Ydw0LTmp8
         4biQ5Dq8u0UnBFb8rmBy2z9ZjHldkpr/R2H1PpU1j2m+wIhGtrCQQ9vPu0FS8z/zzBO0
         AdIw==
X-Gm-Message-State: APjAAAVSRrFcrn8roAW+UW+kbXkLKW/o/MEJZwXsLj0tYhfiNDJgQVZo
        /hKBbh096+chA7vSGV1eWClgRA==
X-Google-Smtp-Source: APXvYqxt8u10XFlJlrW+Z8Xzk2QlxKIYWgUazpaKKgLWQ5dFhciFxSHt8Xc4H3c7OWeomT6MpjW7Zg==
X-Received: by 2002:aca:fd0c:: with SMTP id b12mr2471522oii.55.1557836033811;
        Tue, 14 May 2019 05:13:53 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:b9a9:ba56:cfab:b3bf])
        by smtp.gmail.com with ESMTPSA id f7sm6912633otb.66.2019.05.14.05.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 05:13:52 -0700 (PDT)
Date:   Tue, 14 May 2019 07:13:50 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, minyard@acm.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514121350.GA6050@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514091219.nesriqe7qplk3476@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 14, 2019 at 11:12:19AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-14 10:43:56 [+0200], Peter Zijlstra wrote:
> > Now.. that will fix it, but I think it is also wrong.
> > 
> > The problem being that it violates FIFO, something that might be more
> > important on -RT than elsewhere.
> 
> Wouldn't -RT be more about waking the task with the highest priority
> instead the one that waited the longest?
> 
> > The regular wait API seems confused/inconsistent when it uses
> > autoremove_wake_function and default_wake_function, which doesn't help,
> > but we can easily support this with swait -- the problematic thing is
> > the custom wake functions, we musn't do that.
> > 
> > (also, mingo went and renamed a whole bunch of wait_* crap and didn't do
> > the same to swait_ so now its named all different :/)
> > 
> > Something like the below perhaps.
> 
> This still violates FIFO because a task can do wait_for_completion(),
> not enqueue itself on the list because it noticed a pending wake and
> leave. The list order is preserved, we have that.
> But this a completion list. We have probably multiple worker waiting for
> something to do so all of those should be of equal priority, maybe one
> for each core or so. So it shouldn't matter which one we wake up.
> 
> Corey, would it make any change which waiter is going to be woken up?

In the application that found this, the wake order probably isn't
relevant.

For other applications, I really doubt that very many are using multiple
waiters.  If so, this bug would have been reported sooner, I think.

As you mention, for RT you would want waiter woken by priority and FIFO
within priority.  I don't think POSIX says anything about FIFO within
priority, but that's probably a good idea.  That's no longer a simple
wait queue  The way it is now is probably closer to that than what Peter
suggested, but not really that close.

This is heavily used in drivers and fs code, where it probably doesn't
matter.  I looked through a few users in mm and kernel, and they had
one waiter or were init/shutdown type things where order is not important.

So I'm not sure it's important.

-corey

> 
> Sebastian
