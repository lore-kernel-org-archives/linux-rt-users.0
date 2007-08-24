From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3/3] fix get_monotonic_cycles for latency tracer
Date: Fri, 24 Aug 2007 14:56:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708241454250.4331@gandalf.stny.rr.com>
References: <1187978236.2941.19.camel@localhost.localdomain>
 <1187980244.6163.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:35076 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759AbXHXS46 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2007 14:56:58 -0400
In-Reply-To: <1187980244.6163.13.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
On Fri, 24 Aug 2007, john stultz wrote:

> >
> > -	/* calculate the delta since the last update_wall_time: */
> > -	cycle_delta = (cycle_now - clock->cycle_last) & clock->mask;
> > +	} while (cycle_raw != clock->cycle_raw ||
> > +		 cycle_last != clock->cycle_last);
>
> So if I'm understanding this right, not taking a lock isn't an
> optimization (as the seq read lock code is almost the same), but a
> requirement (as this might be called while xtime_lock is held),
> correct?

Exactly. The latency tracer uses this so no locks can be grabbed
(seq_locks included).

>
> Might want to clarify that a bit in the comment.
>

OK, will do and send a updated patch.

I wasn't in the best state writing this patch in the wee hours of the
night ;-)

-- Steve
