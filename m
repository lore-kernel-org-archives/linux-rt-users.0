From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Tue, 26 Feb 2013 21:32:39 -0500
Message-ID: <1361932359.11373.62.camel@gandalf.local.home>
References: <1361551010.32441.50.camel@marge.simpson.net>
	 <1361913901.11373.59.camel@gandalf.local.home>
	 <CAP=VYLpWCDztU6-cMR1BVCUUeaa7eqKnXM88wzoqxDCR=SKdSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:30822 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab3B0Ccl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 21:32:41 -0500
In-Reply-To: <CAP=VYLpWCDztU6-cMR1BVCUUeaa7eqKnXM88wzoqxDCR=SKdSw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-02-26 at 21:22 -0500, Paul Gortmaker wrote:

> > BTW, what kernel did you apply this too, as there's no task_setprio()
> > anymore in 3.0-rt, 3.2-rt, 3.4-rt or 3.6-rt?
> 
> Hi Steve -- are you sure on that?
> 
> ------------------
> paul@PhenomX6:~/git/linux-stable-rt$ git describe
> v3.0.66-rt93
> paul@PhenomX6:~/git/linux-stable-rt$ git grep -l task_setprio
> include/linux/sched.h
> kernel/sched.c
> paul@PhenomX6:~/git/linux-stable-rt$
> ------------------
> 

Bah! As I looked in my history I see I did the following:

  git show v3.0:include/linux/sched.h
  git show v3.2:include/linux/sched.h
  git show v3.4:include/linux/sched.h

I forgot the '-rt" on each one of them :-p

-- Steve


