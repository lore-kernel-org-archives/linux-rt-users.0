From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Fri, 23 Sep 2016 14:32:24 +0200
Message-ID: <20160923123224.odybv2uos6tot6it@linutronix.de>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41186 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964828AbcIWMdF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 08:33:05 -0400
Content-Disposition: inline
In-Reply-To: <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-23 11:40:46 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Sebastian,
Hi Mathias,

> The code that is causing the long latencies seems to be the 
> function "igb_watchdog_task" within igb_main.c (Line: 4386). 
> This function will be called periodically.
> When I do a return at the beginning of this function the additional latency is not seen.
> In particular that function calls "igb_has_link" which seems to be one candidate that is
> causing additional latency.
> Do you have any clue how this code can be executed properly without causing the
> additional latencies?

Nope. The watchdog function is invoked via schedule_work() so it should
not be blocking anything. There is no preempt disable or anything like
that. Could you narrow it down further? The igb_has_link() seems also
small and simple.

> Regards
> 
> Mathias
> 
Sebastian
