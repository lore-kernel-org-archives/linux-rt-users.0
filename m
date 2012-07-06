From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 13:40:22 +0200
Message-ID: <4FF6CEA6.6080900@osadl.org>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:43150 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933685Ab2GFLkx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 07:40:53 -0400
In-Reply-To: <4FF68396.2010904@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Dong,

> I can quite reliably trigger this cpu stall error now. Just try to start
> several KVM guests.
Good. BTW, we do repeated long-term tests 14 times per day with a single 
kvm guest that runs on two cores and conducts a number of CPU 
benchmarks. (https://www.osadl.org/?id=931) - never had this problem. So 
it may be related to running more than a single kvm guest.

>[..]
> Are there any way I can use to narrow down this error?
cd /sys/kernel/debug/tracing/
echo 0 >tracing_on
echo 1 >events/enable
echo function >current_tracer
echo 14080 >buffer_size_kb
echo 1 >tracing_on
while true
do
   if dmesg | tail -100 | grep -q "rcu_preempt detected stalls"
   then
     echo 0 >tracing_on
     break
   fi
   sleep 1
done

Then start the kvm quests.

Alternatively, you may use the kernel parameter ftrace_dump_on_oops.

If the problem no longer occurs or behaves differently, try to reduce 
the debug output step be step, e.g. disable less important events and 
specify selected available_filter_functions in set_ftrace_filter.

When the problem can be reproduced and the system stalls the way you 
observed earlier, enter

cat trace >/tmp/trace.txt

and try to find out what is going on. If you need help, compress the trace

bzip2 trace.txt

upload trace.txt.bz2 to the Internet for inspection and post the related 
URL.

	-Carsten.
