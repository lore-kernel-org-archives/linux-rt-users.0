From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Tue, 26 Feb 2013 21:35:13 -0500
Message-ID: <1361932513.11373.65.camel@gandalf.local.home>
References: <1361551010.32441.50.camel@marge.simpson.net>
	 <1361913901.11373.59.camel@gandalf.local.home>
	 <CAP=VYLpWCDztU6-cMR1BVCUUeaa7eqKnXM88wzoqxDCR=SKdSw@mail.gmail.com>
	 <1361932359.11373.62.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:6958 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758833Ab3B0CfP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 21:35:15 -0500
In-Reply-To: <1361932359.11373.62.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-02-26 at 21:32 -0500, Steven Rostedt wrote:

> Bah! As I looked in my history I see I did the following:
> 
>   git show v3.0:include/linux/sched.h
>   git show v3.2:include/linux/sched.h
>   git show v3.4:include/linux/sched.h
> 
> I forgot the '-rt" on each one of them :-p

That said...

Only v3.0-rt has it. I'm barely supporting that now, and I'm only doing
updates that might make sense. Greg should be dropping it soon, and so
will I. There's issues in v3.0-rt that are not in v3.2-rt or above, that
I'm not going to bother debugging.

I'll test a patch against the others but not one against v3.0-rt.

-- Steve


