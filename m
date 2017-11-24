From: Sam Kappen <skappen@mvista.com>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Fri, 24 Nov 2017 12:09:16 +0530
Message-ID: <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de> <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru> <5A01812F.7040406@mcst.ru> <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:46712 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdKXGjS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Nov 2017 01:39:18 -0500
Received: by mail-vk0-f51.google.com with SMTP id 138so1660581vko.13
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2017 22:39:18 -0800 (PST)
In-Reply-To: <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am also faces a similar kind of issue on X86 target, while testing
3.10.105-rt119.
The issue is seen during boot-up when USB/SCSI enumeration starts.

Below is the log from my console

scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0004 PQ: 0 ANSI: 5
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3052 migrate_disable+0xee/0x100()
Modules linked in:
CPU: 3 PID: 7 Comm: kworker/u16:0 Not tainted 3.10.107-rt120+ #2
Hardware name: Intel Corporation S1200RP_SE/S1200RP_SE, BIOS
S1200RP.86B.02.02.0005.102320140911 10/23/2014
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 ffff880244927338 ffffffff8168b2f0 0000000000000000
 0000000000000009 ffff880244927370 ffffffff8105ef8c ffff8802448fb540
 0000000000000025 0000000000000004 0000000000000025 ffffffff81d9810c
Call Trace:
 [<ffffffff8168b2f0>] dump_stack+0x4f/0x65
 [<ffffffff8105ef8c>] warn_slowpath_common+0x5c/0xa0
 [<ffffffff8105f085>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109355e>] migrate_disable+0xee/0x100
 [<ffffffff810600af>] call_console_drivers.constprop.14+0x4f/0xd0
 [<ffffffff81061241>] console_unlock+0x2a1/0x470
 [<ffffffff810616e2>] vprintk_emit+0x2d2/0x550
 [<ffffffff8168eb49>] ? _raw_spin_unlock_irqrestore+0x19/0x50
 [<ffffffff810936ce>] ? migrate_enable+0x15e/0x1f0
 [<ffffffff816892d3>] printk+0x4a/0x52
 [<ffffffff810936ce>] ? migrate_enable+0x15e/0x1f0
 [<ffffffff8105ef5a>] warn_slowpath_common+0x2a/0xa0
 [<ffffffff8105f085>] warn_slowpath_null+0x15/0x20
 [<ffffffff810936ce>] migrate_enable+0x15e/0x1f0
 [<ffffffff810fce40>] get_page_from_freelist+0x630/0xb90
 [<ffffffff8168e32a>] ? rt_spin_lock_slowlock+0x2ca/0x310
 [<ffffffff810fe36d>] __alloc_pages_nodemask+0x13d/0x9e0
 [<ffffffff810fce72>] ? get_page_from_freelist+0x662/0xb90
 [<ffffffff81133dd0>] alloc_pages_current+0xb0/0x150
 [<ffffffff81138e05>] new_slab+0x2b5/0x380
 [<ffffffff8113b67a>] __slab_alloc.isra.18+0x58a/0x670
 [<ffffffff813d3f40>] ? scsi_pool_alloc_command+0x20/0x70
 [<ffffffff81133dd0>] ? alloc_pages_current+0xb0/0x150
 [<ffffffff8113b956>] kmem_cache_alloc+0xd6/0x100
 [<ffffffff813d3f40>] ? scsi_pool_alloc_command+0x20/0x70
 [<ffffffff813d3f40>] scsi_pool_alloc_command+0x20/0x70
 [<ffffffff813d492e>] scsi_host_alloc_command.isra.1+0x1e/0x80
 [<ffffffff813d49b0>] __scsi_get_command+0x20/0xc0
 [<ffffffff813d4a83>] scsi_get_command+0x33/0xc0
 [<ffffffff813dad1a>] scsi_get_cmd_from_req+0x4a/0x60
 [<ffffffff813db6cb>] scsi_setup_blk_pc_cmnd+0x2b/0xf0
 [<ffffffff813db8fc>] scsi_prep_fn+0x3c/0x50
 [<ffffffff812c9ef3>] blk_peek_request+0xf3/0x1c0
 [<ffffffff813db960>] scsi_request_fn+0x50/0x570
 [<ffffffff812c6c6e>] __blk_run_queue+0x2e/0x40
 [<ffffffff812cdde0>] blk_execute_rq_nowait+0x70/0x100
 [<ffffffff812cdef8>] blk_execute_rq+0x88/0xe0
