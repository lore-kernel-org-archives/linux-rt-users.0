From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.5-rt1
Date: Fri, 16 Jun 2017 12:56:10 +0200
Message-ID: <20170616105610.rbc6itylcrsla56l@linutronix.de>
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

I'm pleased to announce the v4.11.5-rt1 patch set. 
The release has been delayed due to the hotplug rework that was started
before the final v4.11 release. However the new code has not been
stabilized yet and it was decided to bring back the old patches before
delaying the v4.11-RT release any longer. We will try to complete the
hotplug rework (for RT) in the v4.11 cycle.

Changes since v4.9.39-rt21:

  - rebase to v4.11.5

Known issues
	- CPU hotplug got a little better but can deadlock.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.5-rt1

The RT patch against v4.11.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.5-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.5-rt1.tar.xz

Sebastian
