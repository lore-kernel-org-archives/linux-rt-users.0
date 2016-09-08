From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Undesirable priority inversion for real-time threads that use
 timerfd
Date: Thu, 8 Sep 2016 12:24:08 +0200
Message-ID: <20160908102408.n4cc2e6vjslyprgm@linutronix.de>
References: <e1363850-537a-f6d1-52c7-3e7398374b49@netacquire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Joachim Achtzehnter <joachima@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941089AbcIHKYK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Sep 2016 06:24:10 -0400
Content-Disposition: inline
In-Reply-To: <e1363850-537a-f6d1-52c7-3e7398374b49@netacquire.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-02 17:25:55 [-0700], Joachim Achtzehnter wrote:
> The only downside of this fix is that all timeouts used by low-priority
> threads, presumably even non-real-time threads, will briefly preempt our
> high-priority threads, although hopefully not for long, hence there may be
> some impact on throughput.

_all_ timers which are not marked as irq_safe are deferred here to the
timersoftirq. This is because they take (possible long standing)
sleeping locks.

> A possibly more optimal approach would be to have a separate ktimersoftd
> thread for every priority at which threads wait for timer notifications. We
you don't know this in advance. You are in hardirq context and a hrtimer
expires. You invoke the timerfd callback, need to take a sleeping lock
to figure out who is waiting on this. *That* is the point you learn
about the waiter.

> could potentially build such a facility in user code, as long as there is
> some timer available that is not dependent on ktimersoftd. What about Posix
> timers? Would they have the same issue? Anything else we should be looking
> at?

posix timers have the same issue. Basically all timers which are not
marked as irq_safe are completed in ktimersoftd. If you look at
clock_nanosleep() you will see that it is marked as irqsafe and the wake
up happens in hardirq.

Btw: the situation got better once we got ktimersoftd. Before that it
was a little worse.

> Thanks,
> 
> Joachim

Sebastian
