Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44215 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeIRSxr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Sep 2018 14:53:47 -0400
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
Date: Tue, 18 Sep 2018 15:21:08 +0200
Message-ID: <73d0tbdjqz.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-rt-users@vger.kernel.org


Hi all!

I'm seeing an issue with the dw_wdt watchdog on the SoCFPGA ARM 
platform with the latest linux-rt v4.18.5-rt4. Actually I seem to 
have the same problem, that these patches try to fix:

  38a1222ae4f364d5bd5221fe305dbb0889f45d15
  Author:     Christophe Leroy <christophe.leroy@c-s.fr>
  AuthorDate: Fri Dec 8 11:18:35 2017 +0100
  Commit:     Wim Van Sebroeck <wim@iguana.be>
  CommitDate: Thu Dec 28 20:45:57 2017 +0100

  Follows:    v4.15-rc3 (345)
  Precedes:   v4.16-rc1 (13997)

  watchdog: core: make sure the watchdog worker always works

  When running a command like 'chrt -f 50 dd if=/dev/zero 
  of=/dev/null',
  the watchdog_worker fails to service the HW watchdog and the
  HW watchdog fires long before the watchdog soft timeout.

  At the moment, the watchdog_worker is invoked as a delayed work.
  Delayed works are handled by non realtime kernel threads. The
  WQ_HIGHPRI flag only increases the niceness of that threads.

  This patch replaces the delayed work logic by kthread delayed 
  work,
  and sets the associated kernel task to SCHED_FIFO with the 
  highest
  priority, in order to ensure that the watchdog worker will run 
  as
  soon as possible.


  1ff688209e2ed23f699269b9733993e2ce123fd2
  Author:     Christophe Leroy <christophe.leroy@c-s.fr>
  AuthorDate: Thu Jan 18 12:11:21 2018 +0100
  Commit:     Wim Van Sebroeck <wim@iguana.be>
  CommitDate: Sun Jan 21 12:44:59 2018 +0100

  Follows:    v4.15-rc3 (349)
  Precedes:   v4.16-rc1 (13993)

  watchdog: core: make sure the watchdog_worker is not deferred

  commit 4cd13c21b207e ("softirq: Let ksoftirqd do its job") has 
  the
  effect of deferring timer handling in case of high CPU load, 
  hence
  delaying the delayed work allthought the worker is running which
  high realtime priority.

  As hrtimers are not managed by softirqs, this patch replaces the
  delayed work by a plain work and uses an hrtimer to schedule 
  that work.


If I run the same test or 'chrt 50 hackbench 20 -l 150' or any 
task where I change the prio with chrt and that runs long enough, 
I get a system reset from the watchdog because it times out. This 
only happens if the watchdog is already enabled on boot and 
CONFIG_PREEMPT_RT_FULL is set.

Any idea if I'm missing something essential? If I understand it 
correctly, the two commits fix the framework and therefore the 
dw_wdt driver doesn't need any updates.


Best regards,
Steffen

--
Pengutronix e.K.                          | Steffen Trumtrar 
|
Industrial Linux Solutions                | 
http://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany| Phone: 
+49-5121-206917-0   |
Amtsgericht Hildesheim, HRA 2686          | Fax: 
+49-5121-206917-5555|
