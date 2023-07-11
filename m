Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF07EB64DC
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jul 2023 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGKPpR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Jul 2023 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGKPpQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Jul 2023 11:45:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80DAFC2;
        Tue, 11 Jul 2023 08:45:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B82B1FB;
        Tue, 11 Jul 2023 08:45:56 -0700 (PDT)
Received: from [10.57.30.34] (unknown [10.57.30.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5405E3F740;
        Tue, 11 Jul 2023 08:45:12 -0700 (PDT)
Message-ID: <85a706fb-1072-0c59-e08c-8bb27e069991@arm.com>
Date:   Tue, 11 Jul 2023 16:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] coresight: etm3x: convert struct etm_drvdata's spinlock
 to raw_spinlock
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quanyang.wang@windriver.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230711070536.3944458-1-quanyang.wang@windriver.com>
 <2023071134-mardi-lyricist-e5b0@gregkh>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <2023071134-mardi-lyricist-e5b0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 11/07/2023 15:05, Greg Kroah-Hartman wrote:
> On Tue, Jul 11, 2023 at 03:05:36PM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> For PREEMPT_RT kernel, spinlock_t locks become sleepable. The functions
>> etm_dying_cpu and etm_starting_cpu which call spin_lock/unlock run in
>> an irq-disabled context, this will trigger the following calltrace:
>>
>>     BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>>     in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 25, name: migration/1
>>     preempt_count: 1, expected: 0
>>     RCU nest depth: 0, expected: 0
>>     1 lock held by migration/1/25:
>>      #0: 82a7587c (&drvdata->spinlock){....}-{2:2}, at: etm_dying_cpu+0x28/0x54
>>     Preemption disabled at:
>>     [<801ec760>] cpu_stopper_thread+0x94/0x120
>>     CPU: 1 PID: 25 Comm: migration/1 Not tainted 6.1.35-rt10-yocto-preempt-rt #30
>>     Hardware name: Xilinx Zynq Platform
>>     Stopper: multi_cpu_stop+0x0/0x174 <- __stop_cpus.constprop.0+0x48/0x88
>>      unwind_backtrace from show_stack+0x18/0x1c
>>      show_stack from dump_stack_lvl+0x58/0x70
>>      dump_stack_lvl from __might_resched+0x14c/0x1c0
>>      __might_resched from rt_spin_lock+0x4c/0x84
>>      rt_spin_lock from etm_dying_cpu+0x28/0x54
>>      etm_dying_cpu from cpuhp_invoke_callback+0x140/0x33c
>>      cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0xa4/0x104
>>      __cpuhp_invoke_callback_range from take_cpu_down+0x7c/0xa8
>>      take_cpu_down from multi_cpu_stop+0x15c/0x174
>>      multi_cpu_stop from cpu_stopper_thread+0x9c/0x120
>>      cpu_stopper_thread from smpboot_thread_fn+0x31c/0x360
>>      smpboot_thread_fn from kthread+0x100/0x124
>>      kthread from ret_from_fork+0x14/0x2c
>>
>> Convert struct etm_drvdata's spinlock to raw_spinlock to fix it.
> 
> wait, why will a raw_spinlock fix this?  Why not fix the root problem
> here, that of calling these locks inproperly in irq context?
> 
> How is changing to a raw_spinlock going to fix the above splat?
> 
> thanks,
> 
> greg k-h
> 

If it's just etm_starting_cpu() and etm_dying_cpu() as mentioned in the
commit message then can those spinlocks be removed?

Surely there can't be any concurrent access to the per-cpu data when the
hotplug callbacks are called?

James

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
