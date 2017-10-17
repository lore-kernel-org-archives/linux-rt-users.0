From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.13.7-rt1
Date: Tue, 17 Oct 2017 17:29:52 +0200
Message-ID: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
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

I'm pleased to announce the v4.13.7-rt1 patch set. 

Changes since v4.11.12-rt16:

  - Rebase to v4.13.7

  - We have now only the reader bias version of RWLOCK. In v4.11 it was
    possible to choose between both implementations but since the reader
    bias version makes no problems it is now the only implementation.

  - The lockdep self test is now disabled. While it produced some false
    positives on v4.11 it now completly locks up the system and needs
    investigation before re-enabling.

Known issues
	None

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.13.7-rt1

The RT patch against v4.13.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patch-4.13.7-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patches-4.13.7-rt1.tar.xz

Sebastian
