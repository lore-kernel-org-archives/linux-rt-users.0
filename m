From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Scheduling behaviour of 23-rc4-rt1 on my intel centrino Duo.
Date: Thu, 4 Oct 2007 15:10:53 -0700
Message-ID: <200710041510.53372.dvhltc@us.ibm.com>
References: <34ac6d890709251935x390bee54ma761ed05f73d95a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Girish kathalagiri" <girish.sk@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44524 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757975AbXJDWKz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Oct 2007 18:10:55 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l94MAshq017067
	for <linux-rt-users@vger.kernel.org>; Thu, 4 Oct 2007 18:10:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l94MAsU7693498
	for <linux-rt-users@vger.kernel.org>; Thu, 4 Oct 2007 18:10:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l94MAs3F029548
	for <linux-rt-users@vger.kernel.org>; Thu, 4 Oct 2007 18:10:54 -0400
In-Reply-To: <34ac6d890709251935x390bee54ma761ed05f73d95a1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 25 September 2007 19:35:35 Girish kathalagiri wrote:
> Hi,
> I am running Linux 2.6.21-rc4-rt1 on my IBM thinkpad T60 (I have
> attached the cpuinfo).
> When i run the hourglass ( http://www.cs.utah.edu/~regehr/hourglass/)
> ,6 threads each of priority RTHIGH (maxpriority-2).
> Only one thread (thread 0) seems to be running on cpu#0, all the other
> thread seems to be competing with each other on cpu#1.
>
> command : ./hourglass -n 6 -a -d 60s -w CPU -i HR -p RTHIGH
> here is a part of output from the hourglass test
> ----------------------------------------------------------
> thread 0 will use high-res timers
> thread 1 will use high-res timers
> thread 2 will use high-res timers
> thread 3 will use high-res timers
> thread 4 will use high-res timers
> thread 5 will use high-res timers
> thread 0 will have priority RTHIGH
> thread 1 will have priority RTHIGH
> thread 2 will have priority RTHIGH
> thread 3 will have priority RTHIGH
> thread 4 will have priority RTHIGH
> thread 5 will have priority RTHIGH
> 8.010864 MB allocated for trace records
> Hourglass 1.0.1b : 6 threads; 60.000000 seconds; 1828.999688 MHz
> timestamp counter
> max gap is 63980 cycles
> this test will last for  60.000000 seconds
> numthreads: 6
> work done by thrd 0 : 430394547
> work done by thrd 1 : 42208618
> work done by thrd 2 : 86995526
> work done by thrd 3 : 86819711
> work done by thrd 4 : 86887798
> work done by thrd 5 : 86101724
>
> thread 0 recorded 60.040444 seconds (99.999946 %)
> thread 1 recorded 12.037532 seconds (20.049028 %)
>  thread 2 recorded 12.030190 seconds (20.036800 %)
> thread 3 recorded 12.005801 seconds (19.996179 %)
>  thread 4 recorded 12.015195 seconds (20.011824 %)
> thread 5 recorded 11.907206 seconds (19.831964 %)
> 
> ---------------------------------------------------------------------------
>----
>
> Should not the threads be schedule fairly between the two cpu's, like
> say ,3 threads competing for cpu#0 and other 3 for cpu#1 ?
>  Or Am i missing something here ?

1) How are you determining which CPUs these threads spend their time on?
2) RTHIGH doesn't do anything for us.  What is the value of the SCHED_FIFO 
priority those threads run at?  Is it the same for every one?

Note that depending on exactly what those threads do (I am unfamiliar with the 
hourglass testcase) it isn't unreasonable for them to all run on the same CPU 
if their runnable/sleeping states happen to line up just right.  It is also 
very possible that they bounce around from CPU to CPU in rapid succession if 
the runnable/sleeping windows overlap in exactly the wrong way :-)


-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
