From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.14-rt1
Date: Fri, 11 Apr 2014 20:57:40 +0200
Message-ID: <20140411185739.GA6644@linutronix.de>
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

I'm pleased to announce the v3.14-rt1 patch set.

Changes since v3.12.15-rt25
- I dropped the sparc64 patches I had in the queue. They did not apply
  cleanly, the code in v3.14 changed in the MMU area. Here is where I
  remembered that it was not working perfectly either.

- Scott Wood pointed out that I forgot a return value in the latest
  gianfar fixup for RT. Return value added, thanks Scott.

This -RT series didn't crashed within ~4h testing on my ARM and
x86-32.
x86-64 crashed after I started hackbench. I figured out that the crash
does not happen with lazy-preempt disabled. Therefore the last but one
patch in the queue disables lazy preempt on x86-64. With this change the
test box survived ~2h without a crash. I look at this later but it looks
good now.

I decided to release it now because otherwise it would be lying around
probably the next two weeks or so. So here it is, enjoy.

Known issues:

      - bcache is disabled.

The RT patch against 3.14 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.0-rt1.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patches-3.14.0-rt1.tar.xz

Sebastian
