From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.1-rt2
Date: Tue, 16 Oct 2012 20:41:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210162037380.2811@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.6.1-rt2 release.

Changes since 3.6.1-rt1:

	* Picked up Pauls git friendly quilt queue

	* Compile fix for !RT_FULL (Paul Gortemaker)

	* Crypto init order fix

	* Tiny RCU fix which affects UP and is a long standing bug
	  affecting 3.2 and 3.4-rt as well.

The delta patch against 3.6.1-rt1 is appended below and can be found here

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.1-rt1-rt2.patch.xz

The RT patch against 3.6.1 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.1-rt2.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.1-rt2.tar.xz

Enjoy,

	tglx
