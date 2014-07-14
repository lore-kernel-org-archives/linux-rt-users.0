From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 0/2] NOCB kthread economization patches
Date: Mon, 14 Jul 2014 03:06:04 -0700
Message-ID: <20140714100604.GA9905@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de,
	peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
	edumazet@google.com, dvhart@linux.intel.com, fweisbec@gmail.com,
	oleg@redhat.com, sbw@mit.edu, linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:41576 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbaGNKGM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jul 2014 06:06:12 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 14 Jul 2014 04:06:11 -0600
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello!

This series provides a couple of patches that reduce the number of rcuo
kthreads in cases where nr_cpu_ids is larger than the actual number of
online CPUs.

1.	Preparation patch that rationalizes RCU's creation of early-boot
	kthreads.

2.	Instead of creation rcuo kthreads for each possible CPU, create
	them only for those CPUs that have come online at least once
	since boot.

							Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.c        |    8 ++-
 b/kernel/rcu/tree.h        |    5 +-
 b/kernel/rcu/tree_plugin.h |  105 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 95 insertions(+), 23 deletions(-)

