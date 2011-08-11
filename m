From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.0.1-rt8 - Regression to 3.0-rt7
Date: Thu, 11 Aug 2011 14:41:38 +0200
Message-ID: <1313066498.8491.1.camel@twins>
References: <1312580681.28695.44.camel@twins>
	 <201108091713.19292.tim.sander@hbm.com> <1313055790.23660.70.camel@twins>
	 <201108111330.28168.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56214 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab1HKMl7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Aug 2011 08:41:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-08-11 at 14:02 +0200, Peter Zijlstra wrote:
> On Thu, 2011-08-11 at 13:30 +0200, Tim Sander wrote:
> > The error does not occur  when configured with 
> > CONFIG_PREEMPT_RT_FULL=y
> > but with 
> > CONFIG_PREEMPT_RTB=y.
> > The same error also happens with
> > CONFIG_PREEMPT_LL=y. (A log is appended after the other log just
> > search for CONFIG_PREEMPT_LL 
> > for starting point). 
> 
> Does the below (on top of -rt8) cure things for you? Shouldn't make a
> difference for PREEMPT_LL though, so maybe there's something else busted
> as well. But from what I can tell PREEMPT_BASE should be fine with such
> things disabling preemption..

Gah, nevermind, I'm sleeping or so..

---
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -2040,7 +2040,7 @@ size_t iov_iter_copy_from_user_atomic(st
 	char *kaddr;
 	size_t copied;
 
-	BUG_ON(!current->pagefault_disabled);
+	BUG_ON(!(in_atomic() || current->pagefault_disabled));
 	kaddr = kmap_atomic(page, KM_USER0);
 	if (likely(i->nr_segs == 1)) {
 		int left;

