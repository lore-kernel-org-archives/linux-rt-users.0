From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24-rc8-rt1
Date: Wed, 16 Jan 2008 23:27:30 -0500
Message-ID: <1200544050.318.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:46295 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbYAQE1q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 23:27:46 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24-rc8-rt1 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24-rc7-rt3

  - ported to 2.6.24-rc8

  - PPC bootup notrace added for function trace (Luotao Fu)

  - MIPS remove duplicate Kconfig (Frank Rowand)

to build a 2.6.24-rc8-rt1 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2
  http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.24-rc8.bz2
  http://rt.et.redhat.com/download/patch-2.6.24-rc8-rt1.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.

-- Steve
