From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT git pull] fixes for rt/sched
Date: Wed, 14 Jan 2009 11:57:53 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901141157040.15549@gandalf.stny.rr.com>
References: <20090114162226.13517.44371.stgit@dev.haskins.net> <496E12D3.80804@novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: john stultz <johnstul@us.ibm.com>,
	Gregory Haskins <gregory.haskins@gmail.com>,
	rostedt@home.goodmis.org, linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:60622 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762379AbZANQ55 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Jan 2009 11:57:57 -0500
In-Reply-To: <496E12D3.80804@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 14 Jan 2009, Gregory Haskins wrote:

> [ Forgot to CC John the first time around ]
> 
> Gregory Haskins wrote:
> > The following changes since commit cfe6498c6a03e574bc9384cc95d73dfd20a13f05:
> >   Steven Rostedt (1):
> >         rt sched: add rt overload stats
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/linux-2.6-hacks.git rt/sched
> >
> > Gregory Haskins (1):
> >       rt/sched: ensure interrupts are disabled during post-schedule() processing
> >
> >  kernel/sched_rt.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >


Thanks, applied.

(to git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt.git)

-- Steve

