From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: Trouble booting PREEMPT_RT kernel on ARM platform, 2.6.33
Date: Wed, 21 Jul 2010 12:51:29 +0530
Message-ID: <4C469FF9.1040607@linux.vnet.ibm.com>
References: <AANLkTilabvtaFnJKo8RKOfgP98F2rre4YQ8BF-o-uz92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeremy Brown <jhbrown@repinvariant.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:58893 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762719Ab0GUHVe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Jul 2010 03:21:34 -0400
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id o6L7G1e9020796
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Jul 2010 12:46:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o6L7LURu2728190
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Jul 2010 12:51:30 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o6L7LTPc007562
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Jul 2010 12:51:30 +0530
In-Reply-To: <AANLkTilabvtaFnJKo8RKOfgP98F2rre4YQ8BF-o-uz92@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday 21 July 2010 03:56 AM, Jeremy Brown wrote:
> We're trying to get a PREEMPT_RT kernel running on a BeagleBoard C4
> (OMAP3 Arm architecture).  We're using kernel version 2.6.33, with
>    
2.6.33 ! not 2.6.33.6 ???
> patches from
> patch-2.6.33.6-rt26.gz
>
> On boot, we start seeing messages of this form:
>
> ----
> [ 4528.227294] BUG: sleeping function called from invalid context at
> kernel/rtmutex.c:684
> [ 4528.227294] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 128, pid:
> 223, name: modprobe
> [ 4528.227355] [<c0044490>] (unwind_backtrace+0x0/0xe8) from
> [<c04cb4e4>] (rt_spin_lock+0x30/0x5c)
> [ 4528.227386] [<c04cb4e4>] (rt_spin_lock+0x30/0x5c) from [<c032e3b0>]
> (twl4030_sih_set_type+0x3c/0xac)
>    
sleeping spin lock is called while preempt/interrupt is disabled.

Can you try the below patch ?

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Index: linux-2.6.33.6-rt26/drivers/mfd/twl4030-irq.c
===================================================================
--- linux-2.6.33.6-rt26.orig/drivers/mfd/twl4030-irq.c    2010-07-21 
12:40:42.000000000 +0530
+++ linux-2.6.33.6-rt26/drivers/mfd/twl4030-irq.c    2010-07-21 
12:41:16.000000000 +0530
@@ -633,14 +633,14 @@
      if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
          return -EINVAL;

-    spin_lock_irqsave(&sih_agent_lock, flags);
+    raw_spin_lock_irqsave(&sih_agent_lock, flags);
      if ((desc->status & IRQ_TYPE_SENSE_MASK) != trigger) {
          desc->status &= ~IRQ_TYPE_SENSE_MASK;
          desc->status |= trigger;
          sih->edge_change |= BIT(irq - sih->irq_base);
          queue_work(wq, &sih->edge_work);
      }
-    spin_unlock_irqrestore(&sih_agent_lock, flags);
+    raw_spin_unlock_irqrestore(&sih_agent_lock, flags);
      return 0;
  }

Thanks,
Gowri

> [ 4528.227416] [<c032e3b0>] (twl4030_sih_set_type+0x3c/0xac) from
> [<c00aa944>] (__irq_set_trigger+0x34/0x88)
> [ 4528.227447] [<c00aa944>] (__irq_set_trigger+0x34/0x88) from
> [<c00ab2ec>] (__setup_irq+0x34c/0x3c0)
> [ 4528.227478] [<c00ab2ec>] (__setup_irq+0x34c/0x3c0) from
> [<c00ab430>] (request_threaded_irq+0xd0/0x148)
> [ 4528.227508] [<c00ab430>] (request_threaded_irq+0xd0/0x148) from
> [<bf021770>] (twl_rtc_probe+0x104/0x1fc [rtc_twl])
> [ 4528.227539] [<bf021770>] (twl_rtc_probe+0x104/0x1fc [rtc_twl]) from
> [<c0324e2c>] (platform_drv_probe+0x18/0x1c)
> [ 4528.227569] [<c0324e2c>] (platform_drv_probe+0x18/0x1c) from
> [<c0323eec>] (driver_probe_device+0x98/0x194)
> [ 4528.227600] [<c0323eec>] (driver_probe_device+0x98/0x194) from
> [<c0324074>] (__driver_attach+0x8c/0x90)
> [ 4528.227600] [<c0324074>] (__driver_attach+0x8c/0x90) from
> [<c0323744>] (bus_for_each_dev+0x60/0x8c)
> [ 4528.227630] [<c0323744>] (bus_for_each_dev+0x60/0x8c) from
> [<c0323014>] (bus_add_driver+0xa0/0x240)
> [ 4528.227661] [<c0323014>] (bus_add_driver+0xa0/0x240) from
> [<c0324324>] (driver_register+0x78/0x13c)
> [ 4528.227661] [<c0324324>] (driver_register+0x78/0x13c) from
> [<c003e3c0>] (do_one_initcall+0x30/0x1c0)
> [ 4528.227691] [<c003e3c0>] (do_one_initcall+0x30/0x1c0) from
> [<c0097e40>] (sys_init_module+0xc4/0x1f8)
> [ 4528.227722] [<c0097e40>] (sys_init_module+0xc4/0x1f8) from
> [<c003ea60>] (ret_fast_syscall+0x0/0x2c)
> ---
>
> I'm hoping that someone will recognize this problem and be able to
> suggest a simple fix.  Any help would be very much appreciated!
>
> Thanks,
> Jeremy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>    

