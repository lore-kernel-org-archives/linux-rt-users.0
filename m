From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4 RFC] RCU: preemptible RCU
Date: Wed, 8 Aug 2007 06:09:20 -0700
Message-ID: <20070808130920.GC5024@linux.vnet.ibm.com>
References: <20070807183946.GA32110@linux.vnet.ibm.com> <20070807184812.GC10068@linux.vnet.ibm.com> <46B98888.6030600@free.fr>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54034 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754940AbXHHNJX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2007 09:09:23 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78C4d6I013404
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Aug 2007 08:04:39 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l78D9MGZ448142
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Aug 2007 09:09:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l78D9MHf010644
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Aug 2007 09:09:22 -0400
Content-Disposition: inline
In-Reply-To: <46B98888.6030600@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Aug 08, 2007 at 11:10:32AM +0200, John Sigler wrote:
> [ Recipients list trimmed ]
> 
> Paul E. McKenney wrote:
> 
> >This patch was developed as a part of the -rt kernel development and
> >meant to provide better latencies when read-side critical sections of
> >RCU don't disable preemption.  As a consequence of keeping track of RCU
> >readers, the readers have a slight overhead (optimizations in the paper).
> >This implementation co-exists with the "classic" RCU implementations
> >and can be switched to at compiler.
> 
> I cannot parse the last sentence :-)

Oops...  :-/

> Did you mean that this new implementation can be chosen (over the 
> classic implementation) at compile-time?

Yes, via config variables.  CONFIG_CLASSIC_RCU selects the "classic"
RCU implementation, and CONFIG_PREEMPT_RCU selects the preemptible RCU.
CONFIG_PREEMPT_CPU depends on CONFIG_PREEMPT, so that you only are
permitted to specify CONFIG_PREEMPT_RT in preemptible kernels.

						Thanx, Paul
