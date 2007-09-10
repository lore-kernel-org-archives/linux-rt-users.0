From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 0/9] RCU: Preemptible RCU
Date: Mon, 10 Sep 2007 11:30:04 -0700
Message-ID: <20070910183004.GA3299@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu,
	akpm@linux-foundation.org, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de, a.p.zijlstra@chello.nl, bunk@kernel.org,
	ego@in.ibm.com, oleg@tv-sign.ru, srostedt@redhat.com
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756905AbXIJSa1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Work in progress, still not for inclusion.  But code now complete!

This is a respin of the following prior posting:

http://lkml.org/lkml/2007/9/5/268

This release adds an additional patch that adds fixes to comments and RCU
documentation, along with one macro being renamed.  The rcutorture patch
has a modification to make it a bit more vicious to priority boosting
(though the current design relies on -rt latencies for much of the
priority-boost torturing effectiveness in this case -- run the test
in presence of CPU hotplug operations to get the same effect in -mm).
Next step is rebasing this to a more recent version of Linux.

						Thanx, Paul
