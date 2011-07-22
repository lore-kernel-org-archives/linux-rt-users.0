From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.0-rt1
Date: Fri, 22 Jul 2011 22:37:24 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107222203400.2702@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59765 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab1GVUh0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 16:37:26 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.0-rt1 release.

Changes versus 3.0-rc7-rt0:

  * Update to Linus final 3.0 release

  * RTC bugfixes (scheduled for mainline/stable)

  * Long standing (rt only) timer_list bug (see
    timers-avoid-the-base-null-otptimization-on-rt.patch in the split
    out quilt queue)

  * Minor non exciting fixes all over the place

Known issues:

  * Some weird "console=..." commandline + config dependent
    interactions which have been not yet investigated down to their
    root cause. Result in a boot hang. YMMV

Patch against 3.0 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0-rt1.patch.bz2

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0-rt1.tar.bz2

Thanks,

	tglx
