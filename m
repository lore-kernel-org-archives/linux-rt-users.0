From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.5-rt14
Date: Thu, 1 Nov 2012 21:57:54 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1211012148170.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.6.5-rt14 release. 3.6.4-rt12 is an
intermediate release with a few changes. 3.6.5-rt13 is an update to
3.6.5 and 3.6.5-rt14 has a fix for my stupidity to release from the
wrong tree missing a fix for x86-32.

Changes since 3.6.3-rt11:

   * Fix the fallout of preempt_lazy

   * Add preempt_lazy support for ARM and POWERPC

   * Fix a 32bit compile warning which got introduced with the
     random fixes.

   * Fix a missing lock conversion in the decive tree code

The delta patch against 3.6.4-rt11 is can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.4-rt11-rt12.patch.xz

The RT patch against 3.6.5 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.5-rt14.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.5-rt14.tar.xz

Enjoy,

	tglx
