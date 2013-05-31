From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Fri, 31 May 2013 11:23:38 +0200
Message-ID: <51A86C1A.2040100@linutronix.de>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com> <CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com> <20130503160546.GF8230@linutronix.de> <CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com> <519B57A7.1010901@linutronix.de> <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36802 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab3EaJXj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 May 2013 05:23:39 -0400
In-Reply-To: <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/21/2013 05:20 PM, Tom Cook wrote:
> No.  I've also tried compiling without kgdb and enabling tracers still
> causes a crash (see below).
> 
> Again, I'm far from expert here, but as near as I can tell, a fast
> interrupt exception handler is causing a data abort exception.  Do the
> tracers use fast interrupts to wake up?  Is there some tracer-related
> memory that's getting swapped out?

I just tried the same thing on my AM33xx and nothing bad happned here.
One thing still: you might want to use "-n" for nanosleep.

Could you try [0] to check if you are not using more memory than
available? If the OOM-killer kills the program, then it is okay, if the
data-abort exception comes or the kernel crashes in a strange way then
it is HW.

The tracer do not use any special interrupts on purpose.
Now that I saw rasperry-pi let me ask this: do you have any
non-mainline patches on-top? And if it is the case, could you try to
get rid of them?
Also you can try the same test without the RT patches?

[0] http://download.breakpoint.cc/malloc.c

Sebastian
