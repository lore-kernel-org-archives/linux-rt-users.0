From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: Newbie question about profiling.
Date: Thu, 23 Sep 2010 22:45:05 +0530
Message-ID: <4C9B8B19.5050205@linux.vnet.ibm.com>
References: <AANLkTi=6NUEod+pFZPhyZL0v8C-v1iMvQDZnuKgWxj9E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:44184 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab0IWRPM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Sep 2010 13:15:12 -0400
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id o8NHF8in013680
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 22:45:08 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8NHF8cK4300924
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 22:45:08 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8NHF7Ps002071
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 22:45:07 +0530
In-Reply-To: <AANLkTi=6NUEod+pFZPhyZL0v8C-v1iMvQDZnuKgWxj9E@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 23 September 2010 08:12 PM, Lars Segerlund wrote:
>   Hello,
>
>   I am fairly new to RT Preempt, but now to realtime embedded systems=
=2E
> I am trying to get EMC2 running on RT Preempt, and I was given some
> old patches on the mailing list which miracously worked.
>
>   From here I am trying to get a complete system built from scratch
> with 'latest' RT Preempt and EMC2.
>
>   My question is how to go about finding out what causes latencies an=
d
> jitter, I have no problem to create some code to benchmark latencies
> or jitter, but how do I find out where the kernel is spending it's
> time ?
>
>   =20
Hi,
You can start with RT functional testcases which are already available
in LTP (https://rt.wiki.kernel.org/index.php/LTP%28Realtime_Test_Tree%2=
9)

If you find tests failing for some reason, then it can be good place to=
=20
start
investigating with the help of kernel inbuilt tracing tool (ftrace) whe=
re
you have options to trace particular subsystem (irqoff, preemptoff,=20
wakeup..)
Check kernel Documentation/trace/ftrace.txt.

Thanks,
Gowrishankar
>   Any hints would be much appreciated, since i really don't have a cl=
ue
> on how to go about this.
>
>   I was thinking that if I could create a realtime task to test for a
> specific thing, I really would like a log of what the kernal was doin=
g
> right before this.
>   The only way I can think of is creating a module with a ring buffer=
 (
> spill over ), and tracing the scheduler or interrupt handler .... ( b=
y
> hack=EDng some code to specifically do this ), this would only add a
> small overhead AFAIK.
>
>   Any idea's anyone ? or hints ?
>
>   It seem's like just the thing that already might have a solution in
> place, so I figured I should not reinvent the wheel.
>
>   / best regards, Lars Segerlund.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   =20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
