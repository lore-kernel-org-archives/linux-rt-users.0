From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: clock_nanosleep and NTP drift correction
Date: Thu, 13 Sep 2012 11:20:24 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E0EBB712C@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:36059 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab2IMLU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 07:20:26 -0400
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 061E8B00017
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Sep 2012 13:20:26 +0200 (CEST)
Received: from localhost (vsgw1.fe.internet.bosch.com [10.4.98.15])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id DE2201AC07A7
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Sep 2012 13:20:25 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all!

I have two x86 PCs running with the RT_PREEMPT patch (2.6.33.x).
Both PCs run a real time application with a thread that will be executed periodically every 1ms.
For this I use a
clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL);
within the application's main loop.
The value of "ts" will be incremented after every call.

Both PCs (PC-A, PC-B) are connected via Ethernet to a third PC (PC-C) that acts as NTP time server for the other PCs (PC-A and PC-B).

My question is now:
Does clock_nanosleep() consider a potential time drift that is corrected by NTP?
Or: Will there be a significant drift between both PCs (PC-A, PC-B) by using this approach?

As the application runs very long (hours or even days) I am looking for a solution that avoids 
large drifts between the two systems.
Deltas of 1 or 2 ms are acceptable, but no time differences in tens of milliseconds.

Thanks for any help or feedback on this question

Best regards

Mathias


