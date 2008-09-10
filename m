From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24.7-rt18
Date: Wed, 10 Sep 2008 07:32:01 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0809100731420.23257@gandalf.stny.rr.com>
References: <1221018283.22713.20.camel@localhost.localdomain> <20080910060624.GA7484@in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:38454 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYIJLcE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Sep 2008 07:32:04 -0400
In-Reply-To: <20080910060624.GA7484@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 10 Sep 2008, Ankita Garg wrote:

> Hi Steven,
> 
> On Tue, Sep 09, 2008 at 11:44:42PM -0400, Steven Rostedt wrote:
> > We are pleased to announce the 2.6.24.7-rt18 tree, which can be
> > downloaded from the location:
> > 
> >   http://rt.et.redhat.com/download/
> > 
> > Information on the RT patch can be found at:
> > 
> >   http://rt.wiki.kernel.org/index.php/Main_Page
> > 
> > Changes since 2.6.24.7-rt17
> > 
> >   - seqlock serialize writes (Gregory Haskins)
> > 
> >   - Fix above patch that broke non PREEMPT_RT (Steven Rostedt)
> > 
> >   - Add sysctl to warn on RT task using non PI futex (Steven Rostedt)
> >
> 
> A trivial patch to remove the hard coded value of MAX_RT_PRIO in the
> above patch.

Thanks, I pulled it into the queue.

-- Steve
