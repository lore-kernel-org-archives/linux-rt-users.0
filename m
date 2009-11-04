From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 23:41:18 +0100
Message-ID: <20091104224118.GA3561@opentech.at>
References: <hcs6dr$235$1@ger.gmane.org> <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com> <4AF1A327.3040103@klingt.org> <20091104171412.GB1702@opentech.at> <4AF1BAB9.5080104@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Knecht <markknecht@gmail.com>, linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:53851 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757303AbZKDWlO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 17:41:14 -0500
Content-Disposition: inline
In-Reply-To: <4AF1BAB9.5080104@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 04 Nov 2009, Tim Blechmann wrote:

> >> well, if i understand the rt howto correctly, _no_ disc access is
> >> allowed, neither from rt nor from non-rt threads, since it may produce
> >> page faults, which introduce latencies ...
> > 
> > I would be supprised if the rt howto states that page-faults in non-rt
> > threads is a critical problem - that would not significantly impact RT
> > performance - atelast not the worst case - it will (as every other system
> > load) impact the average case. so having a non-rt thread reading disk-files
> > to a buffer and a rt-thread processing this buffer should be perfectly fine.
> 
> that is what i thought for years ... but according to [1] a page fault
> in an rt process freezes the entire process with both rt and non-rt
> threads until the page fault is handled ...
>
I proved to my self only a few days ago that I know nothing about RT_Preempt
so at the risk that this is completly wrong - for a simple test I added a
reader/writer thread in cyclictest.

with SCHED_OTHER or priority below 50 with SCHED_FIFO the impact is as expected
with priority above 50 (left all the irq-threads at there usual default) I see 
no impact at all in the worst case (average - as can be expected goes up a bit
compared to an idle system).

here are the results of a short run - the effect pops up imediately for SCHED_OTHER or -p 48, the -p 99 run is about 15 minutes.

/* SCHED_OTHER */
rtl26:~/rt/rt-tests# ./cyclictest -n
0.71 0.27 0.16 1/128 6907

T: 0 ( 6906) P: 0 I:1000 C:   9383 Min:      2 Act:   52 Avg:  315 Max:   73704

/* priority below any I/O activity in the kernel */
rtl26:~/rt/rt-tests# ./cyclictest -n -p 48
0.44 0.25 0.16 1/128 6911

T: 0 ( 6910) P:48 I:1000 C:   8610 Min:      1 Act:    2 Avg:  322 Max:   73607

/* priority above any I/O activity in the kernel */

rtl26:~/rt/rt-tests.mod# ./cyclictest -n -p 99
1.60 1.59 1.23 1/128 7314

T: 0 ( 7079) P:99 I:1000 C:1067096 Min:      1 Act:    2 Avg:    2 Max:      31


The thread added simply opens a large file (linux-2.6.31.tar.bz2, 62MB), reading 1k at a time, and writing it to a file in /tmp in an while(1) loop - the thread runs with default attr thus PTHREAD_SCOPE_SYSTEM as SCHED_OTHER thread. so maybe someone with more insight could comment on this "good" result.

HW: UP AMD Sempron 1.6GHz, NN IDE disk, 256MB RAM
SW: Debian 5.0.3 (Default Desktop) kernel 2.6.31.4-rt14 

thx!
hofrat
