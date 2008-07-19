From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Date: Sat, 19 Jul 2008 13:53:33 +1000
Message-ID: <1216439613.7740.470.camel@pasglop>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	 <1216085521.7740.37.camel@pasglop>
	 <20080717125645.GN20277@linux.vnet.ibm.com>
	 <1216325671.7740.359.camel@pasglop>
	 <20080718101133.GO20277@linux.vnet.ibm.com>
	 <1216418730.7740.451.camel@pasglop>
	 <Pine.LNX.4.58.0807182123510.4932@gandalf.stny.rr.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Chirag Jog <chirag@linux.vnet.ibm.com>,
	linux.kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45768 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbYGSD7d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2008 23:59:33 -0400
In-Reply-To: <Pine.LNX.4.58.0807182123510.4932@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> There's lots of semantics that are changed with -rt that should make
> everything still work ;-)  Some spinlocks remain real spinlocks, but we
> shouldn't have a problem with most being mutexes.
> 
> There's some cases that uses per CPU variables or other per cpu actions
> that require a special CPU_LOCK that protects the data in a preemption
> mode. The slab.c code in -rt handles this.

Well, there is at least in my case a whole class of code that assumes
that because the whole thing happens within a spinlock section at the
toplevel, it could not only access per_cpu variables using the
__variants, that's easy, but it also assumes that it can add things bit
by bit as it gets called at the lower level to that per-cpu cache. It's
not actually prepared for possibly migrating to another CPU right in the
middle. 

I need to review that stuff a bit. I think we fixed some of that at one
point, and we made sure that the context switch itself would flush
pending MMU batches, so it -may- be fine in that specific case.

Cheers,
Ben. 

