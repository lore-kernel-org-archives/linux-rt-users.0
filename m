From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.24.7-rt8
Date: Tue, 20 May 2008 00:46:03 -0400
Message-ID: <1211258763.14697.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:53835 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbYETEqE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 00:46:04 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.24.7-rt8 tree, which can be
downloaded from the location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.24.7-rt7

 - Read Write locks with multiple readers (Steven Rostedt)

 The previous versions of the RT tree would serialize the RW locks
 for all readers to allow for priority inheritance to take place.
 This change allows for multiple readers but still maintain priority
 inheritance. The number of readers that can hold a lock at any time
 may be limited by

   sysctl kernel.rwlocks_reader_limit

 Setting this to <= 0 will give allow for any number of readers. The
 default is set to NR_CPUS.


 ** Note: I made this change separate to allow for easy testing in case 
          bugs have been introduced by this change.

to build a 2.6.24.7-rt8 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
  http://rt.et.redhat.com/download/patch-2.6.24.7-rt8.bz2



And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.



-- Steve



