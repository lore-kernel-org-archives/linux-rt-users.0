From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Date: Fri, 18 Jul 2008 06:14:31 +1000
Message-ID: <1216325671.7740.359.camel@pasglop>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	 <1216085521.7740.37.camel@pasglop>
	 <20080717125645.GN20277@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux.kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43470 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758745AbYGQUXm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jul 2008 16:23:42 -0400
In-Reply-To: <20080717125645.GN20277@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> All these operations are done assuming that tlb_gather_mmu disables
> preemption and tlb_finish_mmu enables preemption again.
> This is not true for -rt.
> For x86, none of the code paths between tlb_gather_mmu and
> tlb_finish_mmu access any per_cpu variables.
> But this is not true for powerpc64 as we can see.
> 
> One way could be to make tlb_gather_mmu disable preemption as it does
> in mainline but only for powerpc.
> Although i am not sure, if this is the right step ahead.
> 
> I am attaching a patch below for the same.
> I have left out the tce bits, as they are fine.
> 
> Note: I haven't extensively tested the patch

A better option is to make sure that a context switch does the right
thing, flushing the pending batch. I think that's already the case,
which means that your original patch may work, but that needs to
be double-checked and commented properly.

Cheers,
Ben.


