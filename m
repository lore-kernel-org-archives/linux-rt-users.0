From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RT]adjtimex gives wrong number of ticks (fwd)
Date: Fri, 30 Sep 2011 14:04:13 -0700
Message-ID: <1317416653.3112.898.camel@work-vm>
References: <alpine.LFD.2.02.1109302241560.2711@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dennis Borgmann <dennis.borgmann@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55468 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab1I3VF0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Sep 2011 17:05:26 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8UKYKvh025364
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2011 16:34:20 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p8UL5OPB266288
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2011 17:05:25 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p8UL5NbE009329
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2011 15:05:23 -0600
In-Reply-To: <alpine.LFD.2.02.1109302241560.2711@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> ---------- Forwarded message ----------
> Date: Thu, 29 Sep 2011 14:42:45 +0200
> From: Dennis Borgmann <dennis.borgmann@googlemail.com>
> To: linux-rt-users@vger.kernel.org
> Subject: [RT]adjtimex gives wrong number of ticks
> 
> Hello RT-users!
> 
> I am observing strange behaviour regarding CONFIG_HZ on various machines, while
> trying to adjust the tickrate of some systems. I found, that adjtimex(2) is not
> behaving the way it should. If I write a simple program like this:
> 
> #include <stdio.h>
> #include <sys/timex.h>
> int main() {
>     struct timex t;
>     adjtimex(&t);
>     printf("%ld\n",t.tick);
> }
> 
> , which simply is to print the time in usec between two kernel ticks, the output
> makes no sense. On a RT-System with CONFIG_HZ=1000, the output is "10000" and on
> a non-RT system with CONFIG_HZ=250 (my desktop-laptop), the output is "9999" -
> almost the same.
> 
> If I calculate correctly, it should be 1000 with CONFIG_HZ and 4000 with
> CONFIG_HZ=250.
> 
> Am i wrong, or is this an error?
> 
> Btw: adjtimex with a tick of of 1000 gives me this:
> 
> root@ap:/tmp# adjtimex --tick 1000
> adjtimex: Invalid argument
> for this kernel:
>    USER_HZ = 100 (nominally 100 ticks per second)
>    9000 <= tick <= 11000
>    -32768000 <= frequency <= 32768000
> 
> on the RT-system with CONFIG_HZ=1000. This is also odd - it should print
> "USER_HZ=1000" and not "USER_HZ=100".
> 
> Strange... Any ideas?

So USER_HZ is always 100 (atleast on x86 and X86_64 systems).

Its a architecture specific constant that allows the kernel to keep a
consistent ABI to userspace regardless of what the internal
configuration of the kernel is.

So the kernel will take adjustments to the tick value via adjtimex and
scale them appropriately to the internal HZ value before applying it.

So while you may be running with HZ=250 or HZ=1000, the kernel
interfaces that expose "ticks" will always use USER_HZ (100) based
ticks.

thanks
-john




