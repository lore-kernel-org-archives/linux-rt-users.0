From: Mike Galbraith <mgalbraith@suse.de>
Subject: jitter test scalability problem - my theory
Date: Fri, 29 Jul 2011 16:31:09 +0200
Message-ID: <1311949869.30862.45.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39321 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1G2ObM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 10:31:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

2.6.33.15-rt31 on a 64 core DL980, running a jitter test proggy that
fires up an executive (a model thereof actually) on 56 isolated cores,
which in turn fires up 3 or 4 workers in descending priority.  All tasks
are pinned. Box booted isolcpus=8-63.  Jitter test runs on these, 0-7
handle everything else, including interrupts.

Test proggy is looking to achieve a max jitter of +-30us, and that goal
is met.. until I increase the load to > 32 isolated cores.

Profiling, my kernel overhead is mostly (surprise) locks, but it seems
my scalability issue may be coming from...

static void 
inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
{
...
                if (rq->online)
                        cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
      
void cpupri_set(struct cpupri *cp, int cpu, int newpri)
{
... 
        if (likely(newpri != CPUPRI_INVALID)) {
                struct cpupri_vec *vec = &cp->pri_to_cpu[newpri];

                raw_spin_lock_irqsave(&vec->lock, flags);  <== here

So it seems push/pull logic _may_ be my scalability problem.  Even
though there's nothing that can be pushed/pulled, it's hammering a few
locks from many cores, so cores perturb each other enough despite
isolation, to fail once enough cores are active.

Does that look like a reasonable explanation for my jitter increase?

I'm going to hack up a test for my wild theory, but since I don't have a
lot of experience hunting jitter sources, looking for a few lousy usecs,
it couldn't hurt to ask whether I'm barking up the wrong tree or not :)


(in previous run,  _raw_spin_lock_irqsave() was > 60% of kernel
overhead, this is just the last run I did)

# dso: [kernel.kallsyms]
# Events: 214K cycles
#
# Overhead                               Symbol
# ........  ...................................
#
    29.53%  [k] _raw_spin_lock_irqsave
            |
            |--61.57%-- cpupri_set
            |          |
            |          |--81.55%-- dequeue_rt_stack
            |          |          dequeue_task_rt
            |          |          dequeue_task
            |          |          |
            |          |          |--100.00%-- deactivate_task
            |          |          |          __schedule
            |          |          |          schedule
            |          |          |          |
            |          |          |          |--69.94%-- run_ksoftirqd
            |          |          |          |          kthread
            |          |          |          |          kernel_thread_helper
            |          |          |          |
            |          |          |          |--15.23%-- sys_semtimedop
            |          |          |          |          sys_semop
            |          |          |          |          system_call_fastpath
            |          |          |          |          |
            |          |          |          |          |--4.11%-- 0x7f54c025ae37
            |          |          |          |          |          __semop


