From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt25 and 2.6.26.8-rt12
Date: Sat, 20 Dec 2008 00:55:20 -0500
Message-ID: <1229752520.974.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <srostedt@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:61710 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYLTFzY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Dec 2008 00:55:24 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt25 and 2.6.26.8-rt12 trees,
which can be downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.26.6-rt11

  - Ported to 2.6.26.8

  - rwlock fix owners race (Steven Rostedt)

  - fix rwlock boosting (Thomas Gleixner)

  - force rwlock into slow path (Thomas Gleixner)

  - fix missing get struct from previous patches (Thomas Gleixner)

Changes in both 2.6.24.7-rt25 and 2.6.26.8-rt12  (all by Thomas Gleixner)

  - ftrace: fix task state printout

  - sched: remove useless nointeractive state

  - rtmutex: remove unused variable

  - rtmutex: unify state manipulation

  - rtmutex: remove uber optimization

  - rtmutex: remove useless schedule enforcement

  - rtmutex: prevent missed wakeups


to build a 2.6.24.7-rt25 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt25.bz2


to build a 2.6.26.8-rt12 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.26.8.bz2
  http://rt.et.redhat.com/download/patch-2.6.26.8-rt12.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.


We are still actively working on the git tree and are hoping to
get a released out by early January.

-- Steve



