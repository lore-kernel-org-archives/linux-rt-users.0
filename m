From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Crap, ksoftirqd/0 looping forever in softirq
Date: Thu, 11 Oct 2012 11:34:14 -0400
Message-ID: <20121011153413.GB22583@windriver.com>
References: <20121011001637.GA18628@windriver.com>
 <20121011142130.GA22583@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51952 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab2JKPe0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 11:34:26 -0400
Content-Disposition: inline
In-Reply-To: <20121011142130.GA22583@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: Crap, ksoftirqd/0 looping forever in softirq] On 11/10/2012 (Thu 10:21) Paul Gortmaker wrote:

> [Crap, ksoftirqd/0 looping forever in softirq] On 10/10/2012 (Wed 20:16) Paul Gortmaker wrote:
> 
> > Seeing the above message, I added a trivial change to print out the
> > Mask and Pending, and I consistently saw it was (both p/m) in every
> > case `was __IRQF_TIMER (0x200).
> 
> Of cource it helps if I look up the value in the right list.
> I guess the ffs had me thinking "bits", instead of looking up
> the value in the softirq enum list.
> 
> When I add a change to record the last vecs used and dump them
> out when the Crap message is triggered (using softirq_to_name
> instead of looking things up in random tables!)  I get this:
> 
> [   20.887137] Crap, ksoftirqd/0 looping forever in softirq
> [   20.887150] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
> [   20.920168] Crap, ksoftirqd/0 looping forever in softirq
> [   20.920179] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU
> [   20.954200] Crap, ksoftirqd/0 looping forever in softirq
> [   20.954213] Last: RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU RCU

Here is a trace, which I think shows us that we call the
RCU softirq, which eventually calls invoke_rcu_core, which
is just "raise_softirq(RCU_SOFTIRQ);" so the loop which is
testing on current->softirqs_raised will never see it zero.

We clear it on entry with:
	 current->softirqs_raised &= ~mask;
but after we call:
	 do_single_softirq(i, need_rcu_bh_qs);
it will be re-armed by invoke_rcu_core.

  0xffffffff81044d9d in __raise_softirq_irqoff (nr=9) at kernel/softirq.c:608
  0xffffffff81044e29 in raise_softirq_irqoff (nr=<optimized out>) at kernel/softirq.c:618
  0xffffffff810452e1 in raise_softirq (nr=<optimized out>) at kernel/softirq.c:744
  0xffffffff810bd4e1 in invoke_rcu_core () at kernel/rcutree.c:1878
  rcu_do_batch (rdp=0xffff880017c0bf80, rsp=<optimized out>) at kernel/rcutree.c:1635
  invoke_rcu_callbacks (rdp=0xffff880017c0bf80, rsp=0xffffffff81c2b140) at kernel/rcutree.c:1870
  __rcu_process_callbacks (rsp=0xffffffff81c2b140) at kernel/rcutree.c:1842
  rcu_process_callbacks (unused=<optimized out>) at kernel/rcutree.c:1854
  0xffffffff8104466b in handle_softirq (need_rcu_bh_qs=1, cpu=0, vec_nr=9) at kernel/softirq.c:149
  do_single_softirq (need_rcu_bh_qs=1, which=9) at kernel/softirq.c:457
  do_current_softirqs (need_rcu_bh_qs=1) at kernel/softirq.c:500

Does that sound right?

Paul.
