From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.14.23-rt20
Date: Fri, 31 Oct 2014 17:03:26 -0400
Message-ID: <20141031170326.1491a63f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.14.23-rt20 stable release.

This is the first 3.14-rt release in the stable-rt series. Normally I
wait till the next development release is out before I pull in a new
one. That is, I would pull in 3.14-rt when 3.16-rt or later was
released. But because development is now moving at a "hobbyist rate" 
 (read http://lwn.net/Articles/617140/ for details)
and 3.14-rt is no longer being developed against, I figured it was time
to put it under the "stable-rt" umbrella.

This release is just an update to the new stable 3.14.23 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.14-rt
  Head SHA1: 98a86c73c8828ba724eafaef832d71e3c909fb73


Or to build 3.14.23-rt20 directly, the following patches should be
applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.23.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.23-rt20.patch.xz




Enjoy,

-- Steve
