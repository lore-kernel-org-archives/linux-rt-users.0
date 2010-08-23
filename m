From: Agustin Ferrin Pozuelo <agustin.ferrin@cgglobal.com>
Subject: 2.6.33.7-rt29 PREEMPT_RT worse latency than PREEMPT_DESKTOP on AT91?
Date: Mon, 23 Aug 2010 17:39:20 +0100
Message-ID: <4C72A438.2080301@cgglobal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from edge.cgglobal.com ([202.54.16.167]:51626 "EHLO
	edge.cgglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab0HWQjf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Aug 2010 12:39:35 -0400
Received: from cgglobal.com ([192.168.1.7])
	by edge.cgglobal.com (8.14.1/8.14.1) with ESMTP id o7NGdVc6005311
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Aug 2010 22:09:31 +0530
Received: from mail.microsol.ie by cgglobal.com (MDaemon PRO v9.6.6)
	with ESMTP id md50026552261.msg
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Aug 2010 22:08:44 +0530
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am fine tuning the configuration for an ARM system derived from=20
AT91SAM9263-EK.

My goal is to minimize latency, and I am using "cyclictest" from=20
rt-tools v0.78 for measuring it.

I get consistently better latency with PREEMPT_DESKTOP over what I get=20
with PREEMPT_RT. This is an example for a very simple test run, which=20
reflects the overall results I am getting:

    ### PREEMPT-RT, HRT, no NO_HZ, no RTC, no USE_SLOW_CLOCK

    root@at91sam9263cpc:~# time cyclictest -i 700000 -r -p 80 -l 33
    Clock resolution: 0.000000001 (s.ns)
    policy: fifo: loadavg: 0.11 0.10 0.04 1/49 884

    T: 0 (  861) P:80 I:700000 C:     33 Min:    370 Act:  627 Avg:  43=
7 Max:     627
    real	0m 23.51s
    user	0m 0.38s
    sys	0m 2.20s

    ### PREEMPT-DESKTOP (no RT), HRT, no NO_HZ, no USE_SLOW_CLOCK
    root@at91sam9263cpc:~# time cyclictest -i 700000 -r -p 80 -l 33
    Clock resolution: 0.000000001 (s.ns)
    policy: fifo: loadavg: 0.24 0.08 0.03 1/46 600

    T: 0 (  574) P:80 I:700000 C:     33 Min:    173 Act:  196 Avg:  22=
2 Max:     378
    real	0m 23.66s
    user	0m 0.32s
    sys	0m 1.29s
      =20

That is, I get much better min, avg, and max latency with=20
"PREEMPT_DESKTOP". How can this be?

Anyway, the results seem worse than the <150us worst case) obtained wit=
h=20
2.6.24.7-rt27 by Remy Bohmer=20
<https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Platforms=
_Tested_and_in_Use_with_CONFIG_PREEMPT_RT>,=20
though he was apparently/ not using 'Tickless and HRT' /because of CPU=20
usage issues... But without those I can't get cyclictest to run properl=
y!

My guess is that the RT patch adds code (checks, locks) to may critical=
=20
sections that happens to be specially slow on ARM9...

Clues & comments welcome!
--Agust=EDn.

--=20
[CG logo]

Agust=EDn Ferr=EDn Pozuelo

Embedded Systems Engineer

CG Power Systems Ireland Limited

Automation Systems Division

Herbert House, Harmony Row, Dublin 2, Ireland.

Phone: +353 1 4153700 Web: www.cgglobal.com <http://www.cgglobal.com>

Save the environment. Please print only if essential.



CG DISCLAIMER: This email contains confidential information. It is inte=
nded exclusively for the addressees. If you are not an addressee, you m=
ust not store, transmit or disclose its contents. Instead please notify=
 the sender immediately; and permanently delete this e-mail from your c=
omputer systems. We have taken reasonable precautions to ensure that no=
 viruses are present. However, you must check this email and the attach=
ments, for viruses. We accept no liability whatsoever, for any detrimen=
t caused by any transmitted virus.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
