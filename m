From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: Query - state of memory hotplug with RT kernel
Date: Wed, 8 Jun 2016 03:05:14 -0400 (EDT)
Message-ID: <557440847.57840590.1465369514193.JavaMail.zimbra@redhat.com>
References: <1997236940.56779393.1464861408686.JavaMail.zimbra@redhat.com> <420969271.56780563.1464862241604.JavaMail.zimbra@redhat.com> <20160603160433.GC4496@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:56282 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbcFHHFX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Jun 2016 03:05:23 -0400
In-Reply-To: <20160603160433.GC4496@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Sebastian,

Sorry! for replying late as I am on vacation this week.

> >Hello,
> Hi,
> 
> >Recently, I have been debugging some of the issues with memory
> >hotplug with RT kernel. I want to know state of memory hotplug
> >with RT kernel and if there are any known issues or work going
> >on upstream?
> 
> I never tried memory hotplug. You are the first one that complains or
> mentions it.
> 
> >I came to know that there is rework of 'cpu hotplug' going on.
> >Not sure about 'memory hotplug'.
> >
> >Any inputs or pointers on this?
> 
> I have been looking into CPU hotplug but got interrupted by v4.6 and a
> few other things. Regarding memory hotplug, as I said I don't know what
> is broken. Is this something that can be tested in kvm?

Yes, KVM guest hangs when I tried to hotplug 4 GB of memory.
When I tried to find root cause of it, I got below calltrace:

//call trace of running task

 #0 [ffff8801638ab7e0] get_page_from_freelist at ffffffff81165607
 #1 [ffff8801638ab8d8] cpuacct_charge at ffffffff810b9a61
 #2 [ffff8801638ab908] __switch_to at ffffffff810018b2
 #3 [ffff8801638ab968] __schedule at ffffffff81625984
 #4 [ffff8801638ab9c8] preempt_schedule_irq at ffffffff816264a1
 #5 [ffff8801638ab9f0] retint_kernel at ffffffff81628277
 #6 [ffff8801638aba38] migrate_enable at ffffffff810aa0eb
 #7 [ffff8801638abaa8] __switch_to at ffffffff810018b2
 #8 [ffff8801638abb08] __schedule at ffffffff81625984
 #9 [ffff8801638abb68] preempt_schedule_irq at ffffffff816264a1
#10 [ffff8801638abb90] retint_kernel at ffffffff81628277
#11 [ffff8801638abbe8] isolate_pcp_pages at ffffffff81160489
#12 [ffff8801638abc50] free_hot_cold_page at ffffffff8116463c--------\
                                     //pa_lock  is used with local_lock_irqsave
#13 [ffff8801638abcb8] __free_pages at ffffffff811647df
#14 [ffff8801638abcd8] __online_page_free at ffffffff811b6dcc
#15 [ffff8801638abce8] generic_online_page at ffffffff811b6e0b
#16 [ffff8801638abcf8] online_pages_range at ffffffff811b6ce5
#17 [ffff8801638abd38] walk_system_ram_range at ffffffff8107914c
#18 [ffff8801638abda8] online_pages at ffffffff81614a84
#19 [ffff8801638abe20] memory_subsys_online at ffffffff813f1268
#20 [ffff8801638abe50] device_online at ffffffff813d9745
#21 [ffff8801638abe78] store_mem_state at ffffffff813f0ef4
#22 [ffff8801638abea0] dev_attr_store at ffffffff813d6698
#23 [ffff8801638abeb0] sysfs_write_file at ffffffff81247499
#24 [ffff8801638abef8] vfs_write at ffffffff811ca7ad
#25 [ffff8801638abf38] sys_write at ffffffff811cb24f
#26 [ffff8801638abf80] system_call_fastpath at ffffffff8162fe89

It looks to me "local_lock_irqsave(pa_lock, flags)" is taken in
function 'free_hot_cold_page' which is again attempted by function
'get_page_from_freelist'=>'buffered_rmqueue' during interrupt. 
Looks like same lock(pa_lock) is allowed to work on same critical 
section multiple times in the calltrace which can result in
undefined behaviour.  

=> p (( struct local_irq_lock *) 0xffff88023fd11580)->nestcnt
$5 = 1               ----------> nested local_irq_lock is set

I will also try to reproduce this issue with latest upstream next week
after I come back from vacation. But code looks same.

If I am thinking in right direction, Could you please share your thoughts.

Thanks,
Pankaj


> 
> >Best regards,
> >Pankaj
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
