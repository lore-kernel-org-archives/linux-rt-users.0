From: Gaye Abdoulaye Walsimou <walsimou@walsimou.com>
Subject: Re: compile error for mips with 2.6.29.2-rt10
Date: Fri, 01 May 2009 23:35:33 +0200
Message-ID: <49FB6B25.8000907@walsimou.com>
References: <49FB2619.7070608@walsimou.com> <alpine.LFD.2.00.0905012310210.3375@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from walscop001.walsimou.com ([82.228.201.70]:61438 "EHLO
	bekkor.walsimou.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbZEAVfg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 May 2009 17:35:36 -0400
In-Reply-To: <alpine.LFD.2.00.0905012310210.3375@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Fri, 1 May 2009, Gaye Abdoulaye Walsimou wrote:
>
>   
>> Hello list,
>> I use 2.6.29.2-rt10 patch on linux-2.6.29.2 (from linux-mips.org and for
>> bcm47xx MCU) and I had following compilation error:
>>
>> kernel/sched.c: In function 'finish_task_switch':
>> kernel/sched.c:2902: error: implicit declaration of function
>> '_finish_arch_switch'
>> make[1]: *** [kernel/sched.o] Error 1
>> make: *** [kernel] Error 2
>>
>> When I change "_finish_arch_switch" to "finish_arch_switch" in
>> kernel/sched.c, no compilation error, but I didn't try resulting vmlinux.
>>
>> Do I miss something?
>>     
>
> Yes. 
>
> http://lkml.org/lkml/2009/2/11/405
>
>   
>> The patch is working on x86 (32 and 64bit) but we have not yet
>> updated ARM, PPC and MIPS (work in progress).
>>     
>
> This is still true for MIPS , but we are working on it and hopefully
> one of the next preempt-rt releases will have MIPS support again. Stay
> tuned.
>
> Thanks,
>
> 	tglx
>   

Thanks Thomas for information.
