From: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Subject: Re: [RFC v0] thermal: Protect schedule flag by raw spin
Date: Mon, 12 May 2014 09:43:28 +0200
Message-ID: <53707BA0.60701@oss.bmw-carit.de>
References: <1397485347-2235-1-git-send-email-daniel.wagner@oss.bmw-carit.de> <20140509120902.GB29014@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52235 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751490AbaELHnc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 May 2014 03:43:32 -0400
In-Reply-To: <20140509120902.GB29014@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On 05/09/2014 02:09 PM, Sebastian Andrzej Siewior wrote:
> * Daniel Wagner | 2014-04-14 16:22:27 [+0200]:
> 
>> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
>> index 7257366..7d0b0ac 100644
>> --- a/drivers/thermal/x86_pkg_temp_thermal.c
>> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
>> @@ -363,16 +363,16 @@ static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
>>   * are in the same interrupt state. So scheduling on any one CPU in
>>   * the package is enough and simply return for others.
>>   */
>> -  spin_lock_irqsave(&pkg_work_lock, flags);
>> +  raw_spin_lock_irqsave(&pkg_work_lock, flags);
>>   ++pkg_interrupt_cnt;
>>   if (unlikely(phy_id > max_phy_id) || unlikely(!pkg_work_scheduled) ||
>>           pkg_work_scheduled[phy_id]) {
>>       disable_pkg_thres_interrupt();
>> -      spin_unlock_irqrestore(&pkg_work_lock, flags);
>> +      raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
>>       return -EINVAL;
>>   }
>>   pkg_work_scheduled[phy_id] = 1;
>> -  spin_unlock_irqrestore(&pkg_work_lock, flags);
>> +  raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
>>
>>   disable_pkg_thres_interrupt();
>>   schedule_delayed_work_on(cpu,
> 
> This doens't work. Since you come out of the hard-irq context you can
> not call schedule_work() here. Currently I don't have any better idea
> than to do something like in "x86/mce: Defer mce wakeups to threads for
> PREEMPT_RT"

I overlooked that one. I tried to avoid using thread for this but it
looks like there isn't a simpler way. I'll do 'x86/mce' version then.

>> @@ -426,19 +426,28 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>> 		goto err_ret_unlock;
>> 	}
>>
>> -	spin_lock_irqsave(&pkg_work_lock, flags);
>> -	if (topology_physical_package_id(cpu) > max_phy_id)
>> +	if (topology_physical_package_id(cpu) > max_phy_id) {
>> 		max_phy_id = topology_physical_package_id(cpu);
> 
> I like this. You shouldn't however modify max_phy_id outside of the
> lock. Besides that it looks good.
> 
>> -	temp = krealloc(pkg_work_scheduled,
>> -			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>> -	if (!temp) {
>> -		spin_unlock_irqrestore(&pkg_work_lock, flags);
>> -		err = -ENOMEM;
>> -		goto err_ret_free;
>> +
>> +		temp = kmalloc((max_phy_id+1) * sizeof(u8), GFP_KERNEL);
>> +		if (!temp) {
>> +			err = -ENOMEM;
>> +			goto err_ret_free;
>> +		}
>> +
>> +		raw_spin_lock_irqsave(&pkg_work_lock, flags);
>> +
>> +		p = pkg_work_scheduled;
>> +
>> +		memcpy(temp, pkg_work_scheduled, ksize(pkg_work_scheduled));
>> +		pkg_work_scheduled = temp;
>> +
>> +		pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
> 
> This seems to be the "init" which needs to be done. Now you skip it if
> you are first called with 4 and later with 3,2,1,0 for instance. Using
> kzalloc() instead of kmalloc() should make it right and avoid the need
> of = 0 here.

Good idea.

>> +
>> +		raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
>> +
>> +		kfree(p);
>> 	}
>> -	pkg_work_scheduled = temp;
>> -	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
>> -	spin_unlock_irqrestore(&pkg_work_lock, flags);
>>
>> 	phy_dev_entry->phys_proc_id = topology_physical_package_id(cpu);
>> 	phy_dev_entry->first_cpu = cpu;
> 
> Sebastian
> 

Thanks a lot for the review.

cheers,
daniel
