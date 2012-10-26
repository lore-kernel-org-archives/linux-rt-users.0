From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Fri, 26 Oct 2012 10:24:46 -0400
Message-ID: <CAP=VYLo2HGsuS6wBaU9_d3Es7P2MEW4s1xzmFGbSkDeRyHf-UQ@mail.gmail.com>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain> <alpine.LFD.2.02.1210241156380.2756@ionos>
 <op.wmoiyqew6426ze@localhost.localdomain> <alpine.LFD.2.02.1210241621060.2756@ionos>
 <op.wmo0g1qc6426ze@localhost.localdomain> <alpine.LFD.2.02.1210242037440.2756@ionos>
 <op.wmo45bu46426ze@localhost.localdomain> <alpine.LFD.2.02.1210242123570.2756@ionos>
 <op.wmo67vqb6426ze@localhost.localdomain> <alpine.LFD.2.02.1210242147550.2756@ionos>
 <op.wmo8dkvt6426ze@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, sven@thebigcorporation.com,
	linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40841 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218Ab2JZOZQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2012 10:25:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2809759pbb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Oct 2012 07:25:16 -0700 (PDT)
In-Reply-To: <op.wmo8dkvt6426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 24, 2012 at 3:57 PM, Uwaysi Bin Kareem
<uwaysi.bin.kareem@paradoxuncreated.com> wrote:

[boot failure with sata_nv...]

>
> 00:0e.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev
> a1) (prog-if 85 [Master SecO PriO])
>         Subsystem: Micro-Star International Co., Ltd. Device 7380
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0 (750ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 21
>         Region 0: I/O ports at d800 [size=8]
>         Region 1: I/O ports at d480 [size=4]
>         Region 2: I/O ports at d400 [size=8]
>         Region 3: I/O ports at d080 [size=4]
>         Region 4: I/O ports at d000 [size=16]
>         Region 5: Memory at f9ffd000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: <access denied>
>         Kernel driver in use: sata_nv
>         Kernel modules: sata_nv
>

I've booted 3.6.3-rt6 on nearly identical hardware:

00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
(rev f1) (prog-if 85 [Master SecO PriO])
        Subsystem: Hewlett-Packard Company Device 30b5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 30b0 [size=8]
        Region 1: I/O ports at 30a4 [size=4]
        Region 2: I/O ports at 30a8 [size=8]
        Region 3: I/O ports at 30a0 [size=4]
        Region 4: I/O ports at 3090 [size=16]
        Region 5: Memory at b0006000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>
        Kernel driver in use: sata_nv

So there must be something wrong in your configuration, or your
hardware,or something happening in the build.   Without more
information, like your .config file, the output of "gcc -v", and ideally
a picture of the error messages from the screen just as they start
happening, there isn't much more anyone can do to help you further.

You probably need to intercept the grub menu at early boot and
delete the "quiet" and "splash" options to get the normal boot
messages to show up on the screen.

Paul.
