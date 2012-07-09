From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Mon, 09 Jul 2012 00:33:53 -0400
Message-ID: <4FFA5F31.4030309@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com> <4FF6CEA6.6080900@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Carsten Emde <C.Emde@osadl.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64458 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2GIEdx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2012 00:33:53 -0400
Received: by qcro28 with SMTP id o28so6473801qcr.19
        for <linux-rt-users@vger.kernel.org>; Sun, 08 Jul 2012 21:33:52 -0700 (PDT)
In-Reply-To: <4FF6CEA6.6080900@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

I tried your approach, just need to remove tail -100 in order to grep 
the stall line.

I captured 4 seconds of tracing, so the place triggered cpu stall should 
be in it. But I didn't find function print_cpu_stall :( And I'm not sure 
what to look for.

The capture is quite large, here is the URL for the kernel  trace

http://192.11.154.97:3333/project/trace-out.txt.bz2

And here is the URL for kernel's .config

http://192.11.154.97:3333/project/config-3.2.18-1.el6.preempt_rt.x86_64-rt29

Could someone help me to take a look at them?

Again, I have intel i7 with Hyper-Threading, so the cpu has 8 logical 
cores. I'm running 3.2.18-rt29 on CentOS 6.2. When I start KVM guest, 
I'll get rcu_preempt detected stalls.

Thanks,

Dong

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
>
> Then start the kvm quests.
>
> Alternatively, you may use the kernel parameter ftrace_dump_on_oops.
>
> If the problem no longer occurs or behaves differently, try to reduce
> the debug output step be step, e.g. disable less important events and
> specify selected available_filter_functions in set_ftrace_filter.
>
> When the problem can be reproduced and the system stalls the way you
> observed earlier, enter
>
> cat trace >/tmp/trace.txt
>
> and try to find out what is going on. If you need help, compress the trace
>
> bzip2 trace.txt
>
> upload trace.txt.bz2 to the Internet for inspection and post the related
> URL.
>
> -Carsten.

