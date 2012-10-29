From: Stanislav Meduna <stano@meduna.org>
Subject: Priority inheritance?
Date: Mon, 29 Oct 2012 14:00:34 +0100
Message-ID: <508E7DF2.1040301@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:47837 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab2J2NAw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Oct 2012 09:00:52 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TSoxL-0001il-88
	for linux-rt-users@vger.kernel.org; Mon, 29 Oct 2012 14:00:47 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

strictly speaking not a linux-rt specific questions but I think
that the folks here have the needed experience and knowledge:
what is the relation of
  pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
and scheduler class used for a particular thread? Does the priority
inheritance work across all threads in the system or is it limited
to one scheduling class?

Specifically: my application has some SCHED_RR threads with fixed
priorities and realtime needs and a few that are quite low-prio,
actually have the SCHED_OTHER semantics and I don't want them
to count against the time spent in RT (keyword: throttler).

I need to occasionally queue data from from the RT-ones to
the low-prio ones, so for short periods of time I need to lock
a mutex. With it comes the question of priority inversion.

Can I leave the low-prio threads at SCHED_OTHER and rely on
the PTHREAD_PRIO_INHERIT to boost their priority in case they
were preempted with the lock held and the RT-thread needs
to lock it too, or do they have to be SCHED_RR too?

Thanks
-- 
                                    Stano
