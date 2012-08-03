From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.7-rt15
Date: Thu, 02 Aug 2012 23:47:17 -0400
Message-ID: <1343965637.27983.107.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	john stultz <johnstul@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3192 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab2HCDrT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Aug 2012 23:47:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.4.7-rt15 stable release.

Like the 3.2-rt kernel this one also had issues with the backport of the
leap second. Please test to make 

This release is an update to the new stable 3.4.7 version. Some fixes
to the stable code (mentioned above) had to be done.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: e6d156ace34fccca669e2e1c786af2f373cad1a1


Or to build 3.4.7-rt15 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.7.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.7-rt15.patch.xz



Enjoy,

-- Steve



