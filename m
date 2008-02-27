From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.3-rt3
Date: Wed, 27 Feb 2008 00:08:12 -0500
Message-ID: <1204088892.14759.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36010 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYB0FIb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2008 00:08:31 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.3-rt3 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24.2-rt2

  - ported to 2.6.24.3

  - updates to ftrace (Ingo Molnar and Steven Rostedt)

  - root domain kfree fix (Gregory Haskins)

  - event trace compile fix (Clark Williams)


to build a 2.6.24.3-rt3 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.3.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.3-rt3.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve

	
