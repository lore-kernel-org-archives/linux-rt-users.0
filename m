From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.0.12-rt29
Date: Wed, 30 Nov 2011 20:25:48 -0500
Message-ID: <1322702748.24563.33.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:38850 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1LABZw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 20:25:52 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.0.12-rt29 stable release.


This release is just an update to the new stable 3.0.12 version
and no RT specific changes have been made.

Note, I did make and upload 3.0.11-rt28 that only merged in 3.0.11, but
then saw that 3.0.12 was released, so I went back and merged in 3.0.12
and started the testing scripts again.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: 69a3235fcfb900e8c40a2044757903de7c15b1ef


Or to build 3.0.12-rt29 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.12.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.12-rt29.patch.xz


The broken out patches are available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patches-3.0.12-rt29.tar.xz

Enjoy,

-- Steve



