From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: Re: clock_nanosleep and NTP drift correction
Date: Thu, 13 Sep 2012 12:59:15 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E0EBB71D2@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:39063 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973Ab2IMM7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 08:59:19 -0400
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On Thu, Sep 13, 2012 at 11:20:24AM +0000, Koehrer Mathias (ETAS/ESS2) wrote:
> | I have two x86 PCs running with the RT_PREEMPT patch (2.6.33.x).
> | Both PCs run a real time application with a thread that will be executed periodically
> every 1ms.
> | For this I use a
> | clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL);
> | within the application's main loop.
> | The value of "ts" will be incremented after every call.
> |
> | Both PCs (PC-A, PC-B) are connected via Ethernet to a third PC (PC-C) that acts as
> NTP time server for the other PCs (PC-A and PC-B).
> |
> | My question is now:
> | Does clock_nanosleep() consider a potential time drift that is corrected by NTP?
> | Or: Will there be a significant drift between both PCs (PC-A, PC-B) by using this
> approach?
> 
> CLOCK_MONOTONIC is not affected by NTP nor any adjusts to date and time
> that the admin/user may perform.
> 
> The only problem you could face would happen if the 'ts' value, third
> parameter passed to clock_nanosleep, was coming from one system and being
> used on both. Then, any difference between the clocks could lead to shorter
> sleep times. Other than that, as far as manpages go, you seem to be safe.
I want to ensure that after one day the very same number of cycles have
been executed on PC-A and PC-B.
Even if the internal clock of PC-A has a drift of 2s/day against that of PC-B.
Using NTP the real time clock will be corrected - however the used
function clock_nanosleep using CLOCK_MONOTONIC will not.
Does this mean that I will have 2000 more millisecond cycles on the "faster PC" during
a whole day?

Regards

Mathias

