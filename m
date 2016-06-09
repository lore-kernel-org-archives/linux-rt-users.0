From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Query - state of memory hotplug with RT kernel
Date: Thu, 9 Jun 2016 15:05:02 +0200
Message-ID: <20160609130502.GC6305@linutronix.de>
References: <1997236940.56779393.1464861408686.JavaMail.zimbra@redhat.com>
 <420969271.56780563.1464862241604.JavaMail.zimbra@redhat.com>
 <20160603160433.GC4496@linutronix.de>
 <557440847.57840590.1465369514193.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Pankaj Gupta <pagupta@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52426 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbcFINFF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jun 2016 09:05:05 -0400
Content-Disposition: inline
In-Reply-To: <557440847.57840590.1465369514193.JavaMail.zimbra@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Pankaj Gupta | 2016-06-08 03:05:14 [-0400]:

>Hello Sebastian,
Hi Pankaj,

>Sorry! for replying late as I am on vacation this week.

No, you aren't. If you were on vacation you would neither be sorry nor
would you reply at all :)

>> I have been looking into CPU hotplug but got interrupted by v4.6 and a
>> few other things. Regarding memory hotplug, as I said I don't know what
>> is broken. Is this something that can be tested in kvm?
>
>Yes, KVM guest hangs when I tried to hotplug 4 GB of memory.
>When I tried to find root cause of it, I got below calltrace:
>
>//call trace of running task
>
> #0 [ffff8801638ab7e0] get_page_from_freelist at ffffffff81165607
> #1 [ffff8801638ab8d8] cpuacct_charge at ffffffff810b9a61
> #2 [ffff8801638ab908] __switch_to at ffffffff810018b2
> #3 [ffff8801638ab968] __schedule at ffffffff81625984
> #4 [ffff8801638ab9c8] preempt_schedule_irq at ffffffff816264a1
> #5 [ffff8801638ab9f0] retint_kernel at ffffffff81628277
> #6 [ffff8801638aba38] migrate_enable at ffffffff810aa0eb
> #7 [ffff8801638abaa8] __switch_to at ffffffff810018b2
> #8 [ffff8801638abb08] __schedule at ffffffff81625984
> #9 [ffff8801638abb68] preempt_schedule_irq at ffffffff816264a1
>#10 [ffff8801638abb90] retint_kernel at ffffffff81628277
>#11 [ffff8801638abbe8] isolate_pcp_pages at ffffffff81160489
>#12 [ffff8801638abc50] free_hot_cold_page at ffffffff8116463c--------\
>                                     //pa_lock  is used with local_lock_irqsave
>#13 [ffff8801638abcb8] __free_pages at ffffffff811647df
>#14 [ffff8801638abcd8] __online_page_free at ffffffff811b6dcc
>#15 [ffff8801638abce8] generic_online_page at ffffffff811b6e0b
>#16 [ffff8801638abcf8] online_pages_range at ffffffff811b6ce5
>#17 [ffff8801638abd38] walk_system_ram_range at ffffffff8107914c
>#18 [ffff8801638abda8] online_pages at ffffffff81614a84
>#19 [ffff8801638abe20] memory_subsys_online at ffffffff813f1268
>#20 [ffff8801638abe50] device_online at ffffffff813d9745
>#21 [ffff8801638abe78] store_mem_state at ffffffff813f0ef4
>#22 [ffff8801638abea0] dev_attr_store at ffffffff813d6698
>#23 [ffff8801638abeb0] sysfs_write_file at ffffffff81247499
>#24 [ffff8801638abef8] vfs_write at ffffffff811ca7ad
>#25 [ffff8801638abf38] sys_write at ffffffff811cb24f
>#26 [ffff8801638abf80] system_call_fastpath at ffffffff8162fe89

>It looks to me "local_lock_irqsave(pa_lock, flags)" is taken in
>function 'free_hot_cold_page' which is again attempted by function
>'get_page_from_freelist'=>'buffered_rmqueue' during interrupt. 
>Looks like same lock(pa_lock) is allowed to work on same critical 
>section multiple times in the calltrace which can result in
>undefined behaviour.  

The pa_lock is not (or should not be) take with interrupts disabled on -RT.

>=> p (( struct local_irq_lock *) 0xffff88023fd11580)->nestcnt
>$5 = 1               ----------> nested local_irq_lock is set
>
>I will also try to reproduce this issue with latest upstream next week
>after I come back from vacation. But code looks same.
>
>If I am thinking in right direction, Could you please share your thoughts.

So I tried memory hotplug on  v4.6.1-rt3:
|# free -m
|              total        used        free      shared  buff/cache   available
|Mem:            827          67         678           0          80         741
|
|# echo 0 > /sys/bus/memory/devices/memory4/online 
|[  587.028476] Offlined Pages 32768
|[  587.029210] remove from free list 20000 1024 28000
|[  587.030235] remove from free list 20400 1024 28000
|[  587.031174] remove from free list 20800 1024 28000
|[  587.032137] remove from free list 20c00 1024 28000
|[  587.033219] remove from free list 21000 1024 28000
|[  587.034174] remove from free list 21400 1024 28000
|[  587.035109] remove from free list 21800 1024 28000
|[  587.036080] remove from free list 21c00 1024 28000
|[  587.037233] remove from free list 22000 1024 28000
|[  587.038235] remove from free list 22400 1024 28000
|[  587.039217] remove from free list 22800 1024 28000
|[  587.040183] remove from free list 22c00 1024 28000
|[  587.041149] remove from free list 23000 1024 28000
|[  587.042068] remove from free list 23400 1024 28000
|[  587.042957] remove from free list 23800 1024 28000
|[  587.043864] remove from free list 23c00 1024 28000
|[  587.044962] remove from free list 24000 1024 28000
|[  587.046327] remove from free list 24400 1024 28000
|[  587.047705] remove from free list 24800 1024 28000
|[  587.049110] remove from free list 24c00 1024 28000
|[  587.050398] remove from free list 25000 1024 28000
|[  587.051769] remove from free list 25400 1024 28000
|[  587.053206] remove from free list 25800 1024 28000
|[  587.054570] remove from free list 25c00 1024 28000
|[  587.055950] remove from free list 26000 1024 28000
|[  587.057326] remove from free list 26400 1024 28000
|[  587.058630] remove from free list 26800 1024 28000
|[  587.059947] remove from free list 26c00 1024 28000
|[  587.061337] remove from free list 27000 1024 28000
|[  587.062636] remove from free list 27400 1024 28000
|[  587.063970] remove from free list 27800 1024 28000
|[  587.065287] remove from free list 27c00 1024 28000
|# free -m
|              total        used        free      shared  buff/cache   available
|Mem:            699          67         550           0          80         614
|Swap:             0           0           0
|
|# echo 1 > /sys/bus/memory/devices/memory4/online 
|# free -m
|              total        used        free      shared  buff/cache   available
|Mem:            827          68         677           0          80         740
|Swap:             0           0           0

seems to work. I also enabled CONFIG_CGROUP_CPUACCT and tried again and
it still removed & added memory.

>Thanks,
>Pankaj

Sebastian
