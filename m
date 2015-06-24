From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.12.44-rt61
Date: Wed, 24 Jun 2015 15:35:56 -0400
Message-ID: <20150624153556.6f9d1234@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:53576 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752443AbbFXTf7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Jun 2015 15:35:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.12.44-rt61 stable release.


This release is just an update to the new stable 3.12.44 version
and no RT specific changes have been made.

Although I did backport some patches from mainline to make NO_HZ_FULL
compile. But more needs to be done to have it work for PREEMPT_RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.12-rt
  Head SHA1: b2c41831b695d2dc5c77203afdcfe75f27bce1c3


Or to build 3.12.44-rt61 directly, the following patches should be
applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.12.44.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.44-rt61.patch.xz




Enjoy,

-- Steve

