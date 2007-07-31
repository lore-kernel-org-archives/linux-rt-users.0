From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2][RFC] VFCIPI v3
Date: Tue, 31 Jul 2007 17:40:12 +0200
Message-ID: <1185896412.12034.17.camel@twins>
References: <20070731132153.4790.37217.stgit@novell1.haskins.net>
	 <1185891957.12034.12.camel@twins>  <46AF1DA6.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34879 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXGaPkQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 11:40:16 -0400
In-Reply-To: <46AF1DA6.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-07-31 at 11:33 -0400, Gregory Haskins wrote:
> >>> On Tue, Jul 31, 2007 at 10:25 AM, in message <1185891957.12034.12.camel@twins>,
> Peter Zijlstra <peterz@infradead.org> wrote: 

> >(with mistakes).
> 
> If there was anything more than what you already mention here, please
> point them out so I don't "port" them over to the workqueues
> implemenation ;)

The two that jumped out at me while skimming over the code were:

 - use of raw_spinlock_t (while not always a bug, it does need _very_
   good justification)
 - not cpu hotplug safe


> > Your idea that GFP_ATOMIC is broken in -rt is unfortunate, it isn't. The
> > whole allocator is preemptable - that is a feature!
> 
> Heh...that may be, and I can see how it is useful to have the
> allocatorr be generally preemptible.  However, I would have thought
> that "GFP_ATOMIC" means I can call it from atomic code, which is not
> the case apparently.  It's probably just my own ignorance again of
> what that flag should really mean ;)
> 
> In any case I abstracted the heap_allocator away so that I could make
> an in_atomic friendly allocation.  If the GFP_ATOMIC allocator ever
> supports in_atomic in the future, all we have to do is change
> vfcipi/heap.h.  I am open to other suggestions to this problem, of
> course.

The thing is, we should never need to allocate from a real atomic
context, every time you end up in that situation, ask yourself if the
problem can be solved differently. That is, it often points at a design
flaw.

Peter
