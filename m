From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.110-rt125
Date: Sat, 6 Jan 2018 10:13:57 -0500
Message-ID: <20180106101357.79f43c6d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.110-rt125 stable release.


This release is just an update to the new stable 4.4.110 version
and no RT specific changes have been made.

Yes, it includes the latest KPTI patch series that was backported to 4.4.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: d79e4dc11891d315311133bc56b7275cf155a304


Or to build 4.4.110-rt125 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.110.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.110-rt125.patch.xz




Enjoy,

-- Steve
