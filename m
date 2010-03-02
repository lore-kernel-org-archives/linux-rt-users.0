From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 2.6.33-rt3
Date: Tue, 2 Mar 2010 22:53:16 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003022249570.4245@localhost.localdomain>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>  <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>  <4B88E4F3.4010308@cauwe.org>  <alpine.LFD.2.00.1002271252300.4245@localhost.localdomain>
 <1267565138.6898.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Xavier Miller <xavier.miller@cauwe.org>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>, Carsten Emde <ce@ceag.ch>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56801 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab0CBVyE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Mar 2010 16:54:04 -0500
In-Reply-To: <1267565138.6898.28.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fernando,

On Tue, 2 Mar 2010, Fernando Lopez-Lezcano wrote:

> On Sat, 2010-02-27 at 12:53 +0100, Thomas Gleixner wrote:
> > On Sat, 27 Feb 2010, Xavier Miller wrote:
> > 
> > > Hello,
> > > 
> > > The name is -rt4, not -rt3
> > 
> > I pushed out an -rt4 w/o notice in the morning because I forgot to
> > pick up a few trivial fixes for -rt3.
> 
> Hmm, I had to comment out a VM_BUG_ON for pkmap_count in mm/highmem.c,
> looks like pkmap_count is not defined anywhere else?

yuck, did not notice due to CONFIG_VM_DEBUG=n. Will fix.

Thanks,

	tglx
