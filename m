Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISMXA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Sep 2018 08:23:00 -0400
Date: Wed, 19 Sep 2018 08:46:19 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
Message-ID: <20180919064619.soi27bbq3xtatpxp@pengutronix.de>
References: <73d0tbdjqz.fsf@pengutronix.de>
 <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-rt-users@vger.kernel.org

On Tue, Sep 18, 2018 at 06:46:15AM -0700, Guenter Roeck wrote:
> On 09/18/2018 06:21 AM, Steffen Trumtrar wrote:
> > 
> > Hi all!
> > 
> > I'm seeing an issue with the dw_wdt watchdog on the SoCFPGA ARM platform with the latest linux-rt v4.18.5-rt4. Actually I seem to have the same problem, that these patches try to fix:
> > 
> >   38a1222ae4f364d5bd5221fe305dbb0889f45d15
> >   Author:     Christophe Leroy <christophe.leroy@c-s.fr>
> >   AuthorDate: Fri Dec 8 11:18:35 2017 +0100
> >   Commit:     Wim Van Sebroeck <wim@iguana.be>
> >   CommitDate: Thu Dec 28 20:45:57 2017 +0100
> > 
> >   Follows:    v4.15-rc3 (345)
> >   Precedes:   v4.16-rc1 (13997)
> > 
> >   watchdog: core: make sure the watchdog worker always works
> > 
> >   When running a command like 'chrt -f 50 dd if=/dev/zero  of=/dev/null',
> >   the watchdog_worker fails to service the HW watchdog and the
> >   HW watchdog fires long before the watchdog soft timeout.
> > 
> >   At the moment, the watchdog_worker is invoked as a delayed work.
> >   Delayed works are handled by non realtime kernel threads. The
> >   WQ_HIGHPRI flag only increases the niceness of that threads.
> > 
> >   This patch replaces the delayed work logic by kthread delayed  work,
> >   and sets the associated kernel task to SCHED_FIFO with the  highest
> >   priority, in order to ensure that the watchdog worker will run  as
> >   soon as possible.
> > 
> > 
> >   1ff688209e2ed23f699269b9733993e2ce123fd2
> >   Author:     Christophe Leroy <christophe.leroy@c-s.fr>
> >   AuthorDate: Thu Jan 18 12:11:21 2018 +0100
> >   Commit:     Wim Van Sebroeck <wim@iguana.be>
> >   CommitDate: Sun Jan 21 12:44:59 2018 +0100
> > 
> >   Follows:    v4.15-rc3 (349)
> >   Precedes:   v4.16-rc1 (13993)
> > 
> >   watchdog: core: make sure the watchdog_worker is not deferred
> > 
> >   commit 4cd13c21b207e ("softirq: Let ksoftirqd do its job") has  the
> >   effect of deferring timer handling in case of high CPU load,  hence
> >   delaying the delayed work allthought the worker is running which
> >   high realtime priority.
> > 
> >   As hrtimers are not managed by softirqs, this patch replaces the
> >   delayed work by a plain work and uses an hrtimer to schedule  that work.
> > 
> > 
> > If I run the same test or 'chrt 50 hackbench 20 -l 150' or any task where I change the prio with chrt and that runs long enough, I get a system reset from the watchdog because it times out. This only happens if the watchdog is already enabled on boot and CONFIG_PREEMPT_RT_FULL is set.
> > 
> > Any idea if I'm missing something essential? If I understand it correctly, the two commits fix the framework and therefore the dw_wdt driver doesn't need any updates.
> > 
> 
> I find your e-mail confusing, sorry. The subject says that the watchdog is not
> triggering, the description says that it is triggering when it should not.
> 

Sorry. Let me try again.
The problem I observe, is that the watchdog is trigged, because it doesn't get pinged.
The ksoftirqd seems to be blocked although it runs at a much higher priority than the
blocking userspace task.

> You also provide no information if the watchdog is active (open from user space)
> or not. There is some indication in "This only happens if the watchdog is already
> enabled on boot" but that isn't really precise - it may be enabled on boot but still
> open. On top of that, your e-mail suggests that the problem may be a regression,
> since you refer to a specific kernel release, yet you provide no information if
> the very same test worked with a different kernel version, or what that kernel
> version would be.
> 
> Please not only describe what you are doing, but also provide the complete context.
> Specifically,
> - Did this ever work ? If yes, what are working kernel versions ?

I don't know, if it ever worked or not. This is the first kernel version I tried.
According to the two commits mentioned, I assume that it won't work in older versions.

> - Is the watchdog device open ?
> - Does it make a difference if it is ?

In my test case, the device is not open. It gets started by the bootloader and than is
running. I tried opening the device after it was already running, but it does not make
a difference. If the watchdog is put into running state by opening it from userspace,
the bug does not occur. If the bootloader starts it and the kernel just continues pinging
the watchdog, it does occur, open or not.

> - What is the configured watchdog timeout (both from BIOS/ROMMON and in Linux) ?

The watchdog is configured to a timeout of 5 seconds, both in bootloader and kernel.
The dw_wdt driver will round it to the nearest value it supports. Higher values do not make
the bug go away.


Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
