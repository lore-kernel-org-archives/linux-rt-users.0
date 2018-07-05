Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:34799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753322AbeGEQQX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Jul 2018 12:16:23 -0400
Message-ID: <1530807358.15395.10.camel@gmx.de>
Subject: Re: [ANNOUNCE] 4.14.52-rt34
From: Mike Galbraith <efault@gmx.de>
Date: Thu, 05 Jul 2018 18:15:58 +0200
In-Reply-To: <20180705120800.3fcdeff2@gandalf.local.home>
References: <20180629190320.6316b93b@gandalf.local.home>
         <1530539980.15603.85.camel@gmx.de>
         <20180705155924.o7p6dzng5zddrag4@linutronix.de>
         <20180705120800.3fcdeff2@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, Julia Cartwright <julia@ni.com>, Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com

On Thu, 2018-07-05 at 12:08 -0400, Steven Rostedt wrote:
> On Thu, 5 Jul 2018 17:59:24 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2018-07-02 15:59:40 [+0200], Mike Galbraith wrote:
> > > On Fri, 2018-06-29 at 19:03 -0400, Steven Rostedt wrote:  
> > > > Dear RT Folks,
> > > > 
> > > > I'm pleased to announce the 4.14.52-rt34 stable release.
> > > > 
> > > > This includes the merging of the stable releases, but also required
> > > > pulling in ("Revert mm/vmstat.c: fix vmstat_update() preemption BUG")
> > > > because v4.14.45 pulled in commit c7f26ccfb2c3 ("mm/vmstat.c: fix
> > > > vmstat_update() preemption BUG") which broke RT.  
> > > 
> > > Good timing, I met that when I tried 4.14-rt on a 48 core arm thing.  
> > 
> > Is this new within the v4.14-rt tree (like a patch from the stable tree
> > caused it) or was it maybe always there?
> > 
> 
> I took his comment about "It now boots and works fine" meaning that it
> didn't even boot before. Thus it is working better.

Yes, first build on arm64 box (just before you released -rt34) died
screaming.  Applying update, it just worked (modulo boot time splat).

	-Mike
