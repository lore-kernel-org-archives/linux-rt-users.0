From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt14
Date: Mon, 23 Jun 2008 17:21:57 -0400
Message-ID: <1214256117.8701.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:62756 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbYFWVWA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jun 2008 17:22:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt14 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24.7-rt13

  - rwlock pi_lock fixes on waking up multiple readers (Steven Rostedt)

  - revert adaptive locks from RCU (Thomas Gleixner)
     [ for some reason, using RCU causes some latency spikes, this
       may be a sign of something going wrong in RCU itself ]

  - rwlock mutex owner fix for waking up reader with readers held (Steven Rostedt)

  - rwlock remove waiter from pi_list on above fix (Steven Rostedt and
                                                    Thomas Gleixner)

  - rwlock replace macro with inline (Thomas Gleixner)

  - rwlock pending namespace updates (Thomas Gleixner)

  - rwlock debug check (Thomas Gleixner)

  - futex fix fault (Thomas Gleixner)

  - x86_64 fix copy user (Linus Torvalds)

to build a 2.6.24.7-rt14 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt14.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve



