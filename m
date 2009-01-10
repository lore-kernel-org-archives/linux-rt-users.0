From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt26 and 2.6.26.8-rt13
Date: Fri, 09 Jan 2009 22:22:39 -0500
Message-ID: <1231557759.922.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <srostedt@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:45937 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZAJDWm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jan 2009 22:22:42 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt26 and 2.6.26.8-rt13 trees,
which can be downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.26.6-rt12

  - Removed sched-prioritize-non-migrating-rt-tasks.patch that
    caused a bug in the scheduler.
   (Thanks to Arnaldo Carvalho de Melo for reporting the bug,
    and Gregory Haskins for finding the patch that caused it
    after I explained to him the problem)

Changes in both 2.6.24.7-rt26 and 2.6.26.8-rt13  (all by Thomas Gleixner)

  - trace-histogram: handle clock going backwards

  - interrupt enabled in irq fix

to build a 2.6.24.7-rt26 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt26.bz2


to build a 2.6.26.8-rt13 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.26.8.bz2
  http://rt.et.redhat.com/download/patch-2.6.26.8-rt13.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.

The git tree can now be compiled, we are now working on getting it to
boot ;-)  It is based off of the v2.6.28 tag.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt.git

-- Steve



