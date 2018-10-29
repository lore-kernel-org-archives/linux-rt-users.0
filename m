From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.162-rt175
Date: Mon, 29 Oct 2018 21:04:59 +0100
Message-ID: <20181029200501.BECE75007F3@mail.monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.162-rt175 stable release.

This release is just an update to the new stable 4.4.120 version
and no RT specific changes have been made.

This version still qspinlock enabled, because I wanted to update first
to the last stable release and then resend the patch which drops back
to ticket spinlocks.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 795fdff63ee1ad9582e242ab80e9257b64770cef

Or to build 4.4.162-rt175 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.162.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.162-rt175.patch.xz


You can also build from 4.4.157-rt174 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.157-rt174-rt175.patch.xz

Enjoy!
   Daniel
