From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] Stable RT tarballs... Back by popular demand!!!!
Date: Thu, 27 Sep 2012 18:19:49 -0400
Message-ID: <1348784389.22822.85.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:17470 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab2I0WTw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2012 18:19:52 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I stated that I would be willing to put back the stable tarballs to
kernel.org at Linux Plumbers. Well, I finally had time to finish my
tarball script, which basically just does what the README tells you to
do:

 $ git checkout v3.4.1-rt9-rebase
 $ mkdir patches
 $ git format-patch -o patches v3.4.1
 $ ls patches > series
 $ mv series patches


And packages it all up nicely into a tarball. I will be pushing up the
tarballs as I do the rebase branches, as they are based off of the
rebase branch.

The current tarballs are:

http://kernel.org/pub/linux/kernel/projects/rt/3.0/patches-3.0.43-rt65.tar.xz

http://kernel.org/pub/linux/kernel/projects/rt/3.2/patches-3.2.30-rt45.tar.xz

http://kernel.org/pub/linux/kernel/projects/rt/3.4/patches-3.4.11-rt19.tar.xz

Enjoy,

-- Steve


