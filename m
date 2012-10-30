From: Stanislav Meduna <stano@meduna.org>
Subject: posixcputmr and ksoftirqd priorities
Date: Tue, 30 Oct 2012 09:05:22 +0100
Message-ID: <508F8A42.6040002@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42030 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987Ab2J3IFi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2012 04:05:38 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TT6pD-000248-JT
	for linux-rt-users@vger.kernel.org; Tue, 30 Oct 2012 09:05:35 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

am I right in the suspicion that the events delivered
by timer_create and timerfd_create are routed via ksoftirqd
before being delivered to the application? Is there any
special reason for this?

In any case in the scenario
- posixcputmr prio 99
- thread A prio 45 with a timerfd loop or timer sigwait loop
- thread B prio 25
- ksoftirqd prio 1

the thread A does not see the timer events until thread
B is done, which is a classical priority inversion case.
Boosting the priority of ksoftirqd to 40 solves it.

Yes I have found the Steven's posting with "You can change
the priority of ksoftirqd. In fact, we made the default
for ksoftirqd poor, to force you to change it." Of course
after pulling hair for a few hours and finally identifying
the culprit myself.

Would it be possible to somehow smuggle this important piece
of information into timer_create and timerfd_create manpages?
Otherwise everyone trying to use timers having at least
one thread with lower prio than the thread using them will
fall into it sooner or later. An application programmer
should not have to have an intimate knowledge on how
the events are routed between the kernel tasks...

Regards
-- 
                                         Stano
