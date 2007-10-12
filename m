From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/7] RT: (RFC) RT-Overload/Sched enhancements
Date: Fri, 12 Oct 2007 07:47:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710120745310.8793@gandalf.stny.rr.com>
References: <20071011213916.27097.42597.stgit@novell1.haskins.net>
 <1192184985.27435.17.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64143 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbXJLLrr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 07:47:47 -0400
In-Reply-To: <1192184985.27435.17.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Fri, 12 Oct 2007, Peter Zijlstra wrote:

>
> And for that, steve's rq->curr_prio field seems quite suitable.
>
> so instead of the:
>   for (3 tries)
>     find lowest cpu
>     try push
>
> we do:
>
>   cpu_hotplug_lock();
>   cpus_and(mask, p->cpus_allowed, online_cpus);
>   for_each_cpu_mask(i, mask) {
>     if (cpu_rq(i)->curr_prio > p->prio && push_task(p, i))
>       break;
>   }
>   cpu_hotplug_unlock();

The thing I'm worried about is that we pushed off a rt task that is higher
in prio than another rt task on another cpu, and we'll cause a bunch of
rt task bouncing.  That is what I'm trying to avoid.

BTW, my logging has showed that I have yet to hit a 2cd try (but I admit,
this is a very limited test set).

-- Steve
