Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:34177 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeJCWkS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Oct 2018 18:40:18 -0400
Date: Wed, 3 Oct 2018 17:51:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Bug or works as intended: signal behaviour on -RT
In-Reply-To: <d5b58969-26d3-d32b-71f7-fdd437c06ee1@oth-regensburg.de>
Message-ID: <alpine.DEB.2.21.1810031748250.26169@nanos.tec.linutronix.de>
References: <d5b58969-26d3-d32b-71f7-fdd437c06ee1@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On Wed, 26 Sep 2018, Ralf Ramsauer wrote:

> Hi,
> 
> If I set the SCHED_FIFO schedular, register a SIGALRM handler, set an
> alarm() and consume 100% of CPU time on an isolated CPU (IOW, never
> leave running/runable), the signal will never arrive in userspace.
> According to /proc/timer_list the expiration time will become a negative
> value.
> 
> But if I synchronously send a SIGALRM via kill, it will immediately
> arrive. Even a sched_yield() in the busy loop won't help. In order to
> get the signal, I have to leave running/runable with usleep().
> 
> Now I'm not sure if this behaviour is intended for some reason or if
> it's a bug. Please find a minimal example attached. Run it on an
> isolated CPU with taskset.
> 
> Reproduceable with 4.14.x-rt and latest -rt. Not reproducable with
> mainline Linux and PREEMPT.

The problem is that the alarm timer is delivered in softirq
context. Assuming that your task loops with higher priority than the
softirq thread it will simply starve it and the timer is never expired and
therefore no siganl delivered. Not pretty, but nothing we can do about
right now with the way signal based timers work. There are ideas to
implement that differently, but that's more complex than it seems in the
first place.

Thanks,

	tglx
