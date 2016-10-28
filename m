From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.4.23-rt33: High latencies when settings RCU_KTHREAD_PRIO equal
 or higher than rt application priority
Date: Fri, 28 Oct 2016 16:55:46 +0200
Message-ID: <20161028145546.xrgmof44ndn7gljb@linutronix.de>
References: <CALqGcGopV+Za7ahfBqneXbfBPPo8GdtqNt0VppsF-5aYpmmW-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbcJ1Peo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Oct 2016 11:34:44 -0400
Content-Disposition: inline
In-Reply-To: <CALqGcGopV+Za7ahfBqneXbfBPPo8GdtqNt0VppsF-5aYpmmW-g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-19 10:55:11 [+0200], Christoph Mathys wrote:
> I changed RCU_KTHREAD_PRIO to 99 from the default setting of 1. I now
> observe cyclictest latencies of above 100us (16ms was the worst so
> far). Before the change the systems max latency is below 30us. The
> problem shows up when cyclictest has an equal or lower priority than
> the RCU threads. RCU boosting is enabled (default).

Ehm. It is not yet April. So you give another thread / application (the
RCU thread in this case) a higher priority than cyclictest and now you
complain about high latencies of cyclictest because the other thread
runs? I would say it works as expected / configured.

> I don't see that behaviour on 3.12 with RCU_BOOST_PRIO=99. I could
> reproduce the behaviour on a Intel i7 and an Intel Celeron Dualcore.
> On i7 it usually happens within a couple of minutes.

It should lead to the same behaviour on v3.12 as well. It is possible
that the later kernel has more RCU users which trigger the thread to run
longer.

Sebastian
