From: "Cliff Brake" <cliff.brake@gmail.com>
Subject: Re: Priority of serial driver
Date: Mon, 24 Sep 2007 10:50:37 -0400
Message-ID: <f96d234e0709240750h6d96f80ev87da3bfde185b6ff@mail.gmail.com>
References: <f96d234e0709221122g36dab213y41645c159d620c8e@mail.gmail.com>
	 <20070922191522.GA4887@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:43333 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXIXOuj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Sep 2007 10:50:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2040979wah
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Sep 2007 07:50:37 -0700 (PDT)
In-Reply-To: <20070922191522.GA4887@ghostprotocols.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9/22/07, Arnaldo Carvalho de Melo <acme@ghostprotocols.net> wrote:
> Em Sat, Sep 22, 2007 at 02:22:00PM -0400, Cliff Brake escreveu:
> > I have a system where I am doing the following on a PXA270 ARM system:
> >
> > An applications is sending and receiving a packet on a serial port
> > every 40ms.  With 2.6.20, I simply enabled kernel preemption and set
> > the priority of my application to real-time, and it worked great, no
> > matter what the system load.
>
> You didn't made it clear what exactly is the kernel version you are
> using. You mention 2.6.20, but is this with or without the PREEMPT_RT
> patch?

without the PREEMPT_RT patch -- just using the mainline PREEMPT support.

> > With 2.6.23-rc6, I have enabled CONFIG_HIGH_RES_TIMERS &
> > CONFIG_PREEMPT.  Scheduling in the real-time application is rock solid
> > and looking at timing with a scope, and instrumenting the loop in the
> > application indicates the 40ms is very solid.  However, it seems the
> > receive data is getting stuck in the serial driver for relatively long
> > periods of time (>= 40ms), which is a problem in this system.
> >
> > Is there anything that would have changed between 2.6.20 and
> > 2.6.23-rc6 that would explain this?  What priority do pieces of the
> > serial driver run at?  Is there any way to make the serial driver run
> > at high priority so that data is processed in a timely manner?
>
> Look at the IRQ-<N> kernel thread that services the serial port hardware
> interrupt, use chrt to bump its priority and see if it helps.

I don't see any IRQ-<N> processes on my system -- does this require
the RT patch?  Perhaps this is different on ARM/x86?

Thanks,
Cliff

root@compulab-pxa270:~$ ps -A
  PID TTY          TIME CMD
    1 ?        00:00:02 init
    2 ?        00:00:00 kthreadd
    3 ?        00:00:00 ksoftirqd/0
    4 ?        00:00:03 events/0
    5 ?        00:00:00 khelper
   46 ?        00:00:00 kblockd/0
   56 ?        00:00:00 khubd
   59 ?        00:00:00 kseriod
   82 ?        00:00:00 pdflush
   83 ?        00:00:00 pdflush
   84 ?        00:00:00 kswapd0
   85 ?        00:00:00 aio/0
  194 ?        00:00:00 mtdblockd
  240 ?        00:00:00 kpsmoused
  397 ?        00:00:00 udevd
 1221 ?        00:00:00 power
 1238 ?        00:00:15 jffs2_gcd_mtd4
 1271 ?        00:00:00 kmmcd
 1278 ?        00:00:00 pegasus
 1288 ?        00:00:01 mmcqd
 1433 ?        00:00:00 kjournald
 1497 ?        00:00:00 portmap
 1551 ?        00:00:00 dropbear
 1565 ?        00:00:00 dbus-daemon
 1571 ?        00:00:00 syslogd
 1573 ?        00:00:00 klogd
 1582 ?        00:00:00 avahi-daemon
 1630 tty2     00:02:55 Xfbdev
 1633 ttyS0    00:11:23 svs
 1649 tty1     00:00:00 sh
 1668 ttyS0    00:00:00 svs
 1711 ?        00:00:00 udhcpc
 1714 ?        00:00:00 dropbear
 1715 pts/0    00:00:00 sh
 1725 pts/0    00:00:00 ps
root@compulab-pxa270:~$
