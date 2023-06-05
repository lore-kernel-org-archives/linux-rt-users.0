Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F73C77B73
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Jun 2023 09:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjFEJ7Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFEJ7X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Jun 2023 05:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6F50B0
        for <linux-rt-users@vger.kernel.org>; Mon,  5 Jun 2023 02:59:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A79D75;
        Mon,  5 Jun 2023 03:00:07 -0700 (PDT)
Received: from [10.34.100.116] (e126645.nice.arm.com [10.34.100.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F14F3F793;
        Mon,  5 Jun 2023 02:59:20 -0700 (PDT)
Message-ID: <184e9ac7-42b4-caa9-af86-a34cf1d4e63f@arm.com>
Date:   Mon, 5 Jun 2023 11:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: v6.1-rt4 rpi4 boot time atomic_sleep splat
To:     He Zhe <zhe.he@windriver.com>
Cc:     859aadda-c971-d16b-44a1-4e15ef49bf8b@arm.com,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        efault@gmx.de, Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <e15710ff-b64f-f382-8de4-7c2b8f8d445c@windriver.com>
Content-Language: en-US
In-Reply-To: <e15710ff-b64f-f382-8de4-7c2b8f8d445c@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Zhe,

I am not familiar on the conditions to backport patches, but I think [1]
was not considered as 'fixes' patches. There has also been multiple fixes on top it.

The latest Yocto branch is using v6.1.15. [1] when using Device Tree also requires that
the device tree is correctly populated (no 'cache-level' property missing). They were added
in v6.2.y and would also need to be backported for the splat to disappear.
Cf commit 3b450831e5f1 ("arm64: dts: Update cache properties for freescale")

There is currently an effort to have a stable cacheinfo setup in v6.3.2 at [2].

Also, I am not sure the etm_starting_cpu/etm_dying_cpu sleeping bug is related to the cacheinfo fixes.

Regards,
Pierre

[1] https://lore.kernel.org/all/20230104183033.755668-1-pierre.gondois@arm.com/
[2] https://lore.kernel.org/stable/20230530201955.848176-1-florian.fainelli@broadcom.com/


On 5/31/23 10:43, He Zhe wrote:
> Hi,
> 
> Recently we still observed the same and seemingly similar call traces in v6.1.
> 
> Will the fixes in v6.3 be backed ported to v6.1? or do we have plan to fix for
> v6.1? Thanks.
> 
> 
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> Preemption disabled at:
> [<ffffffc00820ff14>] __create_object+0x110/0x380
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.27-rt7-yocto-preempt-rt #1
> Hardware name: NXP S32G399A-RDB3 (DT)
> Call trace:
>   dump_backtrace.part.0+0xc8/0xd4
>   show_stack+0x20/0x30
>   dump_stack_lvl+0x6c/0x88
>   dump_stack+0x18/0x34
>   __might_resched+0x160/0x1c0
>   rt_spin_lock+0x38/0xb0
>   rmqueue_bulk+0x68/0x920
>   get_page_from_freelist+0xd18/0x11f0
>   __alloc_pages+0x164/0x10d0
>   new_slab+0x2f0/0x454
>   ___slab_alloc+0x4b0/0xb90
>   __kmem_cache_alloc_node+0xe0/0x38c
>   __kmalloc+0x6c/0x1d0
>   detect_cache_attributes+0x458/0x570
>   update_siblings_masks+0x30/0x274
>   store_cpu_topology+0x48/0x60
>   secondary_start_kernel+0xd0/0x130
>   __secondary_switched+0xb0/0xb4
> 
> 
> 
> [ 2381.971932] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [ 2381.971949] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 25, name: migration/1
> [ 2381.971959] preempt_count: 1, expected: 0
> [ 2381.971964] RCU nest depth: 0, expected: 0
> [ 2381.971969] 1 lock held by migration/1/25:
> [ 2381.971975]  #0: 869aa87c (&drvdata->spinlock#4){....}-{2:2}, at: etm_dying_cpu+0x2c/0x58
> [ 2381.972020] Preemption disabled at:
> [ 2381.972023] [<80229ab0>] cpu_stopper_thread+0x90/0x13c
> [ 2381.972048] CPU: 1 PID: 25 Comm: migration/1 Not tainted 6.1.29-rt10-yocto-preempt-rt #1
> [ 2381.972061] Hardware name: Xilinx Zynq Platform
> [ 2381.972066] Stopper: multi_cpu_stop+0x0/0x184 <- stop_machine_cpuslocked+0x130/0x1ac
> [ 2381.972101]  unwind_backtrace from show_stack+0x18/0x1c
> [ 2381.972136]  show_stack from dump_stack_lvl+0x60/0x90
> [ 2381.972172]  dump_stack_lvl from __might_resched+0x184/0x1c4
> [ 2381.972201]  __might_resched from rt_spin_lock+0x54/0xb0
> [ 2381.972227]  rt_spin_lock from etm_dying_cpu+0x2c/0x58
> [ 2381.972251]  etm_dying_cpu from cpuhp_invoke_callback+0x188/0x370
> [ 2381.972276]  cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0x74/0x100
> [ 2381.972300]  __cpuhp_invoke_callback_range from take_cpu_down+0x74/0xb0
> [ 2381.972323]  take_cpu_down from multi_cpu_stop+0x84/0x184
> [ 2381.972349]  multi_cpu_stop from cpu_stopper_thread+0x98/0x13c
> [ 2381.972374]  cpu_stopper_thread from smpboot_thread_fn+0x19c/0x320
> [ 2381.972400]  smpboot_thread_fn from kthread+0xf0/0x128
> [ 2381.972427]  kthread from ret_from_fork+0x14/0x2c
> [ 2381.972447] Exception stack(0xc087dfb0 to 0xc087dff8)
> [ 2381.972458] dfa0:                                     00000000 00000000 00000000 00000000
> [ 2381.972470] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [ 2381.972481] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [ 2384.412614] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [ 2384.412632] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> [ 2384.412641] preempt_count: 1, expected: 0
> [ 2384.412646] RCU nest depth: 0, expected: 0
> [ 2384.412651] 1 lock held by swapper/1/0:
> [ 2384.412658]  #0: 869aa87c (&drvdata->spinlock#4){....}-{2:2}, at: etm_starting_cpu+0x2c/0xcc
> [ 2384.412703] Preemption disabled at:
> [ 2384.412706] [<00000000>] 0x0
> [ 2384.412724] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.1.29-rt10-yocto-preempt-rt #1
> [ 2384.412738] Hardware name: Xilinx Zynq Platform
> [ 2384.412747]  unwind_backtrace from show_stack+0x18/0x1c
> [ 2384.412784]  show_stack from dump_stack_lvl+0x60/0x90
> [ 2384.412821]  dump_stack_lvl from __might_resched+0x184/0x1c4
> [ 2384.412852]  __might_resched from rt_spin_lock+0x54/0xb0
> [ 2384.412879]  rt_spin_lock from etm_starting_cpu+0x2c/0xcc
> [ 2384.412903]  etm_starting_cpu from cpuhp_invoke_callback+0x188/0x370
> [ 2384.412928]  cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0x74/0x100
> [ 2384.412952]  __cpuhp_invoke_callback_range from notify_cpu_starting+0x78/0xb8
> [ 2384.412978]  notify_cpu_starting from secondary_start_kernel+0xe0/0x160
> [ 2384.413006]  secondary_start_kernel from 0x102160
> 
> 
> 
> [ 0.000000] Linux version 6.1.29-rt10-yocto-preempt-rt (oe-user@oe-host) (aarch64-wrs-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40.20230119) #1 SMP PREEMPT_RT Wed May 24 02:08:59 UTC 2023
> [ 1.014167] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [ 1.014173] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> [ 1.014178] preempt_count: 1, expected: 0
> [ 1.014181] RCU nest depth: 0, expected: 0
> [ 1.014185] 1 lock held by swapper/1/0:
> [ 1.014189] #0: ffffff88000008e0 (&n->list_lock){..}-{2:2}, at: get_partial_node+0x4c/0x3dc
> [ 1.014229] irq event stamp: 0
> [ 1.014231] hardirqs last enabled at (0): [<0000000000000000>] 0x0
> [ 1.014239] hardirqs last disabled at (0): [<ffffffc0080431fc>] copy_process+0x65c/0x1424
> [ 1.014254] softirqs last enabled at (0): [<ffffffc0080431fc>] copy_process+0x65c/0x1424
> [ 1.014264] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 1.014270] Preemption disabled at:
> [ 1.014272] [<ffffffc00831f660>] __create_object+0x12c/0x39c
> [ 1.014288] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.29-rt10-yocto-preempt-rt #1
> [ 1.014295] Hardware name: Freescale S32G399A (DT)
> [ 1.014300] Call trace:
> [ 1.014303] dump_backtrace.part.0+0xcc/0xe0
> [ 1.014311] show_stack+0x20/0x30
> [ 1.014317] dump_stack_lvl+0xac/0xf0
> [ 1.014330] dump_stack+0x18/0x34
> [ 1.014339] __might_resched+0x180/0x230
> [ 1.014352] rt_spin_lock+0x64/0x110
> [ 1.014363] get_partial_node+0x4c/0x3dc
> [ 1.014373] ___slab_alloc+0x328/0x714
> [ 1.014382] __kmem_cache_alloc_node+0x10c/0x260
> [ 1.014390] __kmalloc+0x68/0x104
> [ 1.014400] detect_cache_attributes+0x98/0x104
> [ 1.014409] update_siblings_masks+0x30/0x350
> [ 1.014420] store_cpu_topology+0x44/0x90
> [ 1.014430] secondary_start_kernel+0xd4/0x134
> [ 1.014439] __secondary_switched+0xb0/0xb4
> 
> 
> 
> Zhe
