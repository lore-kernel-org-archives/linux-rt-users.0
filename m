From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23-rt1
Date: Thu, 11 Oct 2007 22:04:00 -0400
Message-ID: <1192154640.15992.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:54197 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbXJLCE1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2007 22:04:27 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.23-rt1 tree, which can be
downloaded from the location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23-rc9-rt2

  - updated to 2.6.23

  - spin_trylock_irqsave macro fix (S=E9bastien Dugu=E9)

  - move rcu_preempt_boost init earlier (Steven Rostedt)

  - rt task send IPI condition update (Mike Kravetz)


to build a 2.6.23-rt1 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23-rt1.b=
z2

The broken out patches are also available.

-- Steve
