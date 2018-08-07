From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.18-rc8-rt1
Date: Tue, 7 Aug 2018 16:35:40 +0200
Message-ID: <20180807143540.g26ex7ibnp2iw5gh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.18-rc8-rt1 patch set. 
It has been in testing the last few weeks on x86-64 and arm64. Please
give it a try and please report and problems you might find while doing
so.
I will be absent until the end of August so I my answer might take same
time :)

Changes since v4.16.18-rt12:

  - rebase to v4.18-rc8

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.18-rc8-rt1

The RT patch against v4.18-rc8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patch-4.18-rc8-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patches-4.18-rc8-rt1.tar.xz

Sebastian
