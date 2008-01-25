From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Real-time Linux Installation Verification and Benchmark
Date: Fri, 25 Jan 2008 11:47:50 -0200
Message-ID: <20080125134750.GL11658@unix.sh>
References: <4799E29F.6080808@informatik.uni-marburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Markus Mathes <mathes@Mathematik.Uni-Marburg.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sr06-04.mta.terra.com.br ([200.154.152.73]:59362 "EHLO
	sr06-04.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbYAYNry (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 08:47:54 -0500
Content-Disposition: inline
In-Reply-To: <4799E29F.6080808@informatik.uni-marburg.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 25, 2008 at 02:22:39PM +0100, Markus Mathes wrote:
> Hi, there!
>
> I have installed the RT_PREEMPT patch v2.6.23.11-rt4 and now try to verify 
> my installation. Therefore I used cyclictest with clock_nanosleep and 
> clock_monotonic options for 5-50 threads. The results are shown below:
>
> #Threads  Minimum (microsec)  Average (microsec)  Maximum (microsec)
> 5         5                   6                   45
> 10        4                   5                   31
> 15        5                   5                   33
> 20        4                   6                   37
> 25        5                   6                   52
> 30        5                   6                   63
> 35        5                   6                   71
> 40        6                   6                   62
> 45        5                   6                   88
> 50        5                   7                   96
>
> An Intel Pentium 4, 2.8GHz clock speed with 1GB main memory was used for 
> the benchmark.
>
> Now my questions:
> 1. The maximum thread latency does not scale linear. Why?

You haven't mentioned that, so I guess you didn't use higher rt priotities
in your tests. Did you? 

If not, please try repeating your tests with priorities like 50, 80 and 96. 
That should give you better results.

> 2. RT is a synonym for determinism, but the maximum latency for each number 
> of threads fluctuate in each repetition of the benchmark. Therefore I guess 
> that no worst-case delay can be predicted, right?
>
> 3. Does RT-Linux support hard real-time at all? With the results shown 
> above, only soft real-time is supported (deadline 6us).

That depends on which definition of hard realtime are you using. I gave up
on this terminology since my Fault Tolerance classes, given the wide range
of meanings it gained on the press the last few years.

> 4. How can I verify - if at all - that my installation supports soft 
> real-time or better hard real-time?
>
>
> Thanks for your help!
>
> Markus

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
