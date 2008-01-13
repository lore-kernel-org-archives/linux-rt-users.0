From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24-rc7-rt1
Date: Sun, 13 Jan 2008 14:00:01 -0500
Message-ID: <1200250801.9190.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:47477 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbYAMTAW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 14:00:22 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24-rc7-rt1 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24-rc5-rt1

   - ported to 2.6.24-rc7

   - Modifications to mcount (following upstream push)

   - Fixed Arm for new mcount calling (Clark Williams)

   - Fixed PPC for new mcount calling (Steven Rostedt)

   - dev_queue_xmit preemption fix (Mark Beauchemin)

   - root domain fix (Gregory Haskins)

   - serial login fix (Thomas Gleixner)

   - latency tracer bootmem panic fix (Steven Rostedt)

   - more hacks for kernbench and POWER (Paul McKenney)

   - fix to Paul's patch (Robert Schwebel)

   - PPC non-SMP compile fix (Egor Starkov)

   - RCU trace with markers (K. Prasad)

   - time keeping fixes (John Stultz)

   - Removed "raw" for rtc_lock for PPC chrp (Steven Rostedt)


to build a 2.6.24-rc7-rt1 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2
  http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.24-rc7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24-rc7-rt1.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.

-- Steve
