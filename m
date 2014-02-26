From: doug lkml <doug.lkml@gmail.com>
Subject: Query about might_sleep()
Date: Wed, 26 Feb 2014 12:25:53 +0530
Message-ID: <CALY8T6p-=jxix2Hr+HTHitcutzn33ETV2zFtStPkWttca5o9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f193.google.com ([209.85.128.193]:41711 "EHLO
	mail-ve0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaBZGz4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Feb 2014 01:55:56 -0500
Received: by mail-ve0-f193.google.com with SMTP id oy12so449567veb.0
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2014 22:55:56 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

   I am relatively new to RT. I have a query w.r.t might_sleep. I
might be asking on the wrong mailing list(perhaps I should try kernel
newbies).

   AFAIU, might_sleep() in a function means, the function can sleep.
If this function is called in atomic/interrupt context the kernel
throws out
 BUG: sleeping function called from invalid context at kernel/rtmu
tex.c. Am I correct so far?

   I was browsing the source, in rtmutex.c, in function rt_spin_lock(), which
calls rt_spin_lock_fastlock, there's a might_sleep() that's getting
called. I understand this is possible as spin_locks in PREEMPT_RT are
mutexes. But there could be a condition where this could be called
from some code holding spin_lock right?

for example

 __might_sleep
 rt_spin_lock
some_fucnction() --> which has a
local_irq_save(flags)/local_irq_irqrestore(flags).

This could be a potential bug right?

- Doug
