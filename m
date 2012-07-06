From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 13:32:24 -0400
Message-ID: <4FF72128.2070804@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58411 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab2GFRc3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 13:32:29 -0400
Received: by eaak11 with SMTP id k11so3741332eaa.19
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Jul 2012 10:32:28 -0700 (PDT)
In-Reply-To: <4FF68396.2010904@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I think I narrowed down this problem a little bit.

When I set RCU_BOOST, it was quite easy to generate cpu stall, but the 
system is not really hung. So I turned off the cpu stall checking by doing

echo "1" > /sys/module/rcutree/parameters/rcu_cpu_stall_suppress

at boot time.

Then I tried to start VMs. Sometime VM started fine, sometime VM hung, I 
need to destroied. When the starting of VM hung, the WCHAN of qemu-kvm 
was wait_rcu_gp. And when I did "virsh destroy id", the VM also hung, 
qemu-kvm was stuck at rcu_barrier. It really has something to do with KVM.

Dong

On 7/6/12 2:20 AM, Dong Liu wrote:
> I can quite reliably trigger this cpu stall error now. Just try to start
> several KVM guests.
>
> It seems the kvm progress uses too much CPU?
>
> Since ps -efl showed that the priority of the kvm kernel thread was -20.
> So I tried,
>
> CONFIG_RCU_BOOST=y
> CONFIG_RCU_BOOST_PRIO=50
> CONFIG_RCU_BOOST_DELAY=500
>
> But I still got the same error :(
>
> Are there any way I can use to narrow down this error?
>
> Is it possible to non-preemptible RCU in PREEMPT_RT kernel? I know it
> will reduce the system's RT performance, but we can make sure the reason
> of this cpu stall error is the preemptible RCU
>
> Thanks,
>
> Dong
>
> On 6/27/12 11:22 PM, Dong Liu wrote:
>> Hi,
>>
>> I'm running 3.4.3-rt11 and 3.2.18-rt29 on a system with Intel I7 860, I
>> noticed that with hyperthread enabled, I'm getting kernel error
>>
>> rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 5, t=60002
>> jiffies)
>>
>> But with hyperthread disabled, no such error.
>>
>> Is preempt_rt not supposed to be used with hyperthread?
>>
>> Thanks,
>>
>> Dong
>>
>> P.S.
>

