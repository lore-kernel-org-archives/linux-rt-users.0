From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.6-rt9
Date: Sat, 28 Dec 2013 04:30:49 +0100
Message-ID: <1388201449.5387.70.camel@marge.simpson.net>
References: <20131223225017.GA8623@linutronix.de>
	 <20131227200024.GA19505@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49933 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab3L1Day (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Dec 2013 22:30:54 -0500
In-Reply-To: <20131227200024.GA19505@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-12-27 at 21:00 +0100, Nicholas Mc Guire wrote: 
> On Mon, 23 Dec 2013, Sebastian Andrzej Siewior wrote:
> 
> > Dear RT folks!
> > 
> > I'm pleased to announce the v3.12.6-rt9 patch set.
> > 
> > Changes since v3.12.6-rt8
> <snip>
> > - A patch from Thomas Gleixner not to raise the timer softirq
> >   unconditionally (only if a timer is pending)
> > 
> 
> This one seems to deadlock early in the boot sequence on x86
> (i3/i7/Phenom-4x here and Carsten Emde also had boot failures)
> 
> after droping this patch with:
> patch -p1 -R < ../paches/timers-do-not-raise-softirq-unconditionally.patch
> 3.12.6-rt9 boots up fine. cyclictest seems to be back to what it was before
> (only ran for a few minutes idle and 1h with load on an i3).
> 
> The main problem with this patch though are proceduaral isues 
> the commit note - which is a mail exchange - actually does not explain what 
> the rational for the changes is

Raising the timer softirq unconditionally wakes ksoftirqd at every tick,
so the only time the no_hz_full "one and only one task is runnable" tick
shutdown criteria can be met is when the box has zero other runnable
tasks.. i.e. when box is idle.

Here, patch works fine boot wise, and no_hz_full tick shutdown works as
well, but there are a couple spots where taking an interrupt is a bad
idea as things sit.  Watchdog barked at two such spots, and there's a
"you _will_ hit this warning in -rt" spot as well.  

With bandaids on the sore spots, my 64 core box survives.

-Mike

(Less than wonderful changelogs probably comes from the fact that
maintaining -rt out of tree is time consuming as all hell.  Everybody
gets to breaks it, a couple guys get to fix it up again and again.)

