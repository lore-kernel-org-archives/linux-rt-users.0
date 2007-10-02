From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23-rc9-rt1
Date: Tue, 02 Oct 2007 12:11:13 -0400
Message-ID: <1191341473.5642.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Daniel Walker <dwalker@mvista.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754801AbXJBQMU@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.23-rc9-rt1 tree, which can be
downloaded from the new location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23-rc9-rt1

  - update to 2.6.23-rc9

  - Various cleanups (Daniel Walker)
     - convert PICK_OP to PICK_FUNCTION
     - use now() in latency_tracer
     - have preempt_max_latency in all modes
     - latency_hist resetting
     - Stop critical timing in idle.

  - Deadlock fix in locked list primitives (Peter Zijlstrta)

  - RT task wakeup fix (Ingo Molnar)

  - New Preempt RCU implementation (Paul E. McKenney and Steven Rostedt)

  That last change (new Preempt RCU) is highly experimental!!!
  We are currently testing it now, although it has been through some
  minor tests already, we haven't declared it stable yet.

  This new implementation might shave your cat, eat your dog and
  make your children miss the bus and be late for school.
  You have been warned! As is said many times on this list
  "If it breaks, you get to keep the pieces". So don't come crying
  to us if something terrible happens, but please let us know
  so that we can try to fix what broke.

  That said, please test it as much as possible. We are happy with
  the new implementation, but it's still young, and we want to
  shake out the problems so it can be pushed up into mainline.


to build a 2.6.23-rc9-rt1 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.tar.bz2
  http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.23-rc9.bz2
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23-rc9-rt1.bz2

The broken out patches are also available.

-- Steve
