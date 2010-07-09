From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in wakeup_next_waiter()
Date: Fri, 09 Jul 2010 13:05:20 -0700
Message-ID: <4C378100.6000104@us.ibm.com>
References: <1278478019.10245.77.camel@marge.simson.net> <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <efault@gmx.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:51386 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab0GIUFh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 16:05:37 -0400
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o69Jvla7016755
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Jul 2010 13:57:47 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o69K5ShF006998
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Jul 2010 14:05:28 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o69K5QBJ018053
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Jul 2010 14:05:27 -0600
In-Reply-To: <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/07/2010 04:57 AM, Thomas Gleixner wrote:
> Cc'ing Darren.
> 
> On Wed, 7 Jul 2010, Mike Galbraith wrote:
> 
>> Greetings,
>>
>> Stress testing, looking to trigger RCU stalls, I've managed to find a
>> way to repeatably create fireworks.  (got RCU stall, see attached)
>> 4. run it.
>>
>> What happens here is we hit WARN_ON(pendowner->pi_blocked_on != waiter),
>> this does not make it to consoles (poking sysrq-foo doesn't either).
>> Next comes WARN_ON(!pendowner->pi_blocked_on), followed by the NULL
>> explosion, which does make it to consoles.
>>
>> With explosion avoidance, I also see pendowner->pi_blocked_on->task ==
>> NULL at times, but that, as !pendowner->pi_blocked_on, seems to be
>> fallout.  The start of bad juju is always pi_blocked_on != waiter.
>>
>> [  141.609268] BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
>> [  141.609268] IP: [<ffffffff8106856d>] wakeup_next_waiter+0x12c/0x177
>> [  141.609268] PGD 20e174067 PUD 20e253067 PMD 0
>> [  141.609268] Oops: 0000 [#1] PREEMPT SMP
>> [  141.609268] last sysfs file: /sys/devices/system/cpu/cpu3/cache/index2/shared_cpu_map
>> [  141.609268] CPU 0
>> [  141.609268] Pid: 8154, comm: pthread_cond_ma Tainted: G        W  2.6.33.6-rt23 #12 MS-7502/MS-7502
>> [  141.609268] RIP: 0010:[<ffffffff8106856d>]  [<ffffffff8106856d>] wakeup_next_waiter+0x12c/0x177
>> [  141.609268] RSP: 0018:ffff88020e3cdd78  EFLAGS: 00010097
>> [  141.609268] RAX: 0000000000000000 RBX: ffff8801e8eba5c0 RCX: 0000000000000000
>> [  141.609268] RDX: ffff880028200000 RSI: 0000000000000046 RDI: 0000000000000009
>> [  141.609268] RBP: ffff88020e3cdda8 R08: 0000000000000002 R09: 0000000000000000
>> [  141.609268] R10: 0000000000000005 R11: 0000000000000000 R12: ffffffff81659068
>> [  141.609268] R13: ffff8801e8ebdb58 R14: 0000000000000000 R15: ffff8801e8ebac08
>> [  141.609268] FS:  00007f664d539700(0000) GS:ffff880028200000(0000) knlGS:0000000000000000
>> [  141.609268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  141.609268] CR2: 0000000000000058 CR3: 0000000214266000 CR4: 00000000000006f0
>> [  141.609268] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  141.609268] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>> [  141.609268] Process pthread_cond_ma (pid: 8154, threadinfo ffff88020e3cc000, task ffff88020e2a4700)
>> [  141.609268] Stack:
>> [  141.609268]  0000000000000000 ffffffff81659068 0000000000000202 0000000000000000
>> [  141.609268]<0>  0000000000000000 0000000080001fda ffff88020e3cddc8 ffffffff812fec48
>> [  141.609268]<0>  ffffffff81659068 0000000000606300 ffff88020e3cddd8 ffffffff812ff1b9
>> [  141.609268] Call Trace:
>> [  141.609268]  [<ffffffff812fec48>] rt_spin_lock_slowunlock+0x43/0x61
>> [  141.609268]  [<ffffffff812ff1b9>] rt_spin_unlock+0x46/0x48
>> [  141.609268]  [<ffffffff81067d7f>] do_futex+0x83c/0x935
>> [  141.609268]  [<ffffffff810c26ce>] ? handle_mm_fault+0x6de/0x6f1
>> [  141.609268]  [<ffffffff81067e36>] ? do_futex+0x8f3/0x935
>> [  141.609268]  [<ffffffff81067fba>] sys_futex+0x142/0x154
>> [  141.609268]  [<ffffffff81020eb0>] ? do_page_fault+0x23e/0x28e
>> [  141.609268]  [<ffffffff81004aa7>] ? math_state_restore+0x3d/0x3f
>> [  141.609268]  [<ffffffff81004b08>] ? do_device_not_available+0xe/0x12
>> [  141.609268]  [<ffffffff81002c5b>] system_call_fastpath+0x16/0x1b
>> [  141.609268] Code: c7 09 6d 41 81 e8 ac 34 fd ff 4c 39 ab 70 06 00 00 74 11 be 47 02 00 00 48 c7 c7 09 6d 41 81 e8 92 34 fd ff 48 8b 83 70 06 00 00<4c>  39 60 58 74 11 be 48 02 00 00 48 c7 c7 09 6d 41 81 e8 74 34
>> [  141.609268] RIP  [<ffffffff8106856d>] wakeup_next_waiter+0x12c/0x177
>> [  141.609268]  RSP<ffff88020e3cdd78>
>> [  141.609268] CR2: 0000000000000058
>> [  141.609268] ---[ end trace 58805b944e6f93ce ]---
>> [  141.609268] note: pthread_cond_ma[8154] exited with preempt_count 2
>>
>> (5. eyeball locks.. ->  zzzzt ->  report ->  eyeball..)
>>
>> 	-Mike
>>


OK, here is the final analysis. After a trace-cmd fix and some rtmutex
"paradigm" insight from Rostedt, the root of the problem came out:

Jul  9 14:26:39 elm9m94 kernel: ------------[ cut here ]------------
Jul  9 14:26:39 elm9m94 kernel: WARNING: at kernel/rtmutex.c:590 wakeup_next_waiter+0x244/0x370()
Jul  9 14:26:39 elm9m94 kernel: Hardware name: IBM eServer BladeCenter HS21 -[7995AC1]-
Jul  9 14:26:39 elm9m94 kernel: Modules linked in: scsi_wait_scan
Jul  9 14:26:39 elm9m94 kernel: Pid: 3870, comm: pthread_cond_ma Not tainted 2.6.33.5-rt23dvh01 #13
Jul  9 14:26:39 elm9m94 kernel: Call Trace:
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff8104dc3b>] warn_slowpath_common+0x7b/0xc0
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff8104dc94>] warn_slowpath_null+0x14/0x20
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff81083f74>] wakeup_next_waiter+0x244/0x370
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff81921875>] rt_mutex_slowunlock+0x35/0x80
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff819218e9>] rt_mutex_unlock+0x29/0x40
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff8108258c>] do_futex+0xa6c/0xae0


