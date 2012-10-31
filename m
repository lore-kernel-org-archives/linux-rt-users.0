From: Stanislav Meduna <stano@meduna.org>
Subject: Wakeup latency measured with SCHED_TRACER depends on HZ
Date: Wed, 31 Oct 2012 22:41:19 +0100
Message-ID: <50919AFF.3060602@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:56972 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759734Ab2JaVle (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2012 17:41:34 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TTg2O-0002cu-Fh
	for linux-rt-users@vger.kernel.org; Wed, 31 Oct 2012 22:41:31 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

on an embedded platform using a Freescale i.MX28 ARM processor
I am experiencing a strange phenomenon - the latencies reported
are dependent of HZ in the way such as:

# cat timerandwakeup/max_latency-CPU0

HZ 500:
459 15 2499 (499) myApp <- 284 -6 mmcqd/1 273.436000

HZ 100:
459 15 10453 (453) myApp <- 284 -6 mmcqd/1 273.436000


The wakeup/max_latency is always exactly one HZ tick

# cat wakeup/max_latency-CPU0
233 50 2000 (0) irq/101-imx28-f <- 0 -21 swapper 121.764000


All the timestamps in e.g. dmesg output also exhibit the HZ
granularity (this is definitely not the case on an x86),
so I'd say the interpolation somehow does not work.
The hardware counter itself increments at 32 kHz (at least
clocksource_mmio_init is called with 32000 in hz parameter).

Date +%N (show nanosecond part of current time) does not
exhibit the same rounding.


Anyone has an idea where to start the search? I understand
that as I am probably the first one experimenting with RT
on this platform I am basically on my own here, I'd just
appreciate pointers to relevant information on the timing
infrastructure.

I am using 3.4.15-rt24 with some patches ported from an older
non-RT kernel provided by the platform vendor. However, none
of those patches touches clock/time handling, so these are from
mainline (arch/arm/mach-mxs/timer.c etc).

Thanks
-- 
                                    Stano
