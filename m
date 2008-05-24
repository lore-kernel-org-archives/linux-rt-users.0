From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt10
Date: Sat, 24 May 2008 01:51:05 -0400
Message-ID: <1211608265.14697.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:51202 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYEXFvJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 May 2008 01:51:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt10 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24.7-rt9

  - ported latest ftracers (Steven Rostedt)

  - vdso vsyscall generic (Luis Goncalves)

  - git-ignore update (Hiroshi Shimamoto)

  - lockstat updates (Peter Zijlstra)

  - Adjust pi_lock in wakeup waiters (Peter Morreale)

  - optimize rt_spin wakeup (Peter Morreale)

  - all archs use task->oncpu (Gregory Haskins)
     [modified use in header by Steven Rostedt]

  - remove redundant try_to_take_lock (Peter Morreale)

  - fastpath try_to_take_lock on steal (Steven Rostedt)

  - ticket FIFO spinlocks (Nick Piggin)

to build a 2.6.24.7-rt10 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt10.bz2


*** Note ***

  2.6.25.x-rt4 with updates will be coming out shortly

*** Note ***



And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve



