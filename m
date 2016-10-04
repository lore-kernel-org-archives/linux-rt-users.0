From: Julia Cartwright <julia@ni.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Tue, 4 Oct 2016 14:34:45 -0500
Message-ID: <20161004193445.GF10625@jcartwri.amer.corp.natinst.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <20160923123224.odybv2uos6tot6it@linutronix.de>
 <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
 <20160923144140.5tkzeymamrb5qnsv@linutronix.de>
 <a5ea146cf078457ab001131ca0886b0b@FE-MBX1012.de.bosch.com>
 <20160928194519.GA32423@jcartwri.amer.corp.natinst.com>
 <487032ca81f84e70bdacc39a024eff5e@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:60450 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751479AbcJDTe7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Oct 2016 15:34:59 -0400
In-Reply-To: <487032ca81f84e70bdacc39a024eff5e@FE-MBX1012.de.bosch.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Oct 04, 2016 at 02:33:08PM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Julia,

Hey Mathias-

> > Which, looks to me to be the normal "forced primary" interrupt handling path, which
> > simply wakes the created irqthread.
> > 
> > However, what isn't clear from the data is _which_ irqthread(s) is being woken up.
> > Presumably, due to the prior igb traces, it's one of the igb interrupts, but that would
> > be nice to confirm using the sched_wakeup event or other means.
> > 
[..]

> In the meanwhile I have detected another finding which might be relevant:
>
> With the 3.18 kernel the igb driver comes with two interrupts per NIC (e.g. eth2 and eth2-TxRx0)
> with the 4.6. kernel the igb driver comes with 9 (!) interrupts per NIC: 
> eth2, and eth2-TxRx-0, eth2-TxRx-1, ... , eth2-TxRx-7.
>
> As I have used initially the same kernel configuration from 3.18 also
> for the 4.6. kernel I wonder where this comes from and if there is any
> kernel option I may use to disable these many interrupts and to reduce
> it to 2 again.

If it's all of these interrupts that are firing and being handled at the
same time, that can account for the latencies you were seeing.  As I
suggested before, having a trace with the sched_wakeup event enabled can
help confirm that it's these interrupts causing problems.

If it is true, then the question is: why is the device triggering all of
these interrupts all at once?  Is that expected?  These are questions
for netdev folks, I think.

   Julia
