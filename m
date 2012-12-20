From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.0.57-rt81
Date: Thu, 20 Dec 2012 15:46:07 -0500
Message-ID: <1356036367.5896.60.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:11644 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab2LTUqI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 15:46:08 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

Note, I have abandoned the original 3.0.55-rt80 release due to a
reported bug in the -rc candidate. I will be applying a new rc release
based off of this release.

I'm pleased to announce the 3.0.57-rt81 stable release.


This release is just an update to the new stable 3.0.57 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: ebf30be9f8c8a40bce17d0ffe0b02f51a444dc9f


Or to build 3.0.57-rt81 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.57.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.57-rt81.patch.xz



Enjoy,

-- Steve



