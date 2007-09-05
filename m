From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 0/8] RCU: Preemptible RCU
Date: Wed, 5 Sep 2007 14:31:20 -0700
Message-ID: <20070905213120.GA29204@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu,
	akpm@linux-foundation.org, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de, a.p.zijlstra@chello.nl, bunk@kernel.org,
	ego@in.ibm.com, oleg@tv-sign.ru, srostedt@redhat.com
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41412 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbXIEVbX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 17:31:23 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Work in progress, still not for inclusion.

This is a respin of the following prior postings:

http://lkml.org/lkml/2007/8/7/276 (the four initial preemptible RCU patches)
http://lkml.org/lkml/2007/8/17/262 (hotplug CPU for preemptible RCU)
http://lkml.org/lkml/2007/8/22/348 (RCU priority boosting)
http://lkml.org/lkml/2007/8/22/373 (rcutorture for RCU priority boosting)

This release adds an additional patch that makes the RCU priority booster
more friendly to power-savings measures by causing the booster task to
sleep if there is no cause to believe that priority boosting will be
required in the near future.  An additional fixup and documentation patch
is forthcoming.  And of course, the whole thing will be rebased to a more
recent version of Linux.

These patches take prior feedback into account, including the bit about
running checkpatch.pl.  ;-)

						Thanx, Paul
