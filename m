From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt12
Date: Mon, 02 Jun 2008 22:12:26 -0400
Message-ID: <1212459146.24785.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:50562 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbYFCCM2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Jun 2008 22:12:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt12 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24.7-rt11

  - Trace histogram late divide (Carsten Emde)

  - rwlock priority leak fix (Steven Rostedt)

  - rwlock pi_list fixes (Steven Rostedt)

  - rwlock torture test module (Steven Rostedt)

  - events tracer clocksource program event hook (Steven Rostedt)

to build a 2.6.24.7-rt12 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt12.bz2



*** Note ***

  2.6.25.4-rt5 with updates will be hopefully out tomorrow

*** Note ***


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve



