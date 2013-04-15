From: Stanislav Meduna <stano@meduna.org>
Subject: hrtimer: interrupt took 6742 ns, then RT throttling and hung machine
 for nearly 2 seconds
Date: Mon, 15 Apr 2013 13:02:42 +0200
Message-ID: <516BDE52.90200@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:40155 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933036Ab3DOLCw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Apr 2013 07:02:52 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1URhBO-0005EO-PE
	for linux-rt-users@vger.kernel.org; Mon, 15 Apr 2013 13:02:48 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Apr 15 10:14:57 lnx kernel: [56281.700293] hrtimer: interrupt took 6742 ns
Apr 15 10:14:57 lnx kernel: [330740.000129] [sched_delayed] sched: RT
throttling activated


>From our application logs the machine was basically hung for something
between 1.71 - 1.73 seconds, then resumed normal operation. A 5ms
timerfd_create timer returned 341 expirations, the 340 missed
exactly correspond to the 1.7 seconds.

None of the /sys/kernel/debug/tracing/latency_hist/* reports anything
unusual, they are all in the tens of microsecond range, only wakeup
shared prio is at 957 us between two same prio application threads,
which is expected.

It is not very probable that the reason for the throttling is our
application. We have own monitoring of the runaway tasks and this
did not kick in. Besides, the coincidence with the hrtimer
message looks very suspicious.


The kernel is 3.4.25-rt37 with full preempt on a 1 GHz Celeron M
industrial PC, ICH4 (ata_piix) used for ATA, Intel 82801DB PRO/100 VE
(e100) for ethernet.

Unfortunately it is not easily reproducible - it happens once
per several days and there is no obvious trigger.

Any hints?

Thanks
-- 
                                             Stano
