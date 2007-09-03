From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Sun, 2 Sep 2007 21:16:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709022114040.10344@gandalf.stny.rr.com>
References: <1188593944.9647.15.camel@chaos>  <1188604887.26038.110.camel@dhcp193.mvista.com>
 <1188631638.17941.11.camel@chaos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Walker <dwalker@mvista.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45400 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbXICBQu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Sep 2007 21:16:50 -0400
In-Reply-To: <1188631638.17941.11.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Sat, 1 Sep 2007, Thomas Gleixner wrote:

> On Fri, 2007-08-31 at 17:01 -0700, Daniel Walker wrote:
> >
> > I'm not sure which latency tracing fixes these are, but Steven's
> > get_monotonic_cycles() changes are racy .. It might be a little
> > premature to include them .. It at least fouls latency tracing on my
> > test machine.
>
> Worked fine here, but I take it out again when it causes problems on
> your box. Steven ???

Yeah, I talked with Daniel too about it. I need to look more into it.
I haven't had time since I'm spending the weekend (Monday too, since it's
a holiday in the US), moving to my new house.

There is a race, but honestly, it will be a merical to happen, and if it
does, it only gives the results that we had "before" the patches ;-)

But take them out, until I get to the bottom of them. But that won't be
until "earliest" Tuesday.

Thanks,

-- Steve