# addr2line -e vmlinux ffffffff8108258c
/test/dvhart/source/linux-2.6-tip.git/kernel/futex.c:833
In futex_unlock_pi() unlocking the pi futex backing the pthread_mutex:

        rt_mutex_unlock(&pi_state->pi_mutex);


and a trace of the pending owner with the changing waiter (pi_blocked_on) from
sched_show_task():

Jul  9 14:26:39 elm9m94 kernel: pthread_cond_ M ffffffff81922537     0  4176   3745 0x00000080
Jul  9 14:26:39 elm9m94 kernel: ffffffff821fc9a8 0000000000000000 ffff88042ded9c08 ffffffff819216c0
Jul  9 14:26:39 elm9m94 kernel: 0000000000000000 ffff88042dbbabc0 ffffffff821fc9c0 ffff88042decee40
Jul  9 14:26:39 elm9m94 kernel: ffff88042decee40 ffff88042decee40 ffff880400000000 ffff88042ded9b70
Jul  9 14:26:39 elm9m94 kernel: Call Trace:
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff819216c0>] ? rt_spin_lock_slowlock+0x190/0x310
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff8192216c>] ? rt_spin_lock+0x7c/0x90
Jul  9 14:26:39 elm9m94 kernel: [<ffffffff810810c8>] ? futex_wait_requeue_pi+0x178/0x360


