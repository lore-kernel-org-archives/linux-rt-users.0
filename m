From: GeHao Kang <kanghao0928@gmail.com>
Subject: PREEMPT_RT with Full Tickless
Date: Fri, 11 Dec 2015 19:29:12 +0800
Message-ID: <CANv7uPSimVG=GfQ5W_HDq0UYUokK-Y2WvSPTXc3MFd7eLXqYVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: tglx@linutronix.de, peterz@infradead.org, jason.low2@hp.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33671 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbbLKL3M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 06:29:12 -0500
Received: by igbf6 with SMTP id f6so4801422igb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 03:29:12 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas, Peter, and Jason,

When I enable CONFIG_PREEMPT_RT_FULL and CONFIG_NO_HZ_FULL
in Linux Kernel v4.1.12-rt12, I find the tick on the nohz_full cpu never stops.

Whenever the nohz_full cpu wants to stop its tick, it would use
get_next_timer_interrupt() to get the time of next timer and check
whether this time  is more than one jiffy after current time.
However, get_next_timer_interrupt() always returns now+1 in PREEMPT_RT
and this cpu has no chance of stopping its tick.  Please reference
kernel/time/timer.c: get_next_timer_interrupt().

#ifdef CONFIG_PREEMPT_RT_FULL
        /*
         * On PREEMPT_RT we cannot sleep here. As a result we can't take
         * the base lock to check when the next timer is pending and so
         * we assume the next jiffy.
         */
        return now + 1;
#endif

Does this mean it is a restriction on the current development of PREEMPT_RT?

Thanks,
- Kang
