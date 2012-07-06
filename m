From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 12:03:37 -0400
Message-ID: <4FF70C59.40801@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com> <4FF6CEA6.6080900@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64240 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2GFQDi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 12:03:38 -0400
Received: by eeit10 with SMTP id t10so3702475eei.19
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Jul 2012 09:03:37 -0700 (PDT)
In-Reply-To: <4FF6CEA6.6080900@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 7/6/12 7:40 AM, Carsten Emde wrote:
> Hi Dong,
>
>> I can quite reliably trigger this cpu stall error now. Just try to start
>> several KVM guests.
> Good. BTW, we do repeated long-term tests 14 times per day with a single
> kvm guest that runs on two cores and conducts a number of CPU
> benchmarks. (https://www.osadl.org/?id=931) - never had this problem. So
> it may be related to running more than a single kvm guest.
>

I'm using i7 860 with HT enabled. It has 8 logical cores. Maybe it has 
something to do with it.
>> [..]
>> Are there any way I can use to narrow down this error?
> cd /sys/kernel/debug/tracing/
> echo 0 >tracing_on
> echo 1 >events/enable
> echo function >current_tracer
> echo 14080 >buffer_size_kb
> echo 1 >tracing_on
> while true
> do
> if dmesg | tail -100 | grep -q "rcu_preempt detected stalls"
> then
> echo 0 >tracing_on
> break
> fi
> sleep 1
> done

I don't have /sys/kernel/debug/tracing/ directory. The kernel doc says 
turn on CONFIG_KPROBE_TRACING. But I could not find this config.


>
> Then start the kvm quests.
>
> Alternatively, you may use the kernel parameter ftrace_dump_on_oops.
>
I'll try that.

Thanks,

Dong
