From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.25.4-rt2
Date: Mon, 19 May 2008 18:43:52 -0400
Message-ID: <1211237032.14697.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:34729 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbYESWny (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 18:43:54 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.25.4-rt2 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.25.4-rt1

  - lateral lock stealing (Gregory Haskins)

  - rtmutex rearrange logic (Gregory Haskins)

  - rtmutex remove double xchg (Steven Rostedt)

  - adaptive spinlocks (Gregory Haskins, Sven Deitrich,
                        Peter Morreale, and Steven Rostedt)

  - tsc fixage (Thomas Gleixner)

to build a 2.6.25.4-rt2 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.25.4.bz2
  http://rt.et.redhat.com/download/patch-2.6.25.4-rt2.bz2



And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve

	

