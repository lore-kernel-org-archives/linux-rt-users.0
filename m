From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.157-rt174
Date: Sat, 22 Sep 2018 13:12:42 +0200
Message-ID: <20180922111245.60727500955@mail.monom.org>
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

I'm pleased to announce the 4.4.157-rt174 stable release.

This release is just an update to the new stable 4.4.157 version
and no RT specific changes have been made.

Known issue:

- Cache line starvation. 'stress-ng --ptrace 4' is able to trigger a
  latency spike of several ms. For more details check

  https://lwn.net/ml/linux-kernel/20180921120226.6xjgr4oiho22ex75%40linutronix.de/

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: b6e49a74949295ec22cd6571413eec32bc9c49a0

Or to build 4.4.157-rt174 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.157.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.157-rt174.patch.xz


You can also build from 4.4.148-rt165 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.148-rt165-rt174.patch.xz

Enjoy!
   Daniel
