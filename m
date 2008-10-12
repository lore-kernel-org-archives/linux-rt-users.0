From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.26.6-rt10
Date: Sun, 12 Oct 2008 15:30:14 -0400
Message-ID: <1223839814.19319.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:50558 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYJLTaR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 Oct 2008 15:30:17 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.26.6-rt10 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.26.5-rt9

  - ported to 2.6.26.6

  - rwlock to handle unnested order unlocks (Steven Rostedt)

  - rwlock update torture test to test unnested unlocks (Steven Rostedt)

  - remove rt push comment (Gregory Haskins)

  - rt sched fix to handle dequeue (Gregory Haskins)

  - PPC: remove duplicate stack trace code (Robert Schwebel)

  - ARM: ftrace event IRQ call fix (Alexander Pazdnikov)

  - fair sched not to resched RT tasks (Peter Zijlstra)

  - ftrace quick stop (Steven Rostedt)

  - event trace of resched (Steven Rostedt)


to build a 2.6.26.6-rt10 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.26.6.bz2
  http://rt.et.redhat.com/download/patch-2.6.26.6-rt10.bz2



And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.


-- Steve


