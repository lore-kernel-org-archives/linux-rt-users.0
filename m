From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23.9-rt13
Date: Thu, 13 Dec 2007 00:33:56 -0500
Message-ID: <1197524036.15001.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:52319 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbXLMFeV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 00:34:21 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.23.9-rt13 tree, which can be
downloaded from the location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23.9-rt12

  - Backported the new RT Balancing code from sched-devel
       New changes by Steven Rostedt, Gregory Haskins,
        Ingo Molnar, and Dmitry Adamushko

  - 2 dimension CPU Prio RT balancing search (Gregory Haskins)

  - ARM compile fix (Kevin Hilman)

  - Disable HPET legacy replacement for kdump (OGAWA Hirofumi)

  - disable HPET on shutdown (OGAWA Hirofumi)

  - fix for futex_wait signal stack corruption (Steven Rostedt)

  - Handle IRQ_PENDING for simple irq thread (Steven Rostedt)

  - latency tracer updates (Daniel Walker)

  - Remove warning in local_bh_enable (Kevin Hilman)

  - use real time pcp locking for page draining during cpu (Andi Kleen)

  - Revert lazy disable irq from simple irq handler (Steven Rostedt)

  - AT91 switch to edge from simple irq (Remy Bohmer)


to build a 2.6.23.9-rt13 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.9.tar.bz2 
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.9-rt13.bz2

And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt2


The broken out patches are also available.

-- Steve
