From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Fri, 21 Jun 2013 12:21:40 +0100
Message-ID: <CAFSh4UyVf18mx3Pf0HbOzLWTGEMNC0rv+7H8etcvsj+R0EgSNA@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
	<CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
	<20130503160546.GF8230@linutronix.de>
	<CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
	<519B57A7.1010901@linutronix.de>
	<CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
	<51A86C1A.2040100@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42070 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3FULVk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 07:21:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so7748662pad.28
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2013 04:21:40 -0700 (PDT)
In-Reply-To: <51A86C1A.2040100@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 31, 2013 at 10:23 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
[snip]
> I just tried the same thing on my AM33xx and nothing bad happned here.
> One thing still: you might want to use "-n" for nanosleep.

Same result.

> Could you try [0] to check if you are not using more memory than
> available? If the OOM-killer kills the program, then it is okay, if the
> data-abort exception comes or the kernel crashes in a strange way then
> it is HW.

Seems to be killed by the OOM-killer - see output below.

> The tracer do not use any special interrupts on purpose.
> Now that I saw rasperry-pi let me ask this: do you have any
> non-mainline patches on-top? And if it is the case, could you try to
> get rid of them?

By 'non-mainline' do you mean in addition to the kernel.org source, or
in addition to the raspberry pi git tree?  Yes, to the former, no to
the latter.

> Also you can try the same test without the RT patches?

Quite right - the same oops happens with "Linux raspberrypi 3.6.11+ #4 PREEMPT".

I think I'm nearly starting to get my head around what's going on
here.  The USB driver uses FIQs, which normally isn't a problem
because nothing would interrupt the FIQ handler (or if it did, it
wouldn't generate a page fault).  But cyclictest runs at a higher
priority than the USB handler and generates page faults (at least when
it is initialising).  Eventually it interrupts a USB FIQ handler and
the memory manager doesn't know what to do with a page fault in a FIQ
handler, so it oopses.  Does that sound about right?

Tom
