From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 16:27:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210241621060.2756@ionos>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain> <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmnlvqm76426ze@localhost.localdomain> <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain> <alpine.LFD.2.02.1210241156380.2756@ionos> <op.wmoiyqew6426ze@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51087 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934939Ab2JXO2A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 10:28:00 -0400
In-Reply-To: <op.wmoiyqew6426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
> On Wed, 24 Oct 2012 11:59:38 +0200, Thomas Gleixner <tglx@linutronix.de>
> wrote:
> > In any case it would be helpful if you provide the full dmesg output
> > of a failing boot.
> 
> Ok, you reall want to know. Well I can do anything to help you with that. Does
> dmseg contain info from last boot? Or can it be accessed from the
> console-thingy?

If you have a serial port on that machine, then you can enable the
serial console with "console=ttyS0,115200" on the kernel command
line. Use a second machine to record the data.

If you don't have a serial, then you should be able to do something
from the initrd shell. Your ethernet driver should be loaded already,
if not just compile it into the kernel instead into a module. Now you
can get it out over the net from that shell.
 
A third option is to use netconsole. Do this on mainline with the
"threadirqs" option, as I haven't tried netconsole on RT.
See Documentation/networking/netconsole.txt

> Mainline does also not work with threadirq.

Good. So it's not RT wreckage :)

Thanks,

	tglx
