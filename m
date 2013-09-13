From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.8.13.7-rt18
Date: Fri, 13 Sep 2013 12:21:37 -0400
Message-ID: <20130913122137.63d5c2bc@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kamal Mostafa <kamal@canonical.com>,
	Luis Henriques <luis.henriques@canonical.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.8.13.7-rt18 stable release.

Note, the 3.8-rt stable series will now be using the Ubuntu's
stable kernels as they are doing the work to backport stable changes
to 3.8.13. To keep things in one place, I have added a new directory:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/stable/

That will host the stable patches used to create the 3.8-rt tree.
The patches in that directory are created from the linux-3.8.y branch
in the Ubuntu git tree located here:

   git://kernel.ubuntu.com/ubuntu/linux.git

Special thanks goes to the Ubuntu kernel team for doing the work
that I am selfishly building -rt on top of.


This release is just an update to the new stable 3.8.13.7 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.8-rt
  Head SHA1: ea8e6ff212a50e9aa666de36df051b0d9bd8fe3e


Or to build 3.8.13.7-rt18 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.8.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.8.13.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/stable/patch-3.8.13.7.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patch-3.8.13.7-rt18.patch.xz




Enjoy,

-- Steve
