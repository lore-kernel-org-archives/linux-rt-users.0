From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.148-rt165
Date: Thu, 16 Aug 2018 22:27:07 +0200
Message-ID: <20180816202709.69869500B0B@mail.monom.org>
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

I'm pleased to announce the 4.4.148-rt165 stable release.

This release is just an update to the new stable 4.4.148 version
and no RT specific changes have been made.

Known issues:

- 'stress-ng --ptrace 4' is able to trigger a latency spike of
   several ms. Usually around 2 - 3ms on two different x86_64 boxes I can
   test on. 4.9-rt seems to have the same problem. 4.14-rt and 4.16-rt
   work just fine. Still debugging the issue.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 581e591d5bda2fb9fd1d2802d98587f2555d20e4

Or to build 4.4.148-rt165 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.148.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.148-rt165.patch.xz


You can also build from 4.4.145-rt162 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.145-rt162-rt165.patch.xz

Enjoy!
   Daniel
