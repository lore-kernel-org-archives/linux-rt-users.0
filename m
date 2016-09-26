From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge latencies in cyclictest
Date: Mon, 26 Sep 2016 13:48:43 +0200
Message-ID: <38815425.6GFOjqvR3a@ws-stein>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com> <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com> <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58611 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934676AbcIZLsv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Sep 2016 07:48:51 -0400
In-Reply-To: <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday 23 September 2016 11:40:46, Koehrer Mathias wrote:
> Hi Sebastian,
> 
> 
> > thanks for the feedback.
> > 
> > > > I run the cyclictest with the following options:
> > > > # cyclictest -a -i 100 -d 10 -m -n -t -p 80
> > >
> > >
> > >
> > > there is -S. And then 100 might be a little tight.
> > >
> > >
> > >
> > > > Of course the 2 minutes run-time of cyclictest is only a rough first
> > > > estimate.
> >
> > >
> > >
> > > and with no load…
> > >
> > >
> > >
> > > > Once I configure one of the i350 ports # ifconfig eth2 up
> > > > 192.168.100.100 the cyclictest shows directly and reproducibly
> > > > significant larger max latency values (40 microseconds, using the
> > > > same
> > > 
> > > conditions).
> > > 
> > > >
> > > >
> > > >
> > > > I did the very same test with kernel version 3.18.27-rt27.
> > > > With that version I did not see anything like that.
> > > >
> > > >
> > > >
> > > > Also, only the igb driver seems to cause the trouble. I have also an
> > > > e1000e based NIC in this PC and the usage of this driver does not
> > > > add any
> > > 
> > > significant latency.
> > > 
> > > >
> > > >
> > > > Any idea on this?
> > >
> > >
> > >
> > > Does this also happen if you have the NIC up and you plug in / out the
> > > cable? There are two things that come to mind:
> > > 
> > >   https://lkml.kernel.org/r/1445465268-10347-1-git-send-email-> > > 
> > > jonathan.david@ni.com
> > >
> > >
> > >
> > > https://lkml.kernel.org/r/1445886895-3692-1-git-send-email-joshc@ni.co
> > > m
> > 
> > 
> > This happens even if I have done "ifconfig up" on the NIC without having a
> > cable
 plugged in.
> > Also, it happens if I have a cable plugged in and the link is up but no
> > traffic is running
 via this NIC port.
> > It looks as if solely the configured NIC port is causing the additional
> > latency, no
 matter if traffic is flowing via this NIC or not and no
> > matter if the link is up or not. 
> > I did the same test with the kernel/rt_preempt patch versions
> > 4.1.33-rt37 and 4.4.19-rt27, they show the very same behavior.
> > In opposite to that, the version 3.18.27-rt27 is working stable!
> > 
> > As mentioned before, the "igb" driver is causing the issue. The "e1000e"
> > driver works
 fine.
> > 
> 
> I did some further analysis.
> The code that is causing the long latencies seems to be the 
> function "igb_watchdog_task" within igb_main.c (Line: 4386). 
> This function will be called periodically.
> When I do a return at the beginning of this function the additional latency
> is not seen.
 In particular that function calls "igb_has_link" which seems
> to be one candidate that is causing additional latency.
> Do you have any clue how this code can be executed properly without causing
> the
 additional latencies?

IMHO something in igb_watchdog_task causes the latency independently from 
actual link. At first glance I would suspect igb_update_stats (called with 
spinlock held) as it seems to do a lot of reads. Maybe this stalls somehow.
Does the latency still occur if you comment that spinlock and call to 
igb_update_stats out?

Best regards,
Alexander

