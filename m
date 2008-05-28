From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt11
Date: Tue, 27 May 2008 22:45:45 -0400
Message-ID: <1211942745.24785.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:36423 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbYE1Cps (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 May 2008 22:45:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt11 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24.7-rt10

  - preempt __delay fix (Steven Rostedt)

  - load_balance breaks (Peter Zijlstra)

  - ftrace minor fixes (Steven Rostedt, Clark Williams,
                     and Abhishek Sagar)

  - disable ftrace daemon (Steven Rostedt)

  - sched_rt migration updates (Gregory Haskins)

  - nmi show regs fix (Hiroshi Shimamoto)

  - Trace histogram divide by zero fix (Carsten Emde)


to build a 2.6.24.7-rt11 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt11.bz2


*** Note ***

  2.6.25.x-rt4 with updates will be coming out most likely tomorrow.

*** Note ***



And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve



