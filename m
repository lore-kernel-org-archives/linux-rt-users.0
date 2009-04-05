From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: System deadlock on 2.6.24-rt20 (-rt27 panics on
 locking-api-selftests)
Date: Sun, 5 Apr 2009 13:00:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904051257470.747@localhost.localdomain>
References: <3efb10970904030502q1068731fl5b92f93d5341b43e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56504 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756712AbZDELB5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 07:01:57 -0400
In-Reply-To: <3efb10970904030502q1068731fl5b92f93d5341b43e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 3 Apr 2009, Remy Bohmer wrote:

> Hello Thomas,
> 
> 2009/4/3 Remy Bohmer <linux@bohmer.net>:
> > Hello Thomas,
> >
> >>> Does anybody recognise these backtraces? And if so, is there a fix for
> >>> it already?
> >>
> >> http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.24.7-rt27.bz2
> 
> I integrated -rt27, but this one fails on the locking api-selftests.
> Is this a bug in the selftest? Or is there a real locking bug behind
> it?

Don't think so. The rw locks fixups which we did between -rt20 and
-rt27 might have screwed the lockdep selftests where we create
deadlock situations. What happens if you disable the self tests ?

Thanks,

	tglx
