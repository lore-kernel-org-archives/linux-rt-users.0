From: notgeorge burns <not.george.burns@gmail.com>
Subject: entry_32.S ret_from_intr and invocation of scheduler, v3.2-rt
Date: Fri, 15 Mar 2013 15:16:51 +0000
Message-ID: <CAO2z5Zi52q94xfmqRDwq5XSgD-VaVitnJ_JNnEpGOr9Spi4cWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f195.google.com ([209.85.128.195]:33933 "EHLO
	mail-ve0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab3COPdy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Mar 2013 11:33:54 -0400
Received: by mail-ve0-f195.google.com with SMTP id m1so581483ves.10
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Mar 2013 08:33:53 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

In branch v3.2-rt, in entry_32.S, ret_from_intr, lines 347-351, it
appears to be the case that a hard irq request can return to a
userspace task without invoking the scheduler.

What if the hardirq handler scheduled something higher priority than
the userspace task that was interrupted?  For example, suppose you
have the following scenario:

1) process A running at priority 60 in userspace.

2) hard interrupt fires, resulting in entry_32.S common_interrupt processing.

3) hard interrupt handler schedules task B via irq_wake_thread() in
kernel/irq/handle.c, i.e. wake_up_process().

4) Task B is of course the softirq for the interrupt.

5) The process/task B to be woken up has priority 70.

6) Hard interrupt handler continues to ret_from_intr to prepare for
whatever is next.

7) What is the intended behavior at line 350 of entry_32.S on branch
3.2-rt?  I.e. should we jump to work_pending, heading towards the
scheduler, or instead pass through to restore_all and return back to
process A?

Does the hardirq handler need to do something to make the TI_flags
work properly against _TIF_WORK_MASK ?   _TIF_WORK_MASK doesn't
include TIF_NEED_RESCHED so it seems that this wouldn't be the right
way to do it?

Does the hardirq handler need to do something else to cause control to
move to the higher priority softirq instead of returning to the lower
priority process?


Thank you for any clarification you can provide.
-burns
