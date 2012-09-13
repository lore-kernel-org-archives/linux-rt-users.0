From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: clock_nanosleep and NTP drift correction
Date: Thu, 13 Sep 2012 09:09:22 -0300
Message-ID: <20120913120922.GA5341@uudg.org>
References: <F9467A784CC48947B1D879F07370839E0EBB712C@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60977 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab2IMMMw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 08:12:52 -0400
Received: by yhmm54 with SMTP id m54so662395yhm.19
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Sep 2012 05:12:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBB712C@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Sep 13, 2012 at 11:20:24AM +0000, Koehrer Mathias (ETAS/ESS2) wrote:
| Hi all!
| 
| I have two x86 PCs running with the RT_PREEMPT patch (2.6.33.x).
| Both PCs run a real time application with a thread that will be executed periodically every 1ms.
| For this I use a
| clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL);
| within the application's main loop.
| The value of "ts" will be incremented after every call.
| 
| Both PCs (PC-A, PC-B) are connected via Ethernet to a third PC (PC-C) that acts as NTP time server for the other PCs (PC-A and PC-B).
| 
| My question is now:
| Does clock_nanosleep() consider a potential time drift that is corrected by NTP?
| Or: Will there be a significant drift between both PCs (PC-A, PC-B) by using this approach?

CLOCK_MONOTONIC is not affected by NTP nor any adjusts to date and time
that the admin/user may perform.

The only problem you could face would happen if the 'ts' value, third
parameter passed to clock_nanosleep, was coming from one system and being
used on both. Then, any difference between the clocks could lead to shorter
sleep times. Other than that, as far as manpages go, you seem to be safe.

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

