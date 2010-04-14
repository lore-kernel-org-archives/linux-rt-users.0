From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Debugging a hard lockup with no symptoms
Date: Wed, 14 Apr 2010 00:26:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004132345050.14952@haggis.caltech.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:54008 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab0DNH4Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Apr 2010 03:56:24 -0400
Received: from haggis.caltech.edu (haggis [131.215.193.40])
	by phobos.caltech.edu (8.14.3/8.14.3) with ESMTP id o3E7QEGm014830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Wed, 14 Apr 2010 00:26:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by haggis.caltech.edu (8.13.8/8.12.8) with ESMTP id o3E7QBJQ017926
	for <linux-rt-users@vger.kernel.org>; Wed, 14 Apr 2010 00:26:11 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have been experiencing hard lockups running a real-time application
under preempt-rt. Having originally had this problem while running
under 2.6.29.4-rt16, today I upgraded to 2.6.31.12-rt21, but the
problem persisted. Under both kernels, the computer simply freezes,
usually after a few hours of otherwise flawless operation. Nothing
appears on the serial console or in the system log when the system
freezes. Unfortunately, turning on the NMI watchdog stops the freezes
from occurring at all, such that I can't force an Oops that way.

I have tried running memtest86 on the RAM, without detecting any
memory errors, and I have verified that the same problem occurs on two
different (but essentially identical) computers.

I wonder whether there might be a clue in the fact that turning on the
NMI watchdog stops the freezes from occuring. Turning on the watchdog
unfortunately turns off tickless mode, which I need. According to the
boot-time messages, tickless is turned off because the local APIC is
non-functional (presumably because the NMI watchdog is using it). What
kind of bugs would be more likely to be seen when running under
tickless?

Could anybody give me any ideas on how to further debug this problem?
I have been trying to figure this out for weeks, but I haven't found
any clues.

In case it is important, the CPU is a 1.8GHz Intel Celeron, on a
Foxconn motherboard with an Intel G31 chipset, and Intel GMA 3100
onboard graphics. I am running the kernel (downloaded from kernel.org)
under Unbuntu 9.10. The computer also hosts two commercial digital I/O
boards, both generating interrupts, and one commercial analog I/O
board.

Thank you,

Martin
