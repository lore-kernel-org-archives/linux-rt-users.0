From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 0/4 RFC] preemptible RCU
Date: Tue, 7 Aug 2007 11:39:46 -0700
Message-ID: <20070807183946.GA32110@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu,
	akpm@linux-foundation.org, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47705 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbXHGSjs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 14:39:48 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello!

This patchset is an update of that posted by Dipankar last January
(http://lkml.org/lkml/2007/1/15/133).  This is work in progress, not yet
ready for inclusion.  It passes rcutorture on i386, x86_64, and ppc64
boxes as well as kernbench, so should be safe for experimentation.  As
with Dipankar's previous post, this variant of preemptible rcu_read_lock()
and rcu_read_unlock may be invoked from NMI/SMI handlers, and do not
contain any heavyweight atomic operations or memory barriers (although
they do still momentarily disable IRQs).  This patchset features
a fully parallel grace-period computation, which will become increasingly
important with upcoming multicore/multi-threaded CPUs.  In addition,
this patchset provides a preemptible-RCU variant of synchronize_sched()
that avoids the previous deadlock with CPU hotplug -- this variant may
eventually prove unnecessary, but is offered in the spirit of separating
concerns.

Next steps:  (1) Integrate with CPU hotplug.  (2) Re-merge RCU priority
boosting.  (3) Fix some naming issues.  Longer term work includes
optimized dyntick operation and eliminating the interrupt disabling
in rcu_read_lock() and rcu_read_unlock().

						Thanx, Paul
