From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23.1-rt4
Date: Fri, 26 Oct 2007 23:16:31 -0400
Message-ID: <1193454991.5623.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:65094 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXJ0DQo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2007 23:16:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.23.1-rt4 tree, which can be
downloaded from the location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23-rt3

  - Updated to stable release 2.6.23.1

  - Added latest High Resolution timers work

  - RT Balance CPU weight optimization (Gregory Haskins)

  - Limit to NUMA Node RT Balance (Steven Rostedt)

  - Workqueue PI sched.h compile fix (Clark Williams)

  - plist debug init fix (Jan Kiszka)

  - Kconfig updates (Carsten Emde)

  - IRQ flags recalculation fix (Paul Gortmaker)

to build a 2.6.23-rt3 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.1.tar.bz2
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.1-rt4.bz2

The broken out patches are also available.

-- Steve
