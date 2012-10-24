From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 21:49:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210242147550.2756@ionos>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain> <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmnlvqm76426ze@localhost.localdomain> <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain> <alpine.LFD.2.02.1210241156380.2756@ionos> <op.wmoiyqew6426ze@localhost.localdomain> <alpine.LFD.2.02.1210241621060.2756@ionos> <op.wmo0g1qc6426ze@localhost.localdomain> <alpine.LFD.2.02.1210242037440.2756@ionos>
 <op.wmo45bu46426ze@localhost.localdomain> <alpine.LFD.2.02.1210242123570.2756@ionos> <op.wmo67vqb6426ze@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53014 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab2JXTtd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 15:49:33 -0400
In-Reply-To: <op.wmo67vqb6426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
> On Wed, 24 Oct 2012 21:24:23 +0200, Thomas Gleixner <tglx@linutronix.de>
> wrote:
> > Ok. Can you please provide dmesg from a working kernel ?
> 
> uwaysi@Millennium:~$ dmesg
> input: HDA NVidia Line Out Front as
> /devices/pci0000:00/0000:00:10.1/sound/card0/input11

That's just the tail of dmesg. I really need the whole thing from
boot.

The output of "lscpi -vvv" and "cat /proc/interrupts" might be helpful
as well.

Thanks,

	tglx
