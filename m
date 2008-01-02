From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] Markers Implementation for Preempt RCU Boost
	Tracing
Date: Wed, 2 Jan 2008 18:01:57 +0100
Message-ID: <20080102170157.GA11161@elte.hu>
References: <20071231060911.GB6461@in.ibm.com> <20071231102045.GB30380@elte.hu> <y0modc4vr7a.fsf@ton.toronto.redhat.com> <20080102124734.GC11208@elte.hu> <20080102163309.GC11496@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "K. Prasad" <prasad@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	dipankar@in.ibm.com, ego@in.ibm.com, mathieu.desnoyers@polymtl.ca,
	paulmck@linux.vnet.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60052 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbYABRC3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jan 2008 12:02:29 -0500
Content-Disposition: inline
In-Reply-To: <20080102163309.GC11496@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Frank Ch. Eigler <fche@redhat.com> wrote:

> > [...] this is a general policy matter. It is _so much easier_ to add 
> > markers if they _can_ have near-zero overhead (as in 1-2 
> > instructions). Otherwise we'll keep arguing about it, especially if 
> > any is added to performance-critical codepath. (where we are 
> > counting instructions)
> 
> The effect of the immediate-values patch, combined with gcc 
> CFLAGS+=-freorder-blocks, *is* to keep the overhead at 1-2 
> dcache-impact-free instructions.  The register saves, parameter 
> evaluation, the function call, can all be moved out of line.

well, -freorder-blocks seems to be default-enabled at -O2 on gcc 4.2, so 
we should already be getting that, right?

There's one thing that would make out-of-line tracepoints have a lot 
less objectionable to me: right now the 'out of line' area is put to the 
end of functions. That splinters the kernel image with inactive, rarely 
taken areas of code - blowing up its icache footprint considerably. For 
example sched.o has ~100 functions, with the average function size being 
200 bytes. At 64 bytes L1 cacheline size that's a 10-20% icache waste 
already.

It's true that keeping the off-site code within the function keeps total 
codesize slightly smaller, because the offsets (and hence the 
conditional jumps) are thus 8 bit - but that's below 1% and the 
cache-blow-up aspect is more severe in practice at 10-20%.

So it would be nice if we could collect all this offline code and stuff 
it away into another portion of the kernel image. (or, into another 
portion of the object file - which would still be good enough in 
practice)

	Ingo
