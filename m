From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.8.13-rt9
Date: Tue, 21 May 2013 22:26:56 +0200
Message-ID: <20130521202656.GA3374@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.8.13-rt9 release.

This release is just an update to the new stable 3.8.13 version
and no RT specific changes have been made.

Known issues:

    - SLxB is broken on PowerPC, e500 based cpus. Can't repdroduce the
      problem on mpc5200 based board.

The RT patch against 3.8.13 can be found here:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patch-3.8.13-rt9.patch.xz

The split quilt queue is available at:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patches-3.8.13-rt9.tar.xz

Sebastian
