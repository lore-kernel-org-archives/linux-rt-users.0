From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.25.4-rt4
Date: Thu, 29 May 2008 11:59:14 -0400
Message-ID: <1212076754.24785.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:65035 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbYE2P7a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 May 2008 11:59:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.25.4-rt4 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.25.4-rt3

(Mostly stuff that has been pushed to 24-rt)

 - Upgraded new ftrace (Steven Rostedt)

  - RT downgrade_write (Steven Rostedt)

  - fix RT rwlocks typecasts (Steven Rostedt)

  - default sched_nr_migrate to 8 (Steven Rostedt)

  - ARM compile fix (Remy Bohmer)

  - vdso vsyscall generic (Luis Goncalves)

  - git-ignore update (Hiroshi Shimamoto)

  - lockstat updates (Peter Zijlstra)

  - Adjust pi_lock in wakeup waiters (Peter Morreale)

  - optimize rt_spin wakeup (Peter Morreale)

  - all archs use task->oncpu (Gregory Haskins)
     [modified use in header by Steven Rostedt]

  - remove redundant try_to_take_lock (Peter Morreale)

  - fastpath try_to_take_lock on steal (Steven Rostedt)

  - preempt __delay fix (Steven Rostedt)

  - ftrace minor fixes (Steven Rostedt, Clark Williams,
                     and Abhishek Sagar)

  - disable ftrace daemon (Steven Rostedt)

  - sched_rt migration updates (Gregory Haskins)

  - nmi show regs fix (Hiroshi Shimamoto)

  - Trace histogram divide by zero fix (Carsten Emde)

to build a 2.6.25.4-rt4 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.25.4.bz2
  http://rt.et.redhat.com/download/patch-2.6.25.4-rt4.bz2



And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.


-- Steve


