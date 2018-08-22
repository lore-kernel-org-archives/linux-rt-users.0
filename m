From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.14.63-rt40
Date: Wed, 22 Aug 2018 14:14:58 -0400
Message-ID: <20180822141458.0b6b6af7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.14.63-rt40 stable release.


This release is just an update to the new stable 4.14.63 version
and no RT specific changes have been made.

NOTE: There is a known issue with this release. The fix is here:

  http://lkml.kernel.org/r/1534660115.6187.4.camel@gmx.de

I did not apply it to this release because it needs to be added to
v4.16-rt first before it gets backported. Feel free to apply it
yourself if you have any concerns.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: da6bee3cef4af60566dc56f3d48fce0b18165107


Or to build 4.14.63-rt40 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt40.patch.xz




Enjoy,

-- Steve
