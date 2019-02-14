From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Date: Thu, 14 Feb 2019 14:37:14 +0100
Message-ID: <20190214133716.10187-1-juri.lelli@redhat.com>
Cc: linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
To: tglx@linutronix.de, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I've been experimenting with 4.19.15-rt12 and I found out that, while
running cyclictest on isolated CPUs, the following thing, where CPU0 is
one of the housekeeping CPUs and CPU2 is isolated, was happening:

     <idle>-0     [000] ... hrtimer_cancel:       hrtimer=0xffffb4a74be7fe70
     <idle>-0     [000] ... hrtimer_expire_entry: hrtimer=0xffffb4a74be7fe70 now=144805770984 function=hrtimer_wakeup/0x0
     <idle>-0     [000] ... sched_wakeup:         cyclictest:1171 [4] success=1 CPU:002
     <idle>-0     [000] ... hrtimer_expire_exit:  hrtimer=0xffffb4a74be7fe70
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1171 [4]
 cyclictest-1171  [002] ... hrtimer_init:         hrtimer=0xffffb4a74be7fe70 clockid=CLOCK_MONOTONIC mode=0x8
 cyclictest-1171  [002] ... hrtimer_start:        hrtimer=0xffffb4a74be7fe70 function=hrtimer_wakeup/0x0 ...
 cyclictest-1171  [002] ... sched_switch:         cyclictest:1171 [4] S ==> swapper/2:0 [120]

While cyclitest was arming the hrtimer while running on isolated CPU2
(by means of clock_nanosleep), the hrtimer was then firing on CPU0. This
is due to the fact that switch_hrtimer_base(), called at hrtimer enqueue
time, will prefer to enqueue the timer on an housekeeping !idle CPU, if
the timer is not pinned, as it is currently the case.

This looked odd to me, as the problem with this seems to be that we are
measuring wake up latencies across isolated and !isolated domains, which
is against the purpose of configuring the latter.

Since PREEMPT_RT_FULL already forces HARD mode for hrtimers armed by
tasks running with RT policies, it seems to make sense to also force
PINNED mode under the same conditions.

This set implements the behavior, achieving something like the
following:

     <idle>-0     [002] ... hrtimer_cancel:       hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... hrtimer_expire_entry: hrtimer=0xffffafbacc19fe78 now=104335855898 function=hrtimer_wakeup/0x0
     <idle>-0     [002] ... sched_wakeup:         cyclictest:1165 [4] success=1 CPU:002
     <idle>-0     [002] ... hrtimer_expire_exit:  hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1165 [4]
 cyclictest-1165  [002] ... hrtimer_init:         hrtimer=0xffffafbacc19fe78 clockid=CLOCK_MONOTONIC mode=0xa
 cyclictest-1165  [002] ... hrtimer_start:        hrtimer=0xffffafbacc19fe78 function=hrtimer_wakeup/0x0 ...
 cyclictest-1165  [002] ... sched_switch:         cyclictest:1165 [4] S ==> swapper/2:0 [120]

Now, I'm sending this and an RFC, as I'm wondering if the first behavior
is actually what we want, and it is not odd at all for reasons that are
not evident to me at the moment. In this case this posting might also
function as a question: why we need things to work as they are today?

Thanks!

- Juri

Juri Lelli (2):
  time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
  time/hrtimer: Embed hrtimer mode into hrtimer_sleeper

 include/linux/hrtimer.h |  4 ++++
 kernel/time/hrtimer.c   | 13 +++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.17.2
