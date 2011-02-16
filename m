From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Wed, 16 Feb 2011 12:18:44 -0800
Message-ID: <AANLkTi=xOV7M_9ShmG5VH1xmz7jURYbMMMVNhHoh4LLj@mail.gmail.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>
	<AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
	<AANLkTimvEy8VE5564CWLeDMHLV8cVBmor8weJos8+ovU@mail.gmail.com>
	<AANLkTikCXF8BY+gh3P0kZPuUFvSp80acF8kH5CRmykRQ@mail.gmail.com>
	<4D5AC80F.1090205@am.sony.com>
	<AANLkTi=ajLEV2S_6RcHKE8w82DSTMObg3TXFOjoZCdmF@mail.gmail.com>
	<AANLkTin7ui0JDyfFCdHFAOdtL5c=d0-51Wf3PcB-X5c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: frank.rowand@am.sony.com, linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57671 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1BPUSp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Feb 2011 15:18:45 -0500
Received: by gxk9 with SMTP id 9so780701gxk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Feb 2011 12:18:45 -0800 (PST)
In-Reply-To: <AANLkTin7ui0JDyfFCdHFAOdtL5c=d0-51Wf3PcB-X5c2@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

For those that are interested, I've gathered some statistics about the
high resolution timers.  I've already described the test conditions,
but here I'll give more information on our platform.

MPC8349 (PPC32 @ 528MHz)
512MB DDR2 SDRAM
16GB NAND (x8)

Some asked about the jitter distribution, and I've gathered some
numbers.  I ran this over 10000 samples.

Baseline:  Min = 3.821ms, Max = 3.951ms, Mean = 3.844ms, Variance =
88.5108 (deviation of about 9.4us)
Loaded: Min = 3.833ms, Max = 4.234ms, Mean = 4.099ms, Variance =
1276.35 (deviation of about 35us)

We see the mean go up and the variance increase.  The large number of
timers really do impact the performance of high priority tasks, and
the jitter gets much worse.

Further, I instrumented the timer_interrupt code to get a feeling for
the burden on the interrupt and how often the interrupts happen.  I
read the timbase register (a 64-bit incrementer that increments once
every ~15ns) at the start and end of the interrupt, and determine the
maximum.  I also measure how the time between the end of the timer
interrupt and the start of the next timer interrupt.

Baseline:  max burden = 79.7us, minimum time between interrupts =
364ns, average time between interrupts 421us.
Loaded:  max burden = 92.7us, minimum time between interrupts = 24ns,
average time between interrupts 180us

As we see, the interrupt frequency spikes when loaded, and the time
between interrupts drops significantly.  The interrupt burden rises
slightly, but given the fact we are interrupted quite frequently.
Now, our modification to increase the minimum decrementer delta did
improve the time between interrupts, but significantly increased the
timer interrupt burden (from 92.7us to 462us).  So, we either get lots
of interrupts, averaging 93us per hit, or few interrupts, but 426us of
burden.  Either way, it averages out to too much.

We are looking into ways to get away from nanosleep (or dramatically
drop the number of nanosleep calls).  To that end, we are considering
a timer "server" type application.  This application accepts timer
requests, schedules the appropriate nanosleep (or select, poll, etc),
then responds when the client needs to be awakened.  Does anyone know
of an existing project that does something similar to this?  Perhaps
somethings smaller than dbus, but with the same kind of operation.

Thanks,
Pete
