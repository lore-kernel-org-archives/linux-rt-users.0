From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 7 Nov 2007 14:59:19 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711071454450.1040@gandalf.stny.rr.com>
References: <1194413959.8827.66.camel@localhost.localdomain> <473222E2.8030007@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:34915 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbXKGT7W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 14:59:22 -0500
In-Reply-To: <473222E2.8030007@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 7 Nov 2007, Dragan Noveski wrote:

> Steven Rostedt wrote:
> >
> > Currently, what we do to test RT latencies is to run Thomas Gleixner's
> > cyclictest
> > (http://git.kernel.org/?p=linux/kernel/git/tglx/rt-tests.git;a=summary)
> > as well as hackbench, to see what the maximum latencies we get are.
> >
>
> hallo, can please someone suggest for how long time you are running
> cyclictest?
> if i run it for about 3 min. i get a feeling that the values will not
> change anymore, so is there any recommended time for how long to run it?

Actually, you want to run it for a long time, and under very heavy load.
I'm currently running it while doing a "make -j128" on a kernel tree. This
takes several hours to complete the make. So far with -rt11 I have a max
latency with one RT thread at the prio of 98 68us.

When you do run cyclic test, make sure you run it at a higher priority
than the irq threads. And also use the -n option since the default is to
test signals, and that part of the test isn't working so well.

Here's what I'm running right now:

./cyclictest -n -p98 -t1 -i250

While doing that "make -j120"

>
> another thing i do not know is, if i run cyclictest for lets say 3
> minutes, than stop ('ctrl+c') and than start again, i get often
> different values. so is it recommended to run it more times and than to
> pick up the best/worst cases.
>
> i have done some tests already with rt7,8 and 10 but i am not sure if
> the tests make any sense - thats why i would really appreciate some
> answers on the both questions.
>

Actually I didn't want to discourage you. For UP, -rt7,8 and 10 really
should be exactly the same (with some noise factures apart). The changes
that were made supposable only affect SMP boxes. But, I'm glad you are
doing the tests, since we also would like to know if anything creeped into
te UP side, and has caused any regressions.

Thanks, for taking the time to test this.

-- Steve
