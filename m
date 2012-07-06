From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 02:20:06 -0400
Message-ID: <4FF68396.2010904@gmail.com>
References: <4FEBCDDE.60503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:45325 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab2GFGUK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 02:20:10 -0400
Received: by qaas11 with SMTP id s11so244597qaa.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jul 2012 23:20:09 -0700 (PDT)
In-Reply-To: <4FEBCDDE.60503@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I can quite reliably trigger this cpu stall error now. Just try to start 
several KVM guests.

It seems the kvm progress uses too much CPU?

Since ps -efl showed that the priority of the kvm kernel thread was -20. 
So I tried,

CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_PRIO=50
CONFIG_RCU_BOOST_DELAY=500

But I still got the same error :(

Are there any way I can use to narrow down this error?

Is it possible to non-preemptible RCU in PREEMPT_RT kernel? I know it 
will reduce the system's RT performance, but we can make sure the reason 
of this cpu stall error is the preemptible RCU

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

