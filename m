From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Tue, 4 Oct 2016 14:33:08 +0000
Message-ID: <487032ca81f84e70bdacc39a024eff5e@FE-MBX1012.de.bosch.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <20160923123224.odybv2uos6tot6it@linutronix.de>
 <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
 <20160923144140.5tkzeymamrb5qnsv@linutronix.de>
 <a5ea146cf078457ab001131ca0886b0b@FE-MBX1012.de.bosch.com>
 <20160928194519.GA32423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia.cartwright@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:32403 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbcJDOdM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Oct 2016 10:33:12 -0400
In-Reply-To: <20160928194519.GA32423@jcartwri.amer.corp.natinst.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julia,

> 
> Which, looks to me to be the normal "forced primary" interrupt handling path, which
> simply wakes the created irqthread.
> 
> However, what isn't clear from the data is _which_ irqthread(s) is being woken up.
> Presumably, due to the prior igb traces, it's one of the igb interrupts, but that would
> be nice to confirm using the sched_wakeup event or other means.
> 
> Similar to the PCI write-buffering cases, we've also observed that when the PCI
> interconnect is bogged down with traffic from other masters, it's possible that a read
> from the CPU can be stalled (in some cases, for quite awhile, but it depends on the
> PCI topology, switches used, their configurations, etc).
> 
> So, one plausible narrative here: it's conceivable that the
> rd32(E1000_RXSTMPH) in igb_ptp_rx_hang() is "stuck" in the bus somewhere
> presumably due to load from other masters (the trace seems to indicate it might be
> as much as 20us), with CPU execution stalled awaiting it's completion.  Meanwhile,
> the CPU is encountering interrupts from other sources (local APIC, etc).  Once the
> read "completes", the CPU is finally able to service all of the interrupts that have
> piled up, which is why we see in the traces these 9 wakeups happening in a row.
> 
> The question is: how can we confirm/refute this, or are there other, more plausible
> scenarios it's possible to run into?
Thanks for the proposal. Unfortunately I have no idea on this.

In the meanwhile I have detected another finding which might be relevant:
With the 3.18 kernel the igb driver comes with two interrupts per NIC (e.g. eth2 and eth2-TxRx0)
with the 4.6. kernel the igb driver comes with 9 (!) interrupts per NIC: 
eth2, and eth2-TxRx-0, eth2-TxRx-1, ... , eth2-TxRx-7.
As I have used initially the same kernel configuration from 3.18 also for the 4.6. kernel I wonder
where this comes from and if there is any kernel option I may use to disable these many
interrupts and to reduce it to 2 again.

Any idea on this is welcome.

Regards

Mathias

