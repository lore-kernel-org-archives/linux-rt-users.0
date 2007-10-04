From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23-rc9-rt2
Date: Thu, 04 Oct 2007 18:20:13 -0400
Message-ID: <1191536413.5210.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64417 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975AbXJDWU3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Oct 2007 18:20:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.23-rc9-rt2 tree, which can be
downloaded from the new location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23-rc9-rt1

  - x86_64 disable IST for debug (Andi Kleen)

  - Better handling of dynticks going bad in RCU (Steven Rostedt)

  - Preempt RCU boosting (Steven Rostedt based on Paul E. McKenney's 
    stuff)

Again, this still holds experimental code. But I've been running it on a
few boxes already (and even the box I'm writing this on). 

to build a 2.6.23-rc9-rt2 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.tar.bz2
  http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.23-rc9.bz2
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23-rc9-rt2.bz2

The broken out patches are also available.

-- Steve
