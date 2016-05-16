From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Mon, 16 May 2016 14:05:54 -0700
Message-ID: <CAGt3f4m=+yimx-wxDjH9TCzAb5F6zUbxG_RAEhTrT4cZWFKKcg@mail.gmail.com>
References: <1462903464-11448-1-git-send-email-brian@peloton-tech.com> <20160512085946.GB19035@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35414 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbcEPVGZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 May 2016 17:06:25 -0400
Received: by mail-vk0-f53.google.com with SMTP id f66so229119105vkh.2
        for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2016 14:06:24 -0700 (PDT)
In-Reply-To: <20160512085946.GB19035@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 12, 2016 at 1:59 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Brian Silverman | 2016-05-10 14:04:24 [-0400]:
>
>>Without this, a realtime process which has called mlockall exiting
>>causes large latencies for other realtime processes at the same or
>>lower priorities. This seems like a fairly common use case too, because
>>realtime processes generally want their memory locked into RAM.
>
> Can please explain more detailed what exactly causes the high latencies?
>

It happens when realtime (SCHED_RR/SCHED_FIFO) processes which have
called mlockall(MCL_CURRENT | MCL_FUTURE) exit.

I can easily reproduce the problem on both an ARM machine with
4.1.18-rt17 and a Intel i7 with 3.14.43-rt42. `cyclictest -p 10 -m -t
-a -i 2000 -n` on both machines for a few minutes gives a <150us max
latency. However, when a program at SCHED_RR 10 which has been pinned
to a single core and called mlockall exits, that goes up to about 11ms
on the ARM machine and around 3ms on the i7. Not pinning also gives
larger latencies, but they aren't as consistent.

Using ftrace reveals that most of this time is being spent in exit_mm.
There are a couple of loops that take a long time, and if the process
is running at realtime priority other processes at the same priority
never get a chance to run. Here's single cycles of the longer loops
from ftrace on the 4.1.18-rt17 box:

One of them:
 queue_cyclictes-5298  [000] ....1..   290.366030: remove_vma <-exit_mmap
 queue_cyclictes-5298  [000] ....1..   290.366032: __might_sleep <-remove_vma
 queue_cyclictes-5298  [000] ....1..   290.366033: ___might_sleep
<-__might_sleep
 queue_cyclictes-5298  [000] ....1..   290.366035: kmem_cache_free <-remove_vma
 queue_cyclictes-5298  [000] ....1..   290.366036: preempt_count_add
<-kmem_cache_free
 queue_cyclictes-5298  [000] ....2..   290.366037: preempt_count_sub
<-kmem_cache_free
 queue_cyclictes-5298  [000] ....1..   290.366039: __slab_free <-kmem_cache_free
 queue_cyclictes-5298  [000] d...1..   290.366040: preempt_count_add
<-__slab_free
 queue_cyclictes-5298  [000] d...2..   290.366041: preempt_count_sub
<-__slab_free
 queue_cyclictes-5298  [000] ....1..   290.366043: kmem_cache_free:
call_site=c0147054 ptr=ebb93cb8

Another one:
 queue_cyclictes-5298  [000] ....1..   290.364272: free_hot_cold_page
<-free_hot_cold_page_list
 queue_cyclictes-5298  [000] ....1..   290.364273: free_pages_prepare
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....1..   290.364274: mm_page_free:
page=ef056f20 pfn=667513 order=0
 queue_cyclictes-5298  [000] ....1..   290.364275: page_address
<-free_pages_prepare
 queue_cyclictes-5298  [000] ....1..   290.364277: page_address
<-free_pages_prepare
 queue_cyclictes-5298  [000] ....1..   290.364278:
get_pfnblock_flags_mask <-free_hot_cold_page
 queue_cyclictes-5298  [000] ....1..   290.364279: migrate_disable
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....1..   290.364280: preempt_count_add
<-migrate_disable
 queue_cyclictes-5298  [000] ....21.   290.364281: pin_current_cpu
<-migrate_disable
 queue_cyclictes-5298  [000] ....211   290.364283: preempt_count_sub
<-migrate_disable
 queue_cyclictes-5298  [000] ....111   290.364284: migrate_disable
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....112   290.364286: rt_spin_lock
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....112   290.364287: ___might_sleep <-rt_spin_lock
 queue_cyclictes-5298  [000] ....112   290.364288: preempt_count_add
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....212   290.364289: preempt_count_sub
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....112   290.364291: rt_spin_unlock
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....112   290.364292: migrate_enable
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....111   290.364293: migrate_enable
<-free_hot_cold_page
 queue_cyclictes-5298  [000] ....111   290.364295: preempt_count_add
<-migrate_enable
 queue_cyclictes-5298  [000] ....21.   290.364296: unpin_current_cpu
<-migrate_enable
 queue_cyclictes-5298  [000] ....21.   290.364297: preempt_count_sub
<-migrate_enable
 queue_cyclictes-5298  [000] ....1..   290.364299:
mm_page_free_batched: page=ef056f40 pfn=667514 order=0 cold=0

Another one (this one loops in blocks interspersed with the previous one):
 queue_cyclictes-5298  [000] ....111   290.361572: mm_page_pcpu_drain:
page=ef7005a0 pfn=885805 order=0 migratetype=2
 queue_cyclictes-5298  [000] ....111   290.361574:
__mod_zone_page_state <-free_pcppages_bulk
 queue_cyclictes-5298  [000] ....111   290.361575: preempt_count_add
<-__mod_zone_page_state
 queue_cyclictes-5298  [000] ....211   290.361576: preempt_count_sub
<-__mod_zone_page_state

Yet another one (also in blocks interspersed with the previous two):
 queue_cyclictes-5298  [000] ....111   290.333553: page_remove_rmap
<-unmap_single_vma
 queue_cyclictes-5298  [000] ....111   290.333555:
__mod_zone_page_state <-page_remove_rmap
 queue_cyclictes-5298  [000] ....111   290.333556: preempt_count_add
<-__mod_zone_page_state
 queue_cyclictes-5298  [000] ....211   290.333557: preempt_count_sub
<-__mod_zone_page_state

This is a simple program which creates the problem when run:
#define _GNU_SOURCE

#include <sched.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <errno.h>

#define CHECK_SYSCALL(syscall)                                                 \
  do {                                                                         \
    if ((syscall) == -1) {                                                     \
      fprintf(stderr, "syscall failed with %d: %s\n", errno, strerror(errno)); \
      return 1;                                                                \
    }                                                                          \
  } while (0)

int main() {
  CHECK_SYSCALL(mlockall(MCL_CURRENT | MCL_FUTURE));

  {
    struct sched_param param;
    memset(&param, 0, sizeof(param));
    param.sched_priority = 11;
    CHECK_SYSCALL(sched_setscheduler(0, SCHED_RR, &param));
  }

  {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(0, &cpuset);
    CHECK_SYSCALL(sched_setaffinity(0, sizeof(cpuset), &cpuset));
  }

  return 0;
}
