From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Fri, 21 Jun 2013 17:00:44 +0200
Message-ID: <20130621150044.GE21228@linutronix.de>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
 <CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
 <20130503160546.GF8230@linutronix.de>
 <CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
 <519B57A7.1010901@linutronix.de>
 <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
 <51A86C1A.2040100@linutronix.de>
 <CAFSh4UyVf18mx3Pf0HbOzLWTGEMNC0rv+7H8etcvsj+R0EgSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39857 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161419Ab3FUPAp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 11:00:45 -0400
Content-Disposition: inline
In-Reply-To: <CAFSh4UyVf18mx3Pf0HbOzLWTGEMNC0rv+7H8etcvsj+R0EgSNA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Tom Cook | 2013-06-21 12:21:40 [+0100]:

>> The tracer do not use any special interrupts on purpose.
>> Now that I saw rasperry-pi let me ask this: do you have any
>> non-mainline patches on-top? And if it is the case, could you try to
>> get rid of them?
>
>By 'non-mainline' do you mean in addition to the kernel.org source, or
>in addition to the raspberry pi git tree?  Yes, to the former, no to
>the latter.

You could boot into ramdisk with tiny busybox + cyclictest and disable
the usb driver in question.

>> Also you can try the same test without the RT patches?
>
>Quite right - the same oops happens with "Linux raspberrypi 3.6.11+ #4 PREEMPT".
>
>I think I'm nearly starting to get my head around what's going on
>here.  The USB driver uses FIQs, which normally isn't a problem
>because nothing would interrupt the FIQ handler (or if it did, it
>wouldn't generate a page fault).  But cyclictest runs at a higher
>priority than the USB handler and generates page faults (at least when
>it is initialising).  Eventually it interrupts a USB FIQ handler and
>the memory manager doesn't know what to do with a page fault in a FIQ
>handler, so it oopses.  Does that sound about right?

You said that it oops also on non-RT kernel where cyclictest is not
running ontop of the USB thread. In general, the irq core disables the
interrupts and schedules the interrupt thread with threaded interrupt
support enabled.
But here it seems that FIQ interrupt is not implemented / suppoted
fully.
So either you have to fix this or replace the USB part :)

>Tom

Sebastian
