From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Tue, 03 Jul 2012 16:10:46 -0400
Message-ID: <4FF351C6.3000100@gmail.com>
References: <4FEBCDDE.60503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44764 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab2GCUKk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jul 2012 16:10:40 -0400
Received: by eaak11 with SMTP id k11so2655555eaa.19
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Jul 2012 13:10:39 -0700 (PDT)
In-Reply-To: <4FEBCDDE.60503@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

After reading the RCU cpu stall doc. I thought that CONFIG_NO_HZ might 
have something to do with this problem. And I think the NO_HZ config is 
not good for RT performance, so I made a new kernel without NO_HZ. It 
lasted longer but eventually cpu stalls happened again.

I then disable the cpu stall checking by set

/sys/module/rcutree/parameters/rcu_cpu_stall_suppress

to "1", but it did not solve the problem. Instead of cpu stall I had

BUG: soft lockup - CPU#0 stuck for 279s! [swapper/0:0]

And even I disabled Hyper-Threading, I also got cpu stall now.

CPU stalls also occurred in KVM guest OS as well.

But I never get cpu stall when I'm running the normal kernel without -rt 
patch.

Is the cpu stall a known issue with the rt patch?

Thanks,

Dong

On 6/27/12 11:22 PM, Dong Liu wrote:
> Hi,
>
> I'm running 3.4.3-rt11 and 3.2.18-rt29 on a system with Intel I7 860, I
> noticed that with hyperthread enabled, I'm getting kernel error
>
> rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 5, t=60002
> jiffies)
>
> But with hyperthread disabled, no such error.
>
> Is preempt_rt not supposed to be used with hyperthread?
>
> Thanks,
>
> Dong
>
> P.S.

