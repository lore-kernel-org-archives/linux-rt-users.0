From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.16.18-rt11
Date: Fri, 27 Jul 2018 23:57:10 +0200
Message-ID: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.18-rt11 patch set. 

Changes since v4.16.18-rt10:

  - Finally fix the SIMD locking on arm64.

  - Revert the srcu based notifier in crypto code. This is no longer
    required since the rwsem on RT allows multiple reader.

  - Add a per-CPU lock in crypto's cryptd per-CPU queue. Reported by
    Mike Galbraith.

  - Add a per-CPU lock in crypto's scompress code. Patch by Mike
    Galbraith.

  - Disable runtime EFI services on ARM64. It can be enabled again via
    command line. The getTime function needs around 10ms to complete on
    one of my machines. The setVariable might take even longer. It is
    disabled by default, it can be enabled via `efi=runtime' on the
    command line.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.18-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.18-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.18-rt11

The RT patch against v4.16.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.18-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.18-rt11.tar.xz

Sebastian
