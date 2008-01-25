From: Markus Mathes <mathes@Mathematik.Uni-Marburg.de>
Subject: Real-time Linux Installation Verification and Benchmark
Date: Fri, 25 Jan 2008 14:22:39 +0100
Message-ID: <4799E29F.6080808@informatik.uni-marburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pc12577.Mathematik.Uni-Marburg.DE ([137.248.123.2]:47500 "EHLO
	mailhost.Mathematik.Uni-Marburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753791AbYAYNWs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 08:22:48 -0500
Received: from [137.248.121.203] (pc12756 [137.248.121.203])
	by mailhost.Mathematik.Uni-Marburg.de (8.13.8/8.13.8) with ESMTP id m0PDMkjb021823
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jan 2008 14:22:46 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, there!

I have installed the RT_PREEMPT patch v2.6.23.11-rt4 and now try to 
verify my installation. Therefore I used cyclictest with clock_nanosleep 
and clock_monotonic options for 5-50 threads. The results are shown below:

#Threads  Minimum (microsec)  Average (microsec)  Maximum (microsec)
5         5                   6                   45
10        4                   5                   31
15        5                   5                   33
20        4                   6                   37
25        5                   6                   52
30        5                   6                   63
35        5                   6                   71
40        6                   6                   62
45        5                   6                   88
50        5                   7                   96

An Intel Pentium 4, 2.8GHz clock speed with 1GB main memory was used for 
the benchmark.

Now my questions:
1. The maximum thread latency does not scale linear. Why?

2. RT is a synonym for determinism, but the maximum latency for each 
number of threads fluctuate in each repetition of the benchmark. 
Therefore I guess that no worst-case delay can be predicted, right?

3. Does RT-Linux support hard real-time at all? With the results shown 
above, only soft real-time is supported (deadline 6us).

4. How can I verify - if at all - that my installation supports soft 
real-time or better hard real-time?


Thanks for your help!

Markus
