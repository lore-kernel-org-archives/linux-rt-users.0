From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: [PATCH][RT] Fix pushable_tasks list corruption
Date: Thu, 02 Oct 2008 16:45:09 +0200
Message-ID: <48E4DE75.50006@bull.net>
References: <1222945573-29082-1-git-send-email-gilles.carry@bull.net> <48E4C02A.4020406@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46848 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYJBOpY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Oct 2008 10:45:24 -0400
In-Reply-To: <48E4C02A.4020406@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins wrote:
> Hi Gilles
> 
> Gilles Carry wrote:
> 
>>From: gilles.carry <gilles.carry@bull.net>
>>
>>Symptoms:
>>System hang (endless loop in plist_check_list) or BUG because
>>of faulty prev/next pointers in pushable_task node.
>>
>>
>>When push_rt_task successes finding a task to push away, it
>>performs a double lock on the runqueues (local and target) but
>>before getting both locks, it releases the local rq lock letting
>>other cpus grab the task in between. (eg. pull_rt_task, timers...)
>>When push_rt_task calls deactivate_task (which calls
>>dequeue_pushable_task) the task may have already been removed
>>from the pushable_tasks list by another cpu.
>>Removing the node again corrupts the list.
>>  
> 
> 
> Hmm,  I was looking at this same area of the code earlier this week. 
> The problem with your assessment is that find_lock_lowest_rq() already
> accounts for the dropped-lock-migration and will return NULL if the task
> was moved in the interim.  I suppose there could be some weird
> circumstance where the task is moved away, and then moved back, but even
> so plist_del() is supposed to be idempotent, so I dont see why an extra
> dequeue_pushable itself would be a problem.


FYI, disabling pull_rt_task (return 0) made the system a little more robust.
It "only" crashed this way:

cpu 0x4: Vector: 700 (Program Check) at [c0000000ee70ea50]
     pc: c0000000001ba268: .plist_check_prev_next+0x8c/0xb4
     lr: c0000000001ba264: .plist_check_prev_next+0x88/0xb4
     sp: c0000000ee70ecd0
    msr: 8000000000021032
   current = 0xc0000000ee748410
   paca    = 0xc0000000005d3b80
     pid   = 2670, comm = sbrk_mutex
kernel BUG at lib/plist.c:38!
enter ? for help
[c0000000ee70ed60] c0000000001ba2e8 .plist_check_list+0x58/0x94
[c0000000ee70ee00] c0000000001ba368 .plist_check_head+0x44/0x64
[c0000000ee70ee90] c0000000001ba3bc .plist_del+0x34/0xdc
[c0000000ee70ef30] c00000000004db68 .enqueue_pushable_task+0x3c/0xe0
[c0000000ee70efd0] c0000000000537a4 .enqueue_task_rt+0x80/0xb8
[c0000000ee70f070] c000000000049e6c .enqueue_task+0x40/0x6c
[c0000000ee70f100] c000000000049f44 .activate_task+0x40/0x68
[c0000000ee70f190] c00000000004cd7c .try_to_wake_up+0x13c/0x20c
[c0000000ee70f260] c00000000004cf8c .wake_up_process+0x24/0x38
[c0000000ee70f2e0] c00000000007b050 .hrtimer_wakeup+0x34/0x50
[c0000000ee70f360] c00000000007ac6c .__run_hrtimer+0x7c/0x114
[c0000000ee70f400] c00000000007c0b0 .hrtimer_interrupt+0x128/0x1e8
[c0000000ee70f4e0] c000000000025fc8 .timer_interrupt+0xe8/0x168
[c0000000ee70f590] c000000000003600 decrementer_common+0x100/0x180
--- Exception: 901 (Decrementer) at c00000000000c058
.raw_local_irq_restore+0x48/0x54
[link register   ] c0000000002cf348 .schedule+0x108/0x128
[c0000000ee70f880] c0000000e916d4e0 (unreliable)
[c0000000ee70f8c0] c0000000002cf334 .schedule+0xf4/0x128
[c0000000ee70f950] c0000000000860d8 .futex_wait+0x290/0x49c
[c0000000ee70fc10] c0000000000876bc .do_futex+0xf0/0xa48
[c0000000ee70fd40] c00000000008816c .sys_futex+0x158/0x1a0
[c0000000ee70fe30] c0000000000086ac syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 00000080fdd948b8
SP (40007c3e6b0) is in userspace
4:mon>


You're right, my comment is wrong and misplaced, it should
be inside the if(!lower_rq).

Looking at the code again, I suspect that paranoid-- in the test is the
reason why dequeue_pushable is called un-appropriately.

I'll rebrew the patch tomorrow.

> 
> At this point I don't really *love* your patch because it seems to just
> be plastering over the problem that the list is corrupted.  I do
> appreciate that you are looking at this problem, however!  So thank you
> for that and please keep it up.

Actually, I think this patch *avoids* the list corruption by not deleting
a node from the wrong list.
Also, looking at the system complexity, I suggest that this sanity check
remains.

Anyway, so far so good, after hours of intensive testing, both PPC64 and Intel64
are up.

> I am on vacation every thursday+friday for a while, so I will not be
> responsive until Monday.  Ill catch up with you guys then.  Have a good
> weekend.

Thanks.
Have a good week-end, too.

