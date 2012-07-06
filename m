From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 02:04:47 -0400
Message-ID: <4FF67FFF.4000403@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com> <4FF4C94A.6040105@osadl.org> <4FF5DFDC.9010501@gmail.com> <4FF61D01.9040502@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46700 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2GFGEv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 02:04:51 -0400
Received: by qadb17 with SMTP id b17so240836qad.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jul 2012 23:04:50 -0700 (PDT)
In-Reply-To: <4FF61D01.9040502@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 7/5/12 7:02 PM, Carsten Emde wrote:
> Hi Dong,
>
>> I tried to disable CONFIG_RT_GROUP_SCHED, but I still got cpu stalls!
> Just had another look at your dmesg files. Didn't you get
> BUG: soft lockup - CPU#0 stuck for 279s! [swapper/0:0]
> before? Now - with CONFIG_RT_GROUP_SCHED disabled - you get:
> rcu_preempt detected stalls on CPUs/tasks: { 3} [..]
>
> Is it reproducible? Maybe, there are two different problems. One leads
> to soft lockups and is related to CONFIG_RT_GROUP_SCHED, and another one
> that leads to rcu_preempt stalls.

The "BUG: soft lockup" error  was because I disabled RCU cpu stall 
checking by set

/sys/module/rcutree/parameters/rcu_cpu_stall_suppress

to "1"

I did try this setting after disabled CONFIG_RT_GROUP_SCHED, it didn't 
not print out any kernel error message, but the system did froze when I 
tried to start some KVM guests.

Thanks,

Dong
