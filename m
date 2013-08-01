From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.10.4-rt1
Date: Thu, 1 Aug 2013 13:24:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1308011215160.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the 3.10.4-rt1 patch set.

This is a mostly straight forward port of the 3.8 set. I had
experimented with a new implementation detail, but I did not get it
into a shape which would have made it applicable to RT.

Known issues:

      - SLAB support not working

      - Untested on ARM and PPC (hapless victims^W^Wtesters are
        welcome)

I'm about to leave for my annual kids summer camp kitchen duty, so I
let you fool around with the current pile.

Sebastian will help out while I'm away, so please send tons of patches
in the next couple of days and get this thing fixed before I
return. All I'm going to look for in my mail backlog is a mail with
the subject: 3.10.x-rty is perfect :)

The RT patch against 3.10.4 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patch-3.10.4-rt1.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patches-3.10.4-rt1.tar.xz

Enjoy,

        tglx
