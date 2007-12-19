From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23.11-rt14
Date: Wed, 19 Dec 2007 00:15:24 -0500
Message-ID: <1198041324.13351.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34399 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXLSFPv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2007 00:15:51 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.23.11-rt14 tree, which can be
downloaded from the location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23.9-rt13

 - ported to 2.6.23.11

 - Add ifdef CONFIG_SMP around variable in sched_rt.c (Remy Bohmer)

 - Removed extra definition of rcu_dyntick_snapshot (Remy Bohmer)

 - Hacks to get kernbench to run on POWER (Paul McKenney)

 - Updated to hrtimers backport -hrt5 (Thomas Gleixner)

 - suspend resume fix on root domains (Gregory Haskins)


to build a 2.6.23.11-rt14 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.11.tar.bz2 
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.11-rt14.bz2

And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt2


The broken out patches are also available.

-- Steve
