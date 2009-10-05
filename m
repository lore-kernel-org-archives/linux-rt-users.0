From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: Problems with FTrace
Date: Mon, 05 Oct 2009 08:58:34 +0530
Message-ID: <4AC967E2.5070907@linux.vnet.ibm.com>
References: <6f2879e10909280832x3e5fadebha9b2966495812da8@mail.gmail.com>
Reply-To: gowrishankar.m@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Paolo <prallo@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:48232 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758292AbZJED3T (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Oct 2009 23:29:19 -0400
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n953Ih6Q023786
	for <linux-rt-users@vger.kernel.org>; Mon, 5 Oct 2009 14:18:43 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n953QEnn979120
	for <linux-rt-users@vger.kernel.org>; Mon, 5 Oct 2009 14:26:16 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id n953ScLR011855
	for <linux-rt-users@vger.kernel.org>; Mon, 5 Oct 2009 14:28:39 +1100
In-Reply-To: <6f2879e10909280832x3e5fadebha9b2966495812da8@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paolo,

Paolo wrote:
> I need to know if a task is periodic or not and other informations (as
> the duration). I used the sched_switch function of ftrace to trace
> this behaviour.
> In order to have a proof of the tracing I used the cyclictest program.
> 
> The first time I tested the tracing goddness with a single cpu and the
> second time with all cpu online (2).
> In the first call the times was correct, in the second not: the
> periodicity of the cyclictask doesn't seem correct.
> 
> The periodicity is the interval between two wakes up of the same task
> and has to be  more or less constant, right?
> The difference between two wakes up in my test (with 2 cpu) is not
> constant, and the misured time is very different from the time set.
> 

I suspect if sirq-timer is taking up the chance to slightly disturb the
periodicity. To confirm more, you can try with sched_switch visualizer

http://www.osadl.org/Visualize-the-temporal-relationship-of-L.taks-visualizer.0.html

Thanks,
Gowri

> The test was:
> 
> mount -t debugfs nodev /tmp
> 
> echo nop > /tmp/tracing/current_tracer
> echo 1 > /tmp/tracing/tracing_enabled
> echo 0 > /tmp/tracing/tracing_enabled
> 
> echo sched_switch > /tmp/tracing/current_tracer
> echo 1 > /tmp/tracing/tracing_enabled
> 
> ./cyclictest -l 1000 -i 500 -n -t1
> 
> echo 0 > /tmp/tracing/tracing_enabled
> 
> The trace file shows (cat trace | grep + | grep 5036, where 5036 is
> the pid of the cyclictest thread):
> ...
>           <idle>-0     [001]   174.705470:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.705559:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.705648:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.705738:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.705966:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.706056:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.706500:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.706999:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.707505:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.707602:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.707691:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.707781:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.707868:      0:140:R   + [001]  5036:120:S
>           <idle>-0     [001]   174.707957:      0:140:R   + [001]  5036:120:S
> ...
> 
> Maybe I didn't set correctly the parameter of cyclictest and/or sched_switch.
> Is it possible a bug? Notice I use the 2.6.29.rc6 kernel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

