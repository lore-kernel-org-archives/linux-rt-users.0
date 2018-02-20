Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:33784 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeBTThB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Feb 2018 14:37:01 -0500
Date: Tue, 20 Feb 2018 20:36:59 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: problems with 4.14.6-rt7
Message-ID: <20180220193659.atxryabt6tmn7di5@linutronix.de>
References: <2644174.vLadu3AOG5@dabox>
 <20180124141849.hsikgyqgymbd2qe5@linutronix.de>
 <2627538.QZmOYvPzcF@dabox>
 <20180220184806.ytte4af5uhfpytlm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180220184806.ytte4af5uhfpytlm@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de

On 2018-02-20 19:48:06 [+0100], To Tim Sander wrote:
> On 2018-01-26 17:01:09 [+0100], Tim Sander wrote:
> > Hi Sebastian
Hi Tim,

> > I just double checked with your 4.14.15-rt12 release. I have not seen
> > any throtteling messages? (the double "cut here" line is no copy error of mine, but
> > verbatim kernel output)
> > 
> > Here is the dmesg output of a testrun:
> > 
> > BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 56s!
> > Showing busy workqueues and worker pools:
> > workqueue mm_percpu_wq: flags=0x8
> >   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
> >     pending: vmstat_update
> 
> I don't see all of this but I don't see the lockdep detector unless I
> boot UP. This bothers me little, let me look why…

As I just learned (or have been told): RT_RUNTIME_SHARE on SMP disables
the RT throttling if a RT thread went mad. This can be undone via
/sys/kernel/debug/sched_features.

Without throttling, the workqueue code never gets on the CPU and
complains that it is stuck. With throttling it wouldn't happen. However
throttling kills everything in the RT class which means it won't process
threaded interrupts so an UP system remains "dead" (since you can't
access via network/serial, most timer won't expires, …). The benefit is
limited.

Sebastian
