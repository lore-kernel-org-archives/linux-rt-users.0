From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] rt/rcu/swait: Fix boot up when RCU NOCB_ALL is enabled
Date: Mon, 19 Aug 2013 11:35:30 -0400
Message-ID: <20130819153530.409041534@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9345 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3HSPgU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Aug 2013 11:36:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Thomas and Sebastian,

These three patches fixes the boot problem that Carsten was having
with 3.10-rt and RCU_NOCB_ALL

Steven Rostedt (3):
      rcu/swait: Fix RCU conversion of wake_up_all() to swait_wake()
      swait: Add memory barrier before checking list empty
      swait: Add smp_mb() after setting h->list

----
 kernel/rcutree_plugin.h |    2 +-
 kernel/wait-simple.c    |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
