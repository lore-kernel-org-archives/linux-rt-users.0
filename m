From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.137-rt154
Date: Thu, 14 Jun 2018 21:02:51 +0200
Message-ID: <20180614191001.6882950047A@mail.monom.org>
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

I'm pleased to announce the 4.4.137-rt154 stable release.

This release is just an update to the new stable 4.4.137 version
and no RT specific changes have been made.

I am not sure if I am hunting a ghost. During testing on the CI
testfarm, a spike of around 400us popped up on a x86_64 box
(*). Fortunately, I have the same CPU for testing at home and I
tried very hard to reproduce it. Even Steven was helping out for
setting up the test correctly. But so far I haven't seen it again.

(*) https://ci-rt.linutronix.de/RT-Test/kb_details.jsp?id=139&b_id=5234&bt_id=382

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 74e9e457a9fce5f4d6723ad7f5331ab0951d485a

Or to build 4.4.137-rt154 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.137.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.137-rt154.patch.xz


You can also build from 4.4.131-rt148 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.131-rt148-rt154.patch.xz

Enjoy!
   Daniel
