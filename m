Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ECC4332F
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Nov 2022 08:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiK1IlH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiK1Ik7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2022 03:40:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C9E18344
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2022 00:40:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D63FED6E;
        Mon, 28 Nov 2022 00:41:00 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC023F73B;
        Mon, 28 Nov 2022 00:40:53 -0800 (PST)
Message-ID: <859aadda-c971-d16b-44a1-4e15ef49bf8b@arm.com>
Date:   Mon, 28 Nov 2022 09:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: v6.1-rt4 rpi4 boot time atomic_sleep splat
To:     Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1806ff76592576c6e6dba91f09ce661b7c75a9a9.camel@gmx.de>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <1806ff76592576c6e6dba91f09ce661b7c75a9a9.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Mike,
There is a patch-set currently ongoing aiming to solve this at:
   https://lore.kernel.org/all/20221121171217.3581004-1-pierre.gondois@arm.com/

Regards,
Pierre

On 11/27/22 06:10, Mike Galbraith wrote:
> Sole splat seen during brief master usability test drive.
> 
> (older rpi kernel is still way better idea, but it's improving.. boots,
> runs and hdmi audio started working)
> 
> [    0.007076] smp: Bringing up secondary CPUs ...
> [    0.008304] Detected PIPT I-cache on CPU1
> [    0.008377] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [    0.008384] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> [    0.008391] preempt_count: 1, expected: 0
> [    0.008396] RCU nest depth: 1, expected: 1
> [    0.008400] Preemption disabled at:
> [    0.008403] [<ffffffd3244ca8e0>] migrate_enable+0x40/0x170
> [    0.008425] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.0.g0b1dcc2-rt4 #25
> [    0.008437] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> [    0.008442] Call trace:
> [    0.008445]  dump_backtrace.part.0+0xe8/0xf4
> [    0.008455]  show_stack+0x20/0x50
> [    0.008463]  dump_stack_lvl+0x64/0x80
> [    0.008477]  dump_stack+0x18/0x34
> [    0.008488]  __might_resched+0x15c/0x1c0
> [    0.008502]  rt_spin_lock+0x38/0xd0
> [    0.008514]  rmqueue_bulk+0x68/0x850
> [    0.008529]  get_page_from_freelist+0xbe4/0xfa0
> [    0.008542]  __alloc_pages+0x14c/0xf70
> [    0.008554]  new_slab+0x2f0/0x374
> [    0.008569]  ___slab_alloc+0x5f0/0xbcc
> [    0.008584]  __kmem_cache_alloc_node+0xd0/0x380
> [    0.008591]  __kmalloc+0x6c/0x1c0
> [    0.008603]  detect_cache_attributes+0x448/0x564
> [    0.008620]  update_siblings_masks+0x30/0x304
> [    0.008631]  store_cpu_topology+0x48/0x60
> [    0.008640]  secondary_start_kernel+0xc8/0x144
> [    0.008656]  __secondary_switched+0xb0/0xb4
> [    0.008752] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
> [    0.010180] Detected PIPT I-cache on CPU2
> [    0.010300] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
> [    0.011522] Detected PIPT I-cache on CPU3
> [    0.011649] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
> [    0.011768] smp: Brought up 1 node, 4 CPUs
> 
