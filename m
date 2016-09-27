From: Mathias Koehrer <mathias.koehrer@etas.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Tue, 27 Sep 2016 09:56:18 +0200
Message-ID: <57EA2622.5030702@etas.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <38815425.6GFOjqvR3a@ws-stein>
 <68efc1a28c454c3f95f1d5d5231e2f68@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:37723 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbcI0H4X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Sep 2016 03:56:23 -0400
In-Reply-To: <68efc1a28c454c3f95f1d5d5231e2f68@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> > IMHO something in igb_watchdog_task causes the latency independently
> > from actual link. At first glance I would suspect igb_update_stats
> > (called with spinlock
> > held) as it seems to do a lot of reads. Maybe this stalls somehow.
> > Does the latency still occur if you comment that spinlock and call to
> > igb_update_stats out?
> 
> I tried that, however the result is the very same. I have the very same latency spikes
> as before.
> I went even further. Within the function igb_watchdog_task I removed everything but
> the call to igb_has_link() and the final timer reset.
> However even that led to the same result.
> And there I am again at the findings in one of my previous postings within this
> thread.
> The call to igb_has_link might be a reason for the latency jitters, however I cannot
> really break it down into a single piece of code that is relevant here.
I tried something completely different: 
I used the Intel Linux igb driver from the Intel website
(version 5.3.5.3) and tried this driver on the rt_preempt kernels 3.18.27-rt27 as well as
on the 4.6.7-rt13.
And also here I saw the same effect: With the 3.18.27 the cyclictest shows really great results
but with the 4.6.7 the cyclictest results show spikes once a igb based NIC is enabled.
For me this looks as if there is something running differently in the "underground" and the 
igb driver is make some strange effect visible.
Any ideas on this new finding?

Regards

Mathias

