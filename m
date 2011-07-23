From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt2
Date: Sat, 23 Jul 2011 19:41:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107231936400.2702@ionos>
References: <alpine.LFD.2.02.1107231706380.2702@ionos> <201107231317.05234.edt@aei.ca> <201107231334.23216.edt@aei.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ed Tomlinson <edt@aei.ca>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41915 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab1GWRlz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 13:41:55 -0400
In-Reply-To: <201107231334.23216.edt@aei.ca>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 23 Jul 2011, Ed Tomlinson wrote:

> On Saturday 23 July 2011 13:17:04 Ed Tomlinson wrote:
> > On Saturday 23 July 2011 11:13:30 Thomas Gleixner wrote:
> > > I'm pleased to announce the 3.0-rt2 release.
> > > 
> > > Changes versus 3.0-rt1:
> > > 
> > >   * mqueue fix (Yoshitake Kobayashi)
> > > 
> > >   * dca locking fix (Mike Galbraith)
> > > 
> > >   * trace updates (Carsten Emde)
> > > 
> > >   * Fixed vprintk wreckage and rcutorture (tglx)
> > > 
> > > Known issues:
> > > 
> > >   * Some weird "console=..." commandline + config dependent
> > >     interactions which have been not yet investigated down to their
> > >     root cause. Result in a boot hang. YMMV
> 
> Got this warning too.  Was a change was missed?
> 
> [  364.392603] NOHZ: local_softirq_pending 08

Forgot to disable NOHZ for now, have not yet had time to investigate
that local_softirq_pending warning.

> [  905.155441] WARNING: at kernel/trace/trace.c:2729 tracing_ctrl_write+0x203/0x220()
> [  905.155447] Hardware name: System Product Name
> [  905.155452] tracing_enabled is deprecated. Use tracing_on

     		 ^^^^
Thanks,

	tglx