sd 0:0:0:0: Attached scsi generic sg0 type 0
 [<ffffffff812ca040>] ? blk_rq_bio_prep+0x60/0xc0
 [<ffffffff812cdcf0>] ? blk_rq_map_kern+0xf0/0x170
 [<ffffffff812c86c0>] ? blk_get_request+0x60/0xe0
 [<ffffffff813da050>] scsi_execute+0xf0/0x150
 [<ffffffff813da182>] scsi_execute_req_flags+0x82/0xf0
 [<ffffffff8145d87f>] read_capacity_16+0xcf/0x520
 [<ffffffff8145e060>] sd_revalidate_disk+0x350/0x1bd0
 [<ffffffff8145f9a4>] sd_probe_async+0xc4/0x1d0
 [<ffffffff8108e7c2>] async_run_entry_fn+0x32/0x130
 [<ffffffff8107f5a5>] process_one_work+0x145/0x420
 [<ffffffff81080903>] worker_thread+0x163/0x470
 [<ffffffff8168d91c>] ? preempt_schedule+0x4c/0x70
 [<ffffffff810807a0>] ? manage_workers.isra.7+0x2d0/0x2d0
 [<ffffffff8108735f>] kthread+0xbf/0xd0
 [<ffffffff810872a0>] ? kthread_worker_fn+0x1a0/0x1a0
 [<ffffffff8168f6be>] ret_from_fork+0x4e/0x80
 [<ffffffff810872a0>] ? kthread_worker_fn+0x1a0/0x1a0
---[ end trace 0000000000000001 ]---
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3087 migrate_enable+0x15e/0x1f0()
Modules linked in:
CPU: 3 PID: 7 Comm: kworker/u16:0 Tainted: G        W    3.10.1


Test case to reproduce:
1. Enable PXE boot and mount file-system on USB stick
2. Continuously reboot the system with USB stick connected
3. We generally see the issue after every 3 to 5 hours.


On looking at the issue it is identified that there is some piece of
code someplace that
calls migrate_disable() with interrupts off, enables interrupts, then calls
migrate_enable().

On instrumentation it is observed that for some SCSI layer calls(calls from
get_requests) the above condition is not evaluated to true hence reaches at
buffered_rmqueue with irqs in disabled state.

>From the below call chain

buffered_rmqueue-> local_spin_lock_irqsave -> local_lock_irqsave -> spin_lock
->rt_spin_lock -> rt_spin_lock_fastlock -> rt_spin_lock_slowlock

In a normal case, when it enters rt_spin_lock_slowlock with irqs_disabled, the
same is returned in below case,

        if (__try_to_take_rt_mutex(lock, self, NULL, STEAL_LATERAL)) {
                raw_spin_unlock(&lock->wait_lock);
                return;
        }

But in the some case above condition is meet true and the control reaches below
in same function,

        pi_lock(&self->pi_lock);
        self->saved_state = self->state;
        __set_current_state(TASK_UNINTERRUPTIBLE);
        pi_unlock(&self->pi_lock);


pi_lock & pi_unlock disables and enables the irqs respectively, so in this
special case the irq state is not retained while exiting rt_spin_lock_slowlock
function and this results in the crash!

Could you please help to resolve the issue.

Regards,
Sam

On Fri, Nov 17, 2017 at 11:08 PM, Julia Cartwright <julia@ni.com> wrote:
> On Thu, Nov 16, 2017 at 05:08:37PM +0100, Sebastian Andrzej Siewior wrote:
>> + Steven & Julia
>>
>> On 2017-11-07 12:47:27 [+0300], Pavel V. Panteleev wrote:
>> > Thanks, it works.
>>
>> Okay, good to hear.
>>
>> Steven + Julia:
>> We need to decide what are going to do about this stable-wise. The bug
>> was reported against 3.14.79-rt85 and the devel tree is not affected*.
>> The thread starts at
>>   https://www.spinics.net/lists/linux-rt-users/msg17560.html
>
> Your proposed patch seems reasonable to me to pull back into the
> relevant releases.  Can you send a proper patch against the latest
> affected tree (4.9?) and the stable team will pull it back?  It looks
> like it will need some minor massaging on it's way back, but that
> shouldn't be a problem.
>
> Thanks,
>    Julia
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
