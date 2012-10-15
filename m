From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Crap, ksoftirqd/0 looping forever in softirq
Date: Mon, 15 Oct 2012 06:36:48 -0700
Message-ID: <20121015133648.GA2527@linux.vnet.ibm.com>
References: <20121011001637.GA18628@windriver.com>
 <20121011142130.GA22583@windriver.com>
 <20121011153413.GB22583@windriver.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:54251 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2JONjQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2012 09:39:16 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 15 Oct 2012 07:39:14 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E66091FF004F
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 07:39:02 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q9FDcW9u243506
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 07:38:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q9FDarZC013087
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 07:36:57 -0600
Content-Disposition: inline
In-Reply-To: <20121011153413.GB22583@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Oct 11, 2012 at 11:34:14AM -0400, Paul Gortmaker wrote:
> [Re: Crap, ksoftirqd/0 looping forever in softirq] On 11/10/2012 (Thu 10:21) Paul Gortmaker wrote:
> 
> > [Crap, ksoftirqd/0 looping forever in softirq] On 10/10/2012 (Wed 20:16) Paul Gortmaker wrote:
> > 
> > > Seeing the above message, I added a trivial change to print out the
> > > Mask and Pending, and I consistently saw it was (both p/m) in every
> > > case `was __IRQF_TIMER (0x200).
> > 
> > Of cource it helps if I look up the value in the right list.
> > I guess the ffs had me thinking "bits", instead of looking up
> > the value in the softirq enum list.
> > 
> > When I add a change to record the last vecs used and dump them
> > out when the Crap message is triggered (using softirq_to_name
> > instead of looking things up in random tables!)  I get this:
> > 
> > [   20.887137] Crap, ksoftirqd/0 looping forever in softirq
> > [   20.887150] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
> > [   20.920168] Crap, ksoftirqd/0 looping forever in softirq
> > [   20.920179] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
> > [   20.954200] Crap, ksoftirqd/0 looping forever in softirq
> > [   20.954213] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
> 
> Here is a trace, which I think shows us that we call the
> RCU softirq, which eventually calls invoke_rcu_core, which
> is just "raise_softirq(RCU_SOFTIRQ);" so the loop which is
> testing on current->softirqs_raised will never see it zero.
> 
> We clear it on entry with:
> 	 current->softirqs_raised &= ~mask;
> but after we call:
> 	 do_single_softirq(i, need_rcu_bh_qs);
> it will be re-armed by invoke_rcu_core.
> 
>   0xffffffff81044d9d in __raise_softirq_irqoff (nr=9) at kernel/softirq.c:608
>   0xffffffff81044e29 in raise_softirq_irqoff (nr=<optimized out>) at kernel/softirq.c:618
>   0xffffffff810452e1 in raise_softirq (nr=<optimized out>) at kernel/softirq.c:744
>   0xffffffff810bd4e1 in invoke_rcu_core () at kernel/rcutree.c:1878
>   rcu_do_batch (rdp=0xffff880017c0bf80, rsp=<optimized out>) at kernel/rcutree.c:1635
>   invoke_rcu_callbacks (rdp=0xffff880017c0bf80, rsp=0xffffffff81c2b140) at kernel/rcutree.c:1870
>   __rcu_process_callbacks (rsp=0xffffffff81c2b140) at kernel/rcutree.c:1842
>   rcu_process_callbacks (unused=<optimized out>) at kernel/rcutree.c:1854
>   0xffffffff8104466b in handle_softirq (need_rcu_bh_qs=1, cpu=0, vec_nr=9) at kernel/softirq.c:149
>   do_single_softirq (need_rcu_bh_qs=1, which=9) at kernel/softirq.c:457
>   do_current_softirqs (need_rcu_bh_qs=1) at kernel/softirq.c:500
> 
> Does that sound right?

(Following up on IRC discussion)

Yep, if a given CPU has a large number of callbacks, it will execute
them in batches of 10 (controlled by rcutree.blimit module parameter).
It will re-raise RCU_SOFTIRQ at the end of each batch.  The point is
to allow other softirq handlers to run.

							Thanx, Paul

