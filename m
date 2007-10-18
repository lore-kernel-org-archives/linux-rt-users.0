From: Gernot Hillier <gernot.hillier@siemens.com>
Subject: thread load balancing on dual CPU Multicore AMD64 system
Date: Thu, 18 Oct 2007 19:01:36 +0200
Message-ID: <47179170.7030802@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:17499 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758288AbXJRRSr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 13:18:47 -0400
Received: from mail1.siemens.de (localhost [127.0.0.1])
	by david.siemens.de (8.12.6/8.12.6) with ESMTP id l9IH1aQ4010301
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 19:01:36 +0200
Received: from [192.168.2.1] ([139.22.111.67])
	by mail1.siemens.de (8.12.6/8.12.6) with ESMTP id l9IH1ZTb007641
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 19:01:35 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi!

We're currently evaluating whether PREEMPT_RT will work for a certain
use case combining realtime and performance requirements running on a
lot of CPUs and using a bunch of RAM.

For first tests, we're running a "small" AMD64 test system with 2x2
cores (2 CPUs with 2 cores each) with 8 GB of RAM.

We wrote a small testcase which basically has one SCHED_FIFO "realtime"
thread which does nothing but sleeping and checking if it wakes up at
the right time. In addition, it spawns 20 low-prio "load threads"
introducing a lot of malloc/memory access/free load on some GB of RAM.

We can see, that the realtime requirements are fulfilled quite well (if
using the current glibc with private futexes, but that's another story).
The "rt thread" reacts within the expected timeframe with 2.6.22.1-rt9
as well as with 2.6.23-rt1.

However, what causes problems is the load balancing of the 20 threads
over the available CPU cores:

- With 2.6.22.1-vanilla, the threads are distributed over all four
available cores
- With 2.6.22.1-rt9 (patched, but PREEMPT_RT & friends *disabled*), the
threads are distributed *only over two cores*, the others are idling
- With 2.6.22.1-rt9 (PREEMPT_RT & friends enabled), the threads are
distributed *only over two cores*, the others are idling

- With 2.6.23-rt1 (patched, but PREEMPT_RT & friends *disabled*), the
threads are distributed over all four cores
- With 2.6.23-rt1 (PREEMPT_RT & friends enabled), the threads are
distributed *only over two cores*, the others are idling

We have not set any CPU affinities in any case.

With the 2.6.22 series, I played a bit with
patch-2.6.22.1-rt9-broken-out.tar.bz2 and am quite sure that the
behaviour change is introduced by preempt-softirqs-core.patch. If I
apply anything up to and including this patch (according to the series
file), I see that only two cores are used. If I just remove this sole
patch, all four cores are used again.

Any ideas what causes these issues? Is this somehow connected to NUMA
optimizations or just a bug? Known one?

Any idea or suggestions welcome...

TIA!

----
With kind regards,
Gernot Hillier
Siemens AG, CT SE 2
Corporate Competence Center Embedded Linux
