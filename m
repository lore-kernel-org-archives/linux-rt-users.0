From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v1][PATCH] cpu_down: move migrate_enable() back
Date: Fri, 15 Nov 2013 10:31:54 +0100
Message-ID: <20131115093154.GA12164@linutronix.de>
References: <1383789967-5885-1-git-send-email-tiejun.chen@windriver.com>
 <5280F8A7.4070608@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tiejun Chen <tiejun.chen@windriver.com>, tglx@linutronix.de,
	stable-rt@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38233 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3KOJb5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Nov 2013 04:31:57 -0500
Content-Disposition: inline
In-Reply-To: <5280F8A7.4070608@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2013-11-11 10:32:55 [-0500]:

>> of preempt_enable() and preempt_disable(), but actually in
>> !CONFIG_PREEMPT_RT_FULL case, migrate_enable()/migrate_disable()
>> are still equal to preempt_enable()/preempt_disable(). So that
>> followed cpu_hotplug_begin()/cpu_unplug_begin(cpu) would go schedule()
>> to trigger schedule_debug() like this:
>> 
>> _cpu_down()
>> 	|
>> 	+ migrate_disable() = preempt_disable()
>> 	|
>> 	+ cpu_hotplug_begin() or cpu_unplug_begin()
>> 		|
>> 		+ schedule()
>> 			|
>> 			+ __schedule()
>> 				|
>> 				+ preempt_disable();
>> 				|
>> 				+ __schedule_bug() is true!
>> 
>> So we should move migrate_enable() as the original scheme.
>
>It is unclear to me what context you are thinking of/referencing
>as the "original scheme"...
I think to what happening before the patch he quoted was applied.

>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -594,6 +594,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>>  		err = -EBUSY;
>>  		goto restore_cpus;
>>  	}
>> +	migrate_enable();
>>  
>
>So, what happens if we now get migrated right here, before the
>hotplug_begin call below?

It should not matter. Before this we call set_cpus_allowed_ptr() to
ensure that current() may run on any CPU except that one we try to bring
down. We call later smp_processor_id() to check if this is correct. The
only reason for the preempt_disable() seems to be to keep
smp_processor_id() quiet and not spill a warning.
Later on we could switch CPUs as long as we don't get on that CPU that is
going down since we don't hold / access any per CPU data. The only
reason where set_cpus_allowed_ptr() might not work as expected is when
user land changes the mask because we don't have PF_NO_SETAFFINITY set.

>P.

Sebastian
