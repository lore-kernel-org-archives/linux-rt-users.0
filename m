Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:51018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeGEP7b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Jul 2018 11:59:31 -0400
Date: Thu, 5 Jul 2018 17:59:24 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.14.52-rt34
Message-ID: <20180705155924.o7p6dzng5zddrag4@linutronix.de>
References: <20180629190320.6316b93b@gandalf.local.home>
 <1530539980.15603.85.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1530539980.15603.85.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-rt-users <linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, Julia Cartwright <julia@ni.com>, Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com

On 2018-07-02 15:59:40 [+0200], Mike Galbraith wrote:
> On Fri, 2018-06-29 at 19:03 -0400, Steven Rostedt wrote:
> > Dear RT Folks,
> > 
> > I'm pleased to announce the 4.14.52-rt34 stable release.
> > 
> > This includes the merging of the stable releases, but also required
> > pulling in ("Revert mm/vmstat.c: fix vmstat_update() preemption BUG")
> > because v4.14.45 pulled in commit c7f26ccfb2c3 ("mm/vmstat.c: fix
> > vmstat_update() preemption BUG") which broke RT.
> 
> Good timing, I met that when I tried 4.14-rt on a 48 core arm thing.

Is this new within the v4.14-rt tree (like a patch from the stable tree
caused it) or was it maybe always there?

Sebastian
