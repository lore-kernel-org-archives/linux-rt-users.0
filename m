From: Stanislav Meduna <stano@meduna.org>
Subject: Bogus latency_hist/preemptirqsoff ?
Date: Sat, 20 Apr 2013 13:46:17 +0200
Message-ID: <51728009.8030601@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:45054 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755068Ab3DTLq2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Apr 2013 07:46:28 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1UTWFJ-00009g-En
	for linux-rt-users@vger.kernel.org; Sat, 20 Apr 2013 13:46:23 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

what and how does the latency_hist/preemptirqsoff measure?

The ftrace.txt says

"preemptirqsoff"

	Similar to irqsoff and preemptoff, but traces and
	records the largest time for which irqs and/or preemption
	is disabled.

# head -3 /sys/kernel/debug/tracing/latency_hist/wakeup/CPU0
#Minimum latency: 8 microseconds
#Average latency: 15 microseconds
#Maximum latency: 95 microseconds

# head -3 /sys/kernel/debug/tracing/latency_hist/timerandwakeup/CPU0
#Minimum latency: 8 microseconds
#Average latency: 15 microseconds
#Maximum latency: 95 microseconds

# head -3 /sys/kernel/debug/tracing/latency_hist/wakeup/sharedprio/CPU0
#Minimum latency: 9 microseconds
#Average latency: 42 microseconds
#Maximum latency: 603 microseconds  (this is OK, there are such threads)

# head -3 /sys/kernel/debug/tracing/latency_hist/irqsoff/CPU0
#Minimum latency: 0 microseconds
#Average latency: 2 microseconds
#Maximum latency: 136 microseconds

# head -3 /sys/kernel/debug/tracing/latency_hist/preemptoff/CPU0
#Minimum latency: 2 microseconds
#Average latency: 7 microseconds
#Maximum latency: 121 microseconds

# head -6 /sys/kernel/debug/tracing/latency_hist/preemptirqsoff/CPU0
#Minimum latency: 0 microseconds
#Average latency: 2 microseconds
#Maximum latency: 29001 microseconds
#Total samples: 29054669
#There are 0 samples lower than 0 microseconds.
#There are 15 samples greater or equal than 10240 microseconds.


The 29 ms looks bogus. There are two test-applications running
and each one would cry loudly being without CPU for 10 ms or more.
Or is there a possibility that the irqsoff and preemptoff alternate
so that everything looks normal but there is not a single time
both are possible?

3.4.25-rt37, preempt full.

Thanks
-- 
                                         Stano
