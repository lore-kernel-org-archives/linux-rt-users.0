From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.14.44-rt44
Date: Wed, 24 Jun 2015 15:34:57 -0400
Message-ID: <20150624153457.03cf3155@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.14.44-rt44 stable release.


This release is just an update to the new stable 3.14.44 version
and no RT specific changes have been made.

Although I did backport some patches from mainline to make NO_HZ_FULL
compile. But more needs to be done to have it work for PREEMPT_RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.14-rt
  Head SHA1: 344939a6f24f215e94ad334426e317e3b8fbe122


Or to build 3.14.44-rt44 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.44.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.44-rt44.patch.xz




Enjoy,

-- Steve
