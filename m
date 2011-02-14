From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Mon, 14 Feb 2011 15:35:55 -0800
Message-ID: <1297726555.10271.21.camel@quadrophenia>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
	 <1297724643.10271.16.camel@quadrophenia>
	 <AANLkTi=V0Uth=30v4M2g=eJ6utLWFPO4XCeqTJWBSMLL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62505 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab1BNXgC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Feb 2011 18:36:02 -0500
Received: by wyb28 with SMTP id 28so5298531wyb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2011 15:36:01 -0800 (PST)
In-Reply-To: <AANLkTi=V0Uth=30v4M2g=eJ6utLWFPO4XCeqTJWBSMLL@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-02-14 at 15:08 -0800, Peter LaDow wrote:
> Note sure how that is possible.  This is related to my earlier posting
> about timing jitter.  Our code is basically this:
> 

Where is the semicolon ending the for loop?


> while(1)
> {
>   t1 = clock_gettime()
>   for(i=0; i < 10000; i++)
>   t2 = clock_gettime()
> 
>   diff = t2 - 1
> }
> 
> This task is pending on nothing.  Unless clock_gettime() causes some
> sort of priority inversion, I don't see the problem.  We see
> significant jitter on the for-loop when there are a significant number
> of other kernel timers.  Now, as we understand it, the hrtimers run in
> the softirq.  But if the softirq is priority 50, and this for-loop is
> priority 99, it shouldn't be affected by the softirq thread.
> 
> Pete
> 
> On Mon, Feb 14, 2011 at 3:04 PM, Sven-Thorsten Dietrich
> <thebigcorporation@gmail.com> wrote:
> > On Mon, 2011-02-14 at 14:31 -0800, Peter LaDow wrote:
> >> How is the scheduling of the hrtimers softirq thread handled?
> >>
> >> When querying the RT priority of the hrtimer softirq, I get a priority
> >> of 50.  But when running a priority 99 thread, we still seem to be
> >> getting interrupted.  Shouldn't the hrtimer softirq be put off until
> >> the CPU is idle or a lower priority task is running?
> >
> > Does your prio 99 thread perhaps encounter a prio inversion dependency
> > on one of the softriq threads?
> >
> >>
> >> Thanks,
> >> Pete
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >


