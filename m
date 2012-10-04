From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Migrating ksoftirqd? (was: msleep_interruptible() sleeps *way*
 too long on PowerPC)
Date: Wed, 3 Oct 2012 23:34:36 -0500
Message-ID: <CAFQPvXdgg7HA=jZJ1jDSZOT=Jiai=QMf5qK4KOBLgqcvOWLEug@mail.gmail.com>
References: <1349305698.506cc562c087e@webmail.texas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: vomlehn@texas.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52767 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab2JDEeg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Oct 2012 00:34:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so93692pad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Oct 2012 21:34:36 -0700 (PDT)
In-Reply-To: <1349305698.506cc562c087e@webmail.texas.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 3, 2012 at 6:08 PM, <vomlehn@texas.net> wrote:
>
> If I am interpreting the ftrace output correctly, I seem to be having a
> problem with migrating ksoftirqd threads. I've attached a trace below
> but the following line illustrates the issue:
>
> #           TASK-PID    CPU#    TIMESTAMP  FUNCTION
> #              | |       |          |         |
> ...
>      ksoftirqd/1-15    [000]   413.997630: dmvl_debug0 <-run_ksoftirqd
>
> I would expect ksoftirqd/1 to remain on CPU 1. If migration is actually
> happening, I think explains the strange msleep_interruptible() behavior
> I'm seeing--ksoftirqd only runs the timer queue for the processor on which
> it's running, and no ksoftirqd is running on the processor on which the
> timer_list entry was added.
>
> [Note: dmvl_debug0() is a dummy function I inserted at the top of the loop
> in run_ksoftirqd so I could verify with ftrace that it actually got there]
>
> --------------------------------- cut here ------------------------------------
> # tracer: function
> #
> #           TASK-PID    CPU#    TIMESTAMP  FUNCTION
> #              | |       |          |         |
>      ksoftirqd/1-15    [001]   413.985590: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.985596: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.985603: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.985613: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.986585: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.986595: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.986600: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.986613: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.987581: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.987595: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.987596: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.987607: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.988581: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.988594: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.988596: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.988605: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.989581: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.989597: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.989601: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.989603: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.990581: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.990589: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.990594: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.990607: dmvl_debug0 <-run_ksoftirqd
>           rcuc/0-8     [000]   413.990630: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.990642: __do_softirq <-local_bh_enable
>      ksoftirqd/0-3     [000]   413.990650: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.991580: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.991586: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.991592: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.991598: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.992579: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.992593: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.992597: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.992599: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.993579: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.993586: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.993591: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.993604: dmvl_debug0 <-run_ksoftirqd
>           rcuc/0-8     [000]   413.993623: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.993635: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.993644: __do_softirq <-local_bh_enable
>      ksoftirqd/0-3     [000]   413.993652: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.994584: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.994590: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.994593: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.994603: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.995583: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.995589: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.995590: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.995600: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.996582: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.996590: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.996592: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.996598: dmvl_debug0 <-run_ksoftirqd
>           rcuc/0-8     [000]   413.996616: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.996629: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.996639: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.996648: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.996658: __do_softirq <-local_bh_enable
>           rcuc/0-8     [000]   413.996667: __do_softirq <-local_bh_enable
>      ksoftirqd/0-3     [000]   413.996675: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.997584: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.997592: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.997601: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.997603: dmvl_debug0 <-run_ksoftirqd
>           rcuc/1-14    [001]   413.997627: __do_softirq <-local_bh_enable
>      ksoftirqd/1-15    [000]   413.997630: dmvl_debug0 <-run_ksoftirqd
>           rcuc/1-14    [001]   413.997643: __do_softirq <-local_bh_enable
>      ksoftirqd/1-15    [000]   413.997644: dmvl_debug0 <-run_ksoftirqd
>           rcuc/1-14    [001]   413.997655: __do_softirq <-local_bh_enable
>      ksoftirqd/1-15    [000]   413.997657: dmvl_debug0 <-run_ksoftirqd
>           rcuc/1-14    [001]   413.997668: __do_softirq <-local_bh_enable
>      ksoftirqd/1-15    [000]   413.997670: dmvl_debug0 <-run_ksoftirqd
>           rcuc/1-14    [001]   413.997681: __do_softirq <-local_bh_enable
>      ksoftirqd/1-15    [000]   413.997682: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.998596: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.998607: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.998608: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.998616: dmvl_debug0 <-run_ksoftirqd
>      ksoftirqd/0-3     [000]   413.999583: ksoftirqd_do_softirq <-run_ksoftirqd
>      ksoftirqd/1-15    [001]   413.999590: ksoftirqd_do_softirq <-run_ksoftirqd
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Would you mind posting the kernel config file (that might help others
to look at appropriate source code paths)? I see that the per-cpu
"rcuc" thread is running on core-1 between the two time-stamps
413.997603 and 413.998608 (which are the time-stamps before and after
when ksoftirqd/1 ran on core-1 correctly and ran on core-0 between
which). "rcuc" is related to the RCU boost feature. I am wondering
whether it might not be a bad idea to disable CONFIG_RCU_BOOST and see
whether the problem still reproduces (not sure whether it will prove
anything definitely but might give a useful data point?).

Do you use cgroup cpusets? I don't think it is related to that though.

-Sankara
