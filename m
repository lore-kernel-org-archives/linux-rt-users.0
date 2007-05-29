From: "Alessio Igor Bogani" <abogani@texware.it>
Subject: 2.6.22  - Mission Impossible :-) -
Date: Wed, 30 May 2007 01:34:58 +0200 (CEST)
Message-ID: <1170.213.45.135.240.1180481698.squirrel@www.xcon.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:51037 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbXE2XfB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 May 2007 19:35:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id 8337C6080F3
	for <linux-rt-users@vger.kernel.org>; Wed, 30 May 2007 01:34:59 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UfL9942H7+3p for <linux-rt-users@vger.kernel.org>;
	Wed, 30 May 2007 01:34:59 +0200 (CEST)
Received: from www.xcon.it (afrodite.xcon.it [62.48.35.104])
	by hermes.xcon.it (Postfix) with ESMTP id EF39D6080F0
	for <linux-rt-users@vger.kernel.org>; Wed, 30 May 2007 01:34:58 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I continue with my effort to port last realtime-preempt patch available to
2.6.22.

If i compile without ACPI/hrtimers i don't have any problem (performance
and stability not tested yet).

If i compile with these i have a big problem:

---[ Cutted form kernel/timer.c ]---

void msleep(unsigned int msecs)
{
	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
	while (timeout)
		timeout = schedule_timeout_uninterruptible(timeout);
}

------------------------------------

The while construct never return!

I think that Hrtimer subsystem isn't initialized when msleep called from
do_probe() (ide subsystem).

Someone have suggestions?

Thanks in advance!

Ciao,
Alessio
