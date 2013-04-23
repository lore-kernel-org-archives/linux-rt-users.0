From: Mike Galbraith <bitbucket@online.de>
Subject: rtmutex implementation question
Date: Tue, 23 Apr 2013 09:47:47 +0200
Message-ID: <1366703267.4731.109.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54718 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab3DWHru (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Apr 2013 03:47:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

What is it that prevents unbound latencies for all tasks queued behind
a task that blocks on an rt spinlock, with a compute task from hell
queued behind it at the same priority?

The lock is not stealable for tasks of the same priority, so it seems as
though queueing the sleeper to queue tail upon wakeup (lock released,
sleeper is now top waiter) must result in the unlocked lock remaining
unavailable to all other tasks of the same priority who blocked on the
lock after the sleeper, who won't get the CPU back to claim the lock
until, say SCHED_FIFO while(1) releases the CPU.

Far too ungood to be true, so I bet a nickle I'm missing something.  

Anybody in need of a virtual nickle?  Just point me to the "well duh"
spot in the source, and it's all yours ;-)

-Mike

