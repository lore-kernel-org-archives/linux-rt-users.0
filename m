From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.1-rt9
Date: Thu, 07 Jun 2012 09:39:57 -0400
Message-ID: <1339076397.7559.4.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.4.1-rt9 stable release.


This release is just an update to the new stable 3.4.1 version
and no RT specific changes have been made.

(one exception: commit 24312d34 workqueue: skip nr_running sanity check in worker_enter_idle() if trustee is active
  has been reverted. Thanks to Ibrahim Umar for pointing out the
  build failure. The commit was to remove a triggering of a false
  WARN_ON, but it required variables that did not exist in the -rt
  workqueue version. Hopefully we do not see this false positive.)


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: 0ccbbea2d9b1253eaae376df58705bfd11d0028f


Or to build 3.4.1-rt9 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.1.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.1-rt9.patch.xz



Enjoy,

-- Steve
