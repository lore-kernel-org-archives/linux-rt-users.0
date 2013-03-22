From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.8.4-rt1
Date: Fri, 22 Mar 2013 23:10:11 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303222301010.22263@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39028 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422658Ab3CVWKN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 18:10:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.8.4-rt1 release.

Again the credit for the heavy lifting goes to Sebastian Siewior, AKA
bigeasy, who took up most of the work to get this out. He's on my
companies engineering team and I hope you trust him as much as I do.

Known issues:

      - SLUB behaves worse than SLAB on ARM
      - SLAB is broken on PowerPC

Still we think that it's time to get out the stuff for broader
testing. It's -rt1 and we need your help to get this stabilized.

The RT patch against 3.8.4 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patch-3.8.4-rt1.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patches-3.8.4-rt1.tar.xz

Enjoy,

        tglx
