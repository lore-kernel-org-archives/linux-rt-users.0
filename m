From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Tue, 21 May 2013 13:16:55 +0200
Message-ID: <519B57A7.1010901@linutronix.de>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com> <CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com> <20130503160546.GF8230@linutronix.de> <CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Tom Cook <tom.k.cook@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50347 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3EULQ5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 May 2013 07:16:57 -0400
In-Reply-To: <CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

please CC the list.

On 05/11/2013 06:43 PM, Tom Cook wrote:
> Okay, I've built the same kernel config but without kgdb enabled.
> Running cyclictest with a tracer enabled (-f in this case) causes the
> crash below.
> 
> I'm not big on debugging these things yet.  Since cyclictest works
> without the tracers enabled and causes a crash with them enabled, the
> problem must be in the tracers themselves, right?  Actually, 'echo
> function > current_tracer' has the same effect.
> 
> Is that trace really saying that the processor is in mode 0?  AFAICT,
> ARM does not have a mode 0 unless you truncate the mode number to four
> bits - in which case mode '0' is user mode.  The process name seems to
> be a red herring - repeating this can turn up almost any process
> running on the system, from interrupt handler threads to bash.
> 
> Is this a known problem?  Any tips on figuring it out?

Not known until you brought that up. I just booted x86 with kgdb=y and
did "echo function > current_tracer" with no side effects. I don't have
ARM at hand right now. Do you do anything kgdb related besides enabling
it in the kernel?

> 
> Thanks,
> Tom

Sebastian
