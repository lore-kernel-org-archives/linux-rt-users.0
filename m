From: Tim Blechmann <tim@klingt.org>
Subject: Re: possible problem with sem_post
Date: Mon, 13 Feb 2012 20:38:12 +0100
Message-ID: <jhbor4$ngh$1@dough.gmane.org>
References: <201202131342.q1DDgG7p001794@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33485 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222Ab2BMTia (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Feb 2012 14:38:30 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Rx1jE-0005ER-IH
	for linux-rt-users@vger.kernel.org; Mon, 13 Feb 2012 20:38:24 +0100
Received: from 85-127-90-215.dynamic.xdsl-line.inode.at ([85.127.90.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2012 20:38:24 +0100
Received: from tim by 85-127-90-215.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2012 20:38:24 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> i am experiencing a strange issue with lockups of my application. have
> multiple high-priority real-time threads (as many threads as there are
> physical cpus) and one of the threads seems to lock inside sem_post(). these
> lookups only occur very rarely, after stressing the application (and the
> semaphore) for a rather long time.
> 
> sem_post seems to call sys_futex with FUTEX_WAKE. this issue only occurred
> recently after installing the 3.0 rt kernel (currently 3.0.20-rt35). but
> haven't seen this behavior on any non-rt kernel (currently running another
> stress-test). the machine is a thinkpad t410, x86_64.
> 
> if this is a problem of the rt-kernel, is there any way to debug it? or is it
> in general unsafe to call sem_post from real-time threads?

ok, i ran the same test on a stock ubuntu kernel for a few hours without any 
problem.

the situation: 2 cpus, 2 high-priority SCHED_FIFO threads. several low-priority 
threads, one of them waiting for a semaphore, that is posted by the rt threads. 
my guess is that the low-priority thread acquires a spinlock but then gets 
preempted, but the high-priority thread waits for this spinlock ... is this 
possible?

thanks, tim


