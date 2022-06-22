Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F70C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jun 2022 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359460AbiFVPqv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiFVPqr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jun 2022 11:46:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E40AF393D0
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jun 2022 08:46:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8F7D12FC;
        Wed, 22 Jun 2022 08:46:46 -0700 (PDT)
Received: from [10.57.42.155] (unknown [10.57.42.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22C3F3F792;
        Wed, 22 Jun 2022 08:46:45 -0700 (PDT)
Message-ID: <fc79fec3-0ada-0ca6-9f99-b65cb660b6a6@arm.com>
Date:   Wed, 22 Jun 2022 17:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     linux-rt-users@vger.kernel.org
Content-Language: en-US
Cc:     Qais Yousef <Qais.Yousef@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Creating per_cpu rt_bandwidth struct
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,
I would like to quickly check if creating per_cpu rt_bandwidth struct would
make sense.

The def_rt_bandwidth struct at:
https://github.com/torvalds/linux/blob/ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d/kernel/sched/rt.c#L13
is used to limit the bandwidth or rt tasks. To do so, a timer with a period
of sysctl_sched_rt_period is running if there is a rt task running.

When enqueueing a task on a rt_rq, def_rt_bandwidth's lock must be obtained
to check whether the bandwidth's timer is running: (cf rt_period_active)
https://github.com/torvalds/linux/blob/ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d/kernel/sched/rt.c#L102
The call graph is:
inc_rt_tasks() -> inc_rt_group() -> start_rt_bandwidth() -> do_start_rt_bandwidth()

def_rt_bandwidth is shared among all CPUs. Thus, some contention to access
def_rt_bandwidth's lock appears with the number of CPUs running rt tasks.

An example of a long lock access, with the cyclictest command:
cyclictest -l20000 -m -t32 -a -i100 -d0 -p1 -q
273.278506 |               |    enqueue_task_rt() {
273.278506 |               |      dequeue_rt_stack() {
273.278506 |   0.160 us    |        dequeue_top_rt_rq();
273.278507 |   0.480 us    |      }
273.278507 |   0.280 us    |      cpupri_set();
273.278507 |   0.120 us    |      update_rt_migration();
273.278511 |               |      _raw_spin_lock() {
273.278516 | + 17.120 us   |        queued_spin_lock_slowpath();
273.278534 | + 22.840 us   |      }
273.278534 |   0.120 us    |      enqueue_top_rt_rq();
273.278534 | + 28.360 us   |    }

This can also be seen when running the above cyclictest command with an
increasing number of threads (threads spawn on different CPUs). On an Ampere
Altra with 160 CPUs, there is a strong correlation between the average latency
and number of threads spawning:
#threads : latency (us)
1-32     :   ~5
40       :  ~80
100      : ~220

Making def_rt_bandwidth a per_cpu (or per rt_rq) variable would allow to have
per_cpu bandwidth timers. This would then reduce the contention when checking
if a bandwidth timer is already running.
A raw implementation making def_rt_bandwidth a per_cpu variable shows the
following improvement:
50:  ~11 ->  ~7
100: ~25 -> ~12
200: ~50 -> ~18
The above was tested on a ThunderX2.

Tests are done with preemption enabled, with the default bandwidth values
(runtime=0.95s, period=1s).
Note that setting sched_rt_runtime_us=-1 prevents from accessing the
def_rt_bandwidth timer and thus also greatly improve the latency.

As the CONFIG_RT_GROUP_SCHED option already allows to have per task_group
bandwidth timers, I assume making rt_bandwidth a per_cpu struct is also
sensible.

Please let me know if this is not the case,
Regards,
Pierre
