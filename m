From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.164-rt176
Date: Fri, 23 Nov 2018 07:33:13 +0100
Message-ID: <20181123063315.2DD3A5007D2@mail.monom.org>
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

I'm pleased to announce the 4.4.164-rt176 stable release.

This release is just an update to the new stable 4.4.164 version
and no RT specific changes have been made.

The previously reported cache line starvation bug has been resolved
via the stable tree (see https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.4.y&id=97b8ca659ab410c6955da052592959244d041fa8)

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 726ccc5cab11ae1ac086642f022d0abf8cb85530

Or to build 4.4.164-rt176 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.164.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.164-rt176.patch.xz


You can also build from 4.4.162-rt175 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.162-rt175-rt176.patch.xz

Enjoy!
   Daniel
