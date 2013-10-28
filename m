From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.10.17-rt12
Date: Mon, 28 Oct 2013 23:38:09 +0100
Message-ID: <20131028223808.GA8631@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v3.10.17-rt12 patch set.

This is only a stable update (which fixed the livelock in sem_lock()).

Known issues:

      - SLAB support not working

      - The cpsw network driver shows some issues.

      - bcache is disabled.

      - an ancient race (since we got sleeping spinlocks) where the
        TASK_TRACED state is temporary replaced while waiting on a rw
        lock and the task can't be traced.

The RT patch against 3.10.17 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.17-rt12.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patches-3.10.17-rt12.tar.xz

Sebastian
