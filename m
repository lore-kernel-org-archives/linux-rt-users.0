From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compile bug in 2.6.24.8-rt7 on ARM
Date: Tue, 20 May 2008 16:55:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805201650290.20236@gandalf.stny.rr.com>
References: <3efb10970805201337g2212835bl9ca26a3031141ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:44197 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758437AbYETUzD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 16:55:03 -0400
In-Reply-To: <3efb10970805201337g2212835bl9ca26a3031141ce2@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Remy Bohmer wrote:

> Hello Steven,
>
> Now I started looking at compiling 2.6.24.7-rt8 for ARM, and I found
> another compile problem... ;-))
>
> This one:
>  CC      arch/arm/kernel/process.o
> arch/arm/kernel/process.c: In function 'cpu_idle':
> arch/arm/kernel/process.c:175: error: implicit declaration of function
> 'trace_preempt_exit_idle'
> arch/arm/kernel/process.c:180: error: implicit declaration of function
> 'trace_preempt_enter_idle'
>
> These function do not appear to exist _anywhere_ in the kernel.
> So these calls can safely be removed, I guess.
>
> The offending patch can be found in the broken-out set under the name
> arm-trace-preempt-idle.patch.
> Attached you can find a fix for it (I expect that you will not need it)

Thanks Remy,

Yes that was left over from the latency_trace conversion to ftrace. Note,
I have yet (nor anyone else) ported the new ftrace to arm. That is going
to be needed soon.

If you want to do it (hint hint) don't waste your time on the -rt ftrace.
That will soon be revamped to get back in line with upstream ftrace, which
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git

Look for the ftrace branch. Any work on ftrace should be done against
that. I will be working on getting -rt up to that version, but first I'll
need to send over a few fixes to ftrace there too.

Thanks,

-- Steve

