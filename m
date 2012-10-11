From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Crap, ksoftirqd/0 looping forever in softirq
Date: Wed, 10 Oct 2012 20:16:37 -0400
Message-ID: <20121011001637.GA18628@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50739 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933052Ab2JKAQu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2012 20:16:50 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Seeing the above message, I added a trivial change to print out the
Mask and Pending, and I consistently saw it was (both p/m) in every
case `was __IRQF_TIMER (0x200).

Looking at do_current_softirqs, it seems that it implicitly expects
two entrance paths:

   /*
    * Called with interrupts disabled. Process softirqs which were raised
    * in current context (or on behalf of ksoftirqd).
    */
   static void do_current_softirqs(int need_rcu_bh_qs)

In there, we loop on current->softirqs_raised, but there is no "filter"
for the case where we spawn from ksoftirqd with __IRQF_TIMER, or more
specifically IRQF_NO_THREAD.  Asking ksoftirqd to handle IRQF_NO_THREAD?

So based on my dain-bramaged and limited understanding, it seems that
we are waiting on completion from ksoftirqd on something that we've
asked to be not run from a thread.  I'd propose a patch but I'd probably
only manage to hurt myself, so I'll stop at reporting the above data,
and leave it to the folks more in the know to suggest a proper fix...

Paul.
