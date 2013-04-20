From: Li Zefan <lizefan@huawei.com>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Sat, 20 Apr 2013 15:21:41 +0800
Message-ID: <51724205.3000008@huawei.com>
References: <5170F28F.3060002@huawei.com> <5171F6B3.1020907@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:28855 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab3DTHVw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Apr 2013 03:21:52 -0400
In-Reply-To: <5171F6B3.1020907@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013/4/20 10:00, Qiang Huang wrote:
> On 2013/4/19 15:30, Qiang Huang wrote:
>> Hi,
>>
>> I ran cgroup_fj tests on RT kernel with PREEMPT_RT_FULL disabled, it will
>> stick the system when ran cpuset stress tests, it happens everytime.
> 
> Here let me explain something, cgroup_fj is a test suit in ltp, which will do
> some functionality and pressure test on cgroup.
> 
> And the script I give below is a very simple version of cgroup_fj which only
> do one type of pressure test on cpuset subsystem.
> What he did is:
> 1. Create /dev/cgroup and mount cpuset subsystem on it.
> 2. Create 100 dir under /dev/cgroup named subgroup_1..subgroup_100.
> 3. Attach all tasks in /dev/cgroup/tasks to /dev/cgroup/subgroup_1/tasks, then
> from /dev/cgroup/subgroup_1/tasks to /dev/cgroup/subgroup_2/tasks and so on,
> finally from /dev/cgroup/subgroup_100/tasks to /dev/cgroup/tasks, then end.
> 
> And the system will stuck in step 3.
> 

This is strange. When tasks are moved from one cpuset to another, their cpumask
and nodemask will be updated and memory will be migrated, but only if the source
cpuset and dest cpuset have different masks. In this test case, all cpusets have
the same configs.

Try to comment out some lines in cpuset_attach(), and see if the problem still
exists?

diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 5fc1570..ea430e7 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -1422,16 +1422,17 @@ static void cpuset_attach(struct cgroup *cgrp, struct cgroup_taskset *tset)
                 * can_attach beforehand should guarantee that this doesn't
                 * fail.  TODO: have a better way to handle failure here
                 */
-               WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+//             WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));

-               cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
-               cpuset_update_task_spread_flag(cs, task);
+//             cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
+//             cpuset_update_task_spread_flag(cs, task);
        }

        /*
         * Change mm, possibly for multiple threads in a threadgroup. This is
         * expensive and may sleep.
         */
+       /*
        cpuset_attach_nodemask_from = oldcs->mems_allowed;
        cpuset_attach_nodemask_to = cs->mems_allowed;
        mm = get_task_mm(leader);
@@ -1442,6 +1443,7 @@ static void cpuset_attach(struct cgroup *cgrp, struct cgroup_taskset *tset)
                                          &cpuset_attach_nodemask_to);
                mmput(mm);
        }
+       */
 }


