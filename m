From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Fri, 21 Jun 2013 15:17:54 +0100
Message-ID: <CAFSh4Uzjvqsew9yAQafO=nYtV5rOuCSdt3aRXUxDvkUBMOCdXw@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
	<CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
	<20130503160546.GF8230@linutronix.de>
	<CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
	<519B57A7.1010901@linutronix.de>
	<CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
	<51A86C1A.2040100@linutronix.de>
	<CAFSh4UyVf18mx3Pf0HbOzLWTGEMNC0rv+7H8etcvsj+R0EgSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35909 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422708Ab3FUORz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 10:17:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so7905894pad.0
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2013 07:17:54 -0700 (PDT)
In-Reply-To: <CAFSh4UyVf18mx3Pf0HbOzLWTGEMNC0rv+7H8etcvsj+R0EgSNA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 21, 2013 at 12:21 PM, Tom Cook <tom.k.cook@gmail.com> wrote:
[snip]
> I think I'm nearly starting to get my head around what's going on
> here.  The USB driver uses FIQs, which normally isn't a problem
> because nothing would interrupt the FIQ handler (or if it did, it
> wouldn't generate a page fault).  But cyclictest runs at a higher
> priority than the USB handler and generates page faults (at least when
> it is initialising).  Eventually it interrupts a USB FIQ handler and
> the memory manager doesn't know what to do with a page fault in a FIQ
> handler, so it oopses.  Does that sound about right?

Or, of course, perhaps the tracer is instrumenting the USB FIQ handler
with a hardware watchpoint.  These turn up as data aborts, which are
unhandled in FIQ mode.  Some evidence for this is that if I use
set_ftrace_filter to restrict the tracing to only a few system
functions then the crash doesn't happen.

Regards,
Tom
