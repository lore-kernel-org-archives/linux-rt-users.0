From: Raz <raziebe@gmail.com>
Subject: preempt-rt: Real Time hogging task
Date: Thu, 2 Feb 2012 12:52:46 +0200
Message-ID: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44941 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab2BBKxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 05:53:07 -0500
Received: by bkcjm19 with SMTP id jm19so1915595bkc.19
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Feb 2012 02:53:06 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hey

I am trying to understand why a user space MT process behaves in an
unexpected manner.
I have real time process, which executes most of its threads in RT prio=
rity,
and from time to time a task ( medium priority ) is executing without
trying to stop.

There are times, that this task is hogging the entire process and no
other **higher*** rt priority
task is getting any cpu time.

Linux is **not** getting hogged. when setting the serial console (
irq/serial ) and its shell ( /bin/sh )
to a higher priority linux is responsive.

Observing the task list=A0 through ps command i can see that this task'=
s
threads when
to un-interruptible sleep.

Any idea why is it happening ?
kernel is 3.2.0-rc5-rt8.
raz
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
