Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mga05.intel.com ([192.55.52.43]:39790 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeH0Hel (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Aug 2018 03:34:41 -0400
Date: Sun, 26 Aug 2018 20:39:22 -0700
From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: PREEMPT_RT_FULL breaks NO_HZ_FULL (full dynticks)
Message-ID: <20180827033922.GA28188@intel.com>
Reply-To: ramesh.thomas@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org

Normally CONFIG_NO_HZ_FULL (full dynticks) feature blocks timer interrupts 
when a single task is running in an isolated CPU.

This behavior changes when CONFIG_PREEMPT_RT_FULL is also enabled. I notice
timer ticks are blocked the very first time after boot and a single task is
running. However, when the task is stopped and run for the second time, the
timer ticks are not blocked anymore.

Disabling CONFIG_PREEMPT_RT_FULL brings back the expected behavior of
CONFIG_NO_HZ_FULL even if the task is stopped and rerun many times, as long 
as it is the single task running.

Following are the system and kernel configurations used in my tests:

Kernel version: 4.18.0-rc8, branch linux-4.18.y-rt
Set CONFIG_NO_HZ_FULL=y

CPU isolaion is done using following kernel parameters:
isolcpus=nohz,domain,1-3 nohz_full=1-3 rcu_nocbs=1-3 irqaffinity=0

Workload is run in CPU 3, with SCHED_FIFO priority 99 as follows:
taskset -c 3 chrt -f 99 ./jitter

Give RT process 100% time for testing purpose:
echo -1 > /proc/sys/kernel/sched_rt_runtime_us

Following are the list of processes in CPU 3 in the 3 cases:

Case #1 with CONFIG_PREEMPT_RT_FULL=n
S [cpuhp/3]
S [migration/3]
S [rcuc/3]
S [ksoftirqd/3]
I [kworker/3:0-mm_]
I [kworker/3:0H]
R [kworker/3:1-mm_]
R ./jitter

Case #2 with CONFIG_PREEMPT_RT_FULL=y (First run after boot)
S [cpuhp/3]
S [migration/3]
S [posixcputmr/3]
S [rcuc/3]
S [ktimersoftd/3]
S [ksoftirqd/3]
I [kworker/3:0-mm_]
I [kworker/3:0H]
R [irq/125-nvme0q4]
R [kworker/3:1-mm_]
R ./jitter

Case #3 with CONFIG_PREEMPT_RT_FULL=y (Second run after boot)
S [cpuhp/3]
S [migration/3]
S [posixcputmr/3]
S [rcuc/3]
R [ktimersoftd/3]
S [ksoftirqd/3]
I [kworker/3:0-mm_]
I [kworker/3:0H]
S [irq/125-nvme0q4]
R [kworker/3:1-mm_]
R ./jitter

In Case #3, /proc/interupts show timer interrupts occuring on CPU 3 while it
is stopped in the other cases. ktimersoftd is in runnable state in Case #3

Case #1 with PREEMPT_RT_FULL disabled has fewer processes and looks clean.

We need both PREEMPT_RT_FULL and NO_HZ_FULL for use cases where a single RT
task in a core can run with bare metal performance without timer interrupts.

Is this a known issue and is it being looked at by anyone?

If it is an issue, I would be glad to help in any way to get these 2 very
important features compatible with each other.

Thanks,
Ramesh
