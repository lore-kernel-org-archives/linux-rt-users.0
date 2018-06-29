From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.14.52-rt34
Date: Fri, 29 Jun 2018 19:03:20 -0400
Message-ID: <20180629190320.6316b93b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.14.52-rt34 stable release.

This includes the merging of the stable releases, but also required
pulling in ("Revert mm/vmstat.c: fix vmstat_update() preemption BUG")
because v4.14.45 pulled in commit c7f26ccfb2c3 ("mm/vmstat.c: fix
vmstat_update() preemption BUG") which broke RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 71fbfbcfbcea9e6e5aa9dac068602f633dca5ad8


Or to build 4.14.52-rt34 directly, the following patches should be
applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.52.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.52-rt34.patch.xz




Enjoy,

-- Steve