# addr2line -e vmlinux ffffffff810810c8
/test/dvhart/source/linux-2.6-tip.git/kernel/futex.c:153

That's inside match_futex(), back up a line:

# addr2line -e vmlinux ffffffff810810c0
/test/dvhart/source/linux-2.6-tip.git/kernel/futex.c:2258

This is futex_wait_requeue_pi():
        /* Queue the futex_q, drop the hb lock, wait for wakeup. */
        futex_wait_queue_me(hb, &q, to);
        
        spin_lock(&hb->lock);
        ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
        spin_unlock(&hb->lock);


Snippets from the trace:

 pthread_cond_ma-4176  [003]   395.357310: bprint:               task_blocks_on_rt_mutex : 4176 blocks on waiter:
 pthread_cond_ma-4176  [003]   395.357310: bprint:               task_blocks_on_rt_mutex :   waiter: 0xffff88042ded9b68
 pthread_cond_ma-4176  [003]   395.357311: bprint:               task_blocks_on_rt_mutex :   waiter->lock: 0xffffffff821fc9a8
 pthread_cond_ma-4176  [003]   395.357311: bprint:               task_blocks_on_rt_mutex :   was: 0xffff88042ded9cc8
                                                                                             ^ should always be NULL
 pthread_cond_ma-4176  [003]   395.357311: bprint:               task_blocks_on_rt_mutex :   oldwaiter->lock: 0xffff8804104d0450


 pthread_cond_ma-3870  [000]   395.357732: bprint:               wakeup_next_waiter : BUG: waiter changed
 pthread_cond_ma-3870  [000]   395.357733: bprint:               wakeup_next_waiter : pendowner pid: 4176
 pthread_cond_ma-3870  [000]   395.357734: bprint:               wakeup_next_waiter : pendowner comm:
 pthread_cond_ma-3870  [000]   395.357734: bprint:               wakeup_next_waiter : waiter->lock: 0xffff8804104d0450
 pthread_cond_ma-3870  [000]   395.357734: bprint:               wakeup_next_waiter : pi_blocked_on->lock: 0xffffffff821fc9a8
 
The one it changed to is the one we see in the task_blocks_on_rt_mutex
above. It has woken from the futex_wait_queue_me() after having been
requeued to the pi futex (we know this because it wouldn't have a
pi_blocked_on if it was still on the wait queue futex. Also the
futex_unlock_pi() call by 3870 is trying to unlock the previous lock
4167 was locked on.
 
The core of the problem is that the proxy_lock blocks a task on a lock
the task knows nothing about. So when it wakes up inside of
futex_wait_requeue_pi, it immediately tries to block on hb->lock to
check why it woke up. This has the potential to block the task on two
locks (thus overwriting the pi_blocked_on). Any attempt preventing this
involves a lock, and ultimiately the hb->lock. The only solution I see
is to make the hb->locks raw locks (thanks to Steven Rostedt for
original idea and batting this around with me in IRC).
 
Given the contention the hb->locks can be under, I'm concerned about the
latency impacts this can have, still, I don't see another way to allow
for the proxy locking that the rtmutex semantics require for requeue_pi
to work. I'll work up a patch and do some testing to see if I can get a
feel for the impact.

Ugh.

I'm still hoping to find some clever way to avoid this, going to map out
this state machine again and see if there is a way around it...

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
