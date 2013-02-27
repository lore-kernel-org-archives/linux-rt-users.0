From: Mike Galbraith <bitbucket@online.de>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Wed, 27 Feb 2013 05:55:00 +0100
Message-ID: <1361940900.4599.108.camel@marge.simpson.net>
References: <1361551010.32441.50.camel@marge.simpson.net>
	 <1361913901.11373.59.camel@gandalf.local.home>
	 <CAP=VYLpWCDztU6-cMR1BVCUUeaa7eqKnXM88wzoqxDCR=SKdSw@mail.gmail.com>
	 <1361932359.11373.62.camel@gandalf.local.home>
	 <1361932513.11373.65.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49329 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758711Ab3B0EzF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 23:55:05 -0500
In-Reply-To: <1361932513.11373.65.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-02-26 at 21:35 -0500, Steven Rostedt wrote: 
> On Tue, 2013-02-26 at 21:32 -0500, Steven Rostedt wrote:
> 
> > Bah! As I looked in my history I see I did the following:
> > 
> >   git show v3.0:include/linux/sched.h
> >   git show v3.2:include/linux/sched.h
> >   git show v3.4:include/linux/sched.h
> > 
> > I forgot the '-rt" on each one of them :-p
> 
> That said...
> 
> Only v3.0-rt has it. I'm barely supporting that now, and I'm only doing
> updates that might make sense. Greg should be dropping it soon, and so
> will I. There's issues in v3.0-rt that are not in v3.2-rt or above, that
> I'm not going to bother debugging.

Yeah, I'm stuck with 3.0, so my 3.0 is not as virgin as I would like it
to be.  It has threaded sirqs because I must have them, can turn cpupri
and nohz on/off on the fly because I must have to have that too to make
80 core boxen with tight jitter constraint be all they can be. 

> I'll test a patch against the others but not one against v3.0-rt.

64 core test box has microscopic root and newer kernel drivers break its
userspace.  Putting a newer rt kernel on it to play is a pita, so I do
big box tinkering in 3.0.  I can make a 3.6 hacklet during the weekend.

-Mike

