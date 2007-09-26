From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Wed, 26 Sep 2007 17:27:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709261726440.6803@gandalf.stny.rr.com>
References: <1188593944.9647.15.camel@chaos>  <1189427714.21778.15.camel@twins>
 <1190841410.18147.41.camel@lappy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40137 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbXIZV1V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 17:27:21 -0400
In-Reply-To: <1190841410.18147.41.camel@lappy>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Wed, 26 Sep 2007, Peter Zijlstra wrote:

> On Mon, 2007-09-10 at 14:35 +0200, Peter Zijlstra wrote:
> > > A bunch of patches are postponed for -rt2 (they are neither ignored
> > > nor forgotten):
> > >
> > > - simple_irq change (Kevin Hilman): needs more thought
> > > - RCU updates (Paul McKenney): needs proper integration
> > > - latency tracer changes (Daniel Walker): needs review
> > > - PICK_OP changes (Daniel Walker): needs review
> >
> > This one seems to have slipped through the cracks:
> >   http://lkml.org/lkml/2007/8/16/135
>
> Seems to be missed again :-/
>

Will work on that tonight.

-- Steve
