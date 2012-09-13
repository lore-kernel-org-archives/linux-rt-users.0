From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: clock_nanosleep and NTP drift correction
Date: Thu, 13 Sep 2012 15:18:46 -0300
Message-ID: <20120913181846.GL5341@uudg.org>
References: <F9467A784CC48947B1D879F07370839E0EBB712C@fe20099s.ecn.etasgroup.com>
 <20120913120922.GA5341@uudg.org>
 <5051FA33.7050205@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45445 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab2IMSWQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 14:22:16 -0400
Received: by yhmm54 with SMTP id m54so785476yhm.19
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Sep 2012 11:22:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5051FA33.7050205@drcomp.erfurt.thur.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Sep 13, 2012 at 05:22:27PM +0200, Adrian Knoth wrote:
| On 09/13/2012 02:09 PM, Luis Claudio R. Goncalves wrote:
| 
| > | clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL);
| > | within the application's main loop.
| > | The value of "ts" will be incremented after every call.
| > | 
| > CLOCK_MONOTONIC is not affected by NTP nor any adjusts to date and time
| > that the admin/user may perform.
| 
| I beg to differ. CLOCK_MONOTONIC is frequency adjusted. Though it won't
| jump, it will slew. From man clock_gettime:
| 
|   CLOCK_MONOTONIC
|          Clock  that  cannot  be  set and represents monotonic time since
|          some unspecified starting point.  This clock is not affected  by
|          discontinuous  jumps  in  the  system  time (e.g., if the system
|          administrator manually changes the clock), but  is  affected  by
|          the incremental adjustments performed by adjtime(3) and NTP.

You are right. The man pages I had access to are a bit less verbose on the
description but, to the attentive reader, give the same idea. Also Mathieu
and Rostedt showed me I had a slightly absurd concept of 'monotonic'.

I learned two new things on a single discussion :)

Cheers,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

