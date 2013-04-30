From: Stanislav Meduna <stano@meduna.org>
Subject: How to find long execution times in kernel threads?
Date: Tue, 30 Apr 2013 15:48:19 +0200
Message-ID: <517FCBA3.1000909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:45284 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760460Ab3D3Ns2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 09:48:28 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1UXAut-0007vm-3l
	for linux-rt-users@vger.kernel.org; Tue, 30 Apr 2013 15:48:25 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am experimenting with the cyclictest on a system running
several RT threads to find out where some latencies are
coming from and to get a better undertanding how the system
behaves.

The setup is:

class prio   thread
FF    99     posixcputmr
FF    50     irq threads
FF    47     ksoftirqd
RR    45-25  my application exercising hrtimers, network, ...

Now I am trying to run
  cyclictest -l100000000 -m -n -a0 -t1 -i200 -h400
at several priorities. The results after a few minutes are:

prio   avg    max
55     31     74
49     33     1124 (takes tens of seconds to record >1000)
46     33     1190 (nearly immediately >1000)


This is with 3.4.41-rt55 on a 500 MHz Geode LX, so 1 ms is quite
a lot of work.

What is the best approach to find
- which irq generates the occasional spikes
- why the ksoftirqd regularly generates spikes and what
  soft-irq is responsible

These are obviously not 'hard' latencies - a runnable higher prio
thread gets the CPU - so the latency histograms won't show them.

Basically I'd like to trace what happened between a particular
process (not the highest priority one) was woken up until
it got scheduled, and stop if this took longer than some
defined time. Can this be done with the current tracing
infrastructure?

Thanks
-- 
                                       Stano
