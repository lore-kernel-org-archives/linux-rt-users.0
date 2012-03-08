From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Thu, 08 Mar 2012 21:08:23 +0100
Message-ID: <1331237303.11248.413.camel@twins>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>
	 <1331230991.25686.452.camel@gandalf.stny.rr.com>
	 <1331231287.11248.396.camel@twins>
	 <1331232159.25686.456.camel@gandalf.stny.rr.com>
	 <1331236139.11248.407.camel@twins>
	 <1331236900.25686.462.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56633 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758637Ab2CHUId convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2012 15:08:33 -0500
In-Reply-To: <1331236900.25686.462.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-03-08 at 15:01 -0500, Steven Rostedt wrote:
> 
> What I was hinting at was that the spin_lock() can boost, but it could
> also fail if there was a deadlock detected, and it wouldn't cause the
> system to hang. 

Right, that's spin_deadlock() ;-) And you can in fact write
spin_trydeadlock() as:

int spin_trydeadlock(spinlock_t *lock)
{
	return spin_deadlock(lock) != -EDEADLK;
}

The advantage of introducing spin_trydeadlock() is that you can merge it
upstream (modulo naming) and the !RT code won't change at all.

IIRC tglx said there were more sites than just the dcache that did this
inverse lock order trylock game.

Seems we're agreeing more than disagreeing.. anyway, if you care to give
it a go.. worst that can happen is that you'll get as big a mess as tglx
got :-)
