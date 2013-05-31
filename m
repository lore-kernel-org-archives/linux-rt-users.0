From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Fri, 31 May 2013 10:31:01 +0100
Message-ID: <CAFSh4Uw-tAC0QugLQzFow4uRyZKw=7Gu=XC37ZYrsAuPAOrjpw@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
	<CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
	<20130503160546.GF8230@linutronix.de>
	<CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
	<519B57A7.1010901@linutronix.de>
	<CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
	<51A86C1A.2040100@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:52378 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab3EaJbD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 May 2013 05:31:03 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so888798vcb.35
        for <linux-rt-users@vger.kernel.org>; Fri, 31 May 2013 02:31:02 -0700 (PDT)
In-Reply-To: <51A86C1A.2040100@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 31, 2013 at 10:23 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
[snip]
> I just tried the same thing on my AM33xx and nothing bad happned here.
> One thing still: you might want to use "-n" for nanosleep.
>
> Could you try [0] to check if you are not using more memory than
> available? If the OOM-killer kills the program, then it is okay, if the
> data-abort exception comes or the kernel crashes in a strange way then
> it is HW.
>
> The tracer do not use any special interrupts on purpose.
> Now that I saw rasperry-pi let me ask this: do you have any
> non-mainline patches on-top? And if it is the case, could you try to
> get rid of them?

It is the linux-3.6.y branch of raspberrypi/linux on github with RT
patches added.  Nothing else custom.

> Also you can try the same test without the RT patches?

Okay.  Hopefully the flurry of spring weddings will break up enough to
give me a chance to try this over the weekend.

Tom
