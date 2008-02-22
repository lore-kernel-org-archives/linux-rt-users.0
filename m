From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH [RT] 05/14] rearrange rt_spin_lock sleep
Date: Fri, 22 Feb 2008 08:43:38 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802220841230.15391@gandalf.stny.rr.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
 <20080221152651.4804.4702.stgit@novell1.haskins.net> <47BECE30.8030100@gmail.com>
 <20080222133541.GA8868@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gregory.haskins@gmail.com, Gregory Haskins <ghaskins@novell.com>,
	a.p.zijlstra@chello.nl, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:47248 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbYBVNnq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Feb 2008 08:43:46 -0500
In-Reply-To: <20080222133541.GA8868@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 22 Feb 2008, Ingo Molnar wrote:

>
> * Gregory Haskins <gregory.haskins.ml@gmail.com> wrote:
>
> > My assumption is that the xchg() (inside update_current()) acts as an
> > effective wmb().  If xchg() does not have this property, then this
> > code is broken and patch 6/14 should also add a:
>
> xchg() is a strong implicit memory barrier, it implies smp_mb().
> (historic sidenote: it was the very first SMP primitive we had in
> Linux.)

OK, I've been proven wrong ;-)

I was just thinking of how an arch would implement it. No need for memory
barriers in just an xchg. But if Linux "implies it" then that's another
story.

Thanks,

-- Steve

/me learns something new everyday.
