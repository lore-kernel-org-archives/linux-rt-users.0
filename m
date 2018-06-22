From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.138-rt155
Date: Fri, 22 Jun 2018 10:13:04 +0200
Message-ID: <20180622081829.BE082500BA9@mail.monom.org>
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

I'm pleased to announce the 4.4.138-rt155 stable release.

This release is just an update to the new stable 4.4.137 version
and no RT specific changes have been made.

As turns out, it is not a ghost I am hunting:

https://ci-rt.linutronix.de/RT-Test/histogram.jsp?cyclictest=517&id=144

So get this spike pops up under load on the CI test farm and also on
my local test computer. Though the only problem is, that it doesn't
show up when tracing is enabled. So if someone gets hold of a trace
please share it!

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: f9dc938fce05dbf24c1a7132cc3248b2799c94b7

Or to build 4.4.138-rt155 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.138.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.138-rt155.patch.xz


You can also build from 4.4.137-rt154 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.137-rt154-rt155.patch.xz

Enjoy!
   Daniel
