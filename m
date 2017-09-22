From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt14
Date: Fri, 22 Sep 2017 11:48:33 +0200
Message-ID: <20170922094832.mer4rlkwdw3dq7ic@linutronix.de>
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

I'm pleased to announce the v4.11.12-rt14 patch set. 

Changes since v4.11.12-rt13:

  - Update the "Inter-event (e.g. latency) support" patch to v2 as
    posted by Tom Zanussi on 2017-09-05. Patch 40 from this series has
    been replaced with Steven Rostedt's version of it (as posted as
    reply to the original patch) since the original broke some things.

  - The bluetooth code could deadlock itself on RT. Reported by Mart van
    de Wege.

  - The AMD-iommu driver produced "sleeping while atomic" warnings.
    Reported by Vinod Adhikary.

  - The local_lock locking around icmp_sk_lock needs to be a try-lock
    because it may be recursive. With this fixed, the deadlocks as
    reported by Jacek Konieczny are gone.

  - Since the futex work, the RT-only fixup needed adaption and was
    overseen which led to strange errors. Reported by Gusenleitner
    Klaus.

Known issues
	none

The delta patch against v4.11.12-rt13 will be send as response to this
message can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt14

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt14.tar.xz

Sebastian
