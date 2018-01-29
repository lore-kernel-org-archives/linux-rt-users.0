From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.15-rt13
Date: Mon, 29 Jan 2018 23:37:23 +0100
Message-ID: <20180129223723.lr5avyspmglwcddr@linutronix.de>
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

I'm pleased to announce the v4.14.15-rt13 patch set. 

Changes since v4.14.15-rt12:

  - In the previous release the ping-sysrq patch was removed from the
    queue but has been left listed in the series by mistake. "git
    quiltimport" simply ignored that patch while "quilt push -a" did not
    continue. This release provides a corrected series file. Reported by
    Salvatore Bonaccorso.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.15-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.15-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.15-rt13

The RT patch against v4.14.15 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.15-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.15-rt13.tar.xz

Sebastian

diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927..9f7d0bdbffb1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
