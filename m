From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24-rc7-rt2
Date: Mon, 14 Jan 2008 13:41:20 -0500
Message-ID: <1200336080.318.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:55487 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbYANSlf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 13:41:35 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24-rc7-rt2 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24-rc7-rt1

  - Several merge fixes reported by:
	Mariusz Kozloski

  - Removal of kvm-rt.patch (it's so old it is now bogus)

  - PPC compile fix (reported by: Robert Schwebel)

  - Remove of running softirq by hardirq (too dangerous)

  - Changed BUG_ON in filemap from atomic to pagefault disabled
       (Steven Rostedt)

Note: There are still some fixes that are not incorporated here yet.


to build a 2.6.24-rc7-rt2 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2
  http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.24-rc7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24-rc7-rt2.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.

-- Steve
