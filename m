From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.126-rt141
Date: Wed, 04 Apr 2018 08:22:57 +0200
Message-ID: <20180404062410.28619500B6A@mail.monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.126-rt141 stable release.

This release is just an update to the new stable 4.4.126 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: bdfaf62feda1231b04e01223c29771f5961012a9

Or to build 4.4.126-rt141 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.126.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.126-rt141.patch.xz


You can also build from 4.4.120-rt135 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.120-rt135-rt141.patch.xz

Enjoy!
   Daniel
