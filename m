From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Thu, 18 Oct 2007 18:56:14 +0530
Message-ID: <20071018132614.GB22282@in.ibm.com>
References: <20071018124827.GA22282@in.ibm.com> <20071018.055242.115933276.davem@davemloft.net>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="t0UkRYy7tHLRMCai"
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	ghaskins@novell.com, mingo@elte.hu, dino@in.ibm.com,
	dvhltc@us.ibm.com, kravetz@us.ibm.com
To: David Miller <davem@davemloft.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP05.au.ibm.com ([202.81.18.174]:45711 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbXJRN2H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 09:28:07 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9IDS5Kh010528
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 23:28:05 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9IDUPUI133352
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 23:30:25 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9IDQWri011841
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 23:26:34 +1000
Content-Disposition: inline
In-Reply-To: <20071018.055242.115933276.davem@davemloft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

On Thu, Oct 18, 2007 at 05:52:42AM -0700, David Miller wrote:
> From: ankita@in.ibm.com (Ankita Garg)
> Date: Thu, 18 Oct 2007 18:18:27 +0530
> 
> > Any thoughts on where in the code could these large latencies be
> > attributed to?
> 
> If the max latency is usually the first one, it's could be the page
> fault the signal handler is taking the first time it is executed.

Thanks for looking into this. Attaching the entire log from the testrun.
It indicates that in each run of the 10000 iterations, there are about 100+
failures, with large iterations. Also, on intrumenting the testcode to
find out the iterations which see large latencies, I see that as the
number of iterations increase, the latencies increase.

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="output.log"

jvmsim disabled




Max Time: 52.23 us, Min Time: 7.54 us
Average Time = 11.22 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 111
FAIL

jvmsim disabled




Max Time: 37.99 us, Min Time: 7.26 us
Average Time = 11.66 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 91
FAIL

jvmsim disabled




Max Time: 60.05 us, Min Time: 7.26 us
Average Time = 11.37 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 107
FAIL

jvmsim disabled




Max Time: 51.67 us, Min Time: 7.26 us
Average Time = 11.42 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 103
FAIL

jvmsim disabled




Max Time: 43.30 us, Min Time: 7.26 us
Average Time = 12.35 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 103
FAIL

jvmsim disabled




Max Time: 48.88 us, Min Time: 7.26 us
Average Time = 11.15 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 130
FAIL

jvmsim disabled




Max Time: 40.22 us, Min Time: 5.03 us
Average Time = 11.30 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 140
FAIL

jvmsim disabled




Max Time: 37.99 us, Min Time: 7.26 us
Average Time = 12.15 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 86
FAIL

jvmsim disabled




Max Time: 53.35 us, Min Time: 6.98 us
Average Time = 11.41 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 99
FAIL

jvmsim disabled




Max Time: 38.27 us, Min Time: 7.26 us
Average Time = 11.91 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 96
FAIL

jvmsim disabled




Max Time: 39.66 us, Min Time: 6.98 us
Average Time = 12.32 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 98
FAIL

jvmsim disabled




Max Time: 37.71 us, Min Time: 7.26 us
Average Time = 11.83 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 92
FAIL

jvmsim disabled




Max Time: 54.19 us, Min Time: 6.98 us
Average Time = 10.96 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 94
FAIL

jvmsim disabled




Max Time: 46.65 us, Min Time: 6.98 us
Average Time = 11.49 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 149
FAIL

jvmsim disabled




Max Time: 39.66 us, Min Time: 7.26 us
Average Time = 11.56 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 112
FAIL

jvmsim disabled




Max Time: 42.74 us, Min Time: 6.98 us
Average Time = 12.65 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 100
FAIL

jvmsim disabled




Max Time: 40.22 us, Min Time: 7.26 us
Average Time = 11.99 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 73
FAIL

jvmsim disabled




Max Time: 42.74 us, Min Time: 6.70 us
Average Time = 11.57 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 105
FAIL

jvmsim disabled




Max Time: 42.18 us, Min Time: 6.42 us
Average Time = 11.03 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 117
FAIL

jvmsim disabled




Max Time: 46.09 us, Min Time: 6.98 us
Average Time = 11.17 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 107
FAIL

jvmsim disabled




Max Time: 39.11 us, Min Time: 7.26 us
Average Time = 11.42 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 93
FAIL

jvmsim disabled




Max Time: 53.35 us, Min Time: 7.26 us
Average Time = 12.15 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 88
FAIL

jvmsim disabled




Max Time: 39.10 us, Min Time: 5.03 us
Average Time = 12.90 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 107
FAIL

jvmsim disabled




Max Time: 53.35 us, Min Time: 6.98 us
Average Time = 11.47 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 97
FAIL

jvmsim disabled




Max Time: 40.22 us, Min Time: 6.98 us
Average Time = 11.33 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 120
FAIL

jvmsim disabled




Max Time: 60.89 us, Min Time: 6.98 us
Average Time = 11.53 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 116
FAIL

jvmsim disabled




Max Time: 44.97 us, Min Time: 7.54 us
Average Time = 12.10 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 110
FAIL

jvmsim disabled




Max Time: 48.88 us, Min Time: 6.98 us
Average Time = 11.31 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 129
FAIL

jvmsim disabled




Max Time: 57.26 us, Min Time: 7.26 us
Average Time = 11.20 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 121
FAIL

jvmsim disabled




Max Time: 46.93 us, Min Time: 7.26 us
Average Time = 11.78 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 165
FAIL

jvmsim disabled




Max Time: 45.53 us, Min Time: 6.98 us
Average Time = 12.33 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 112
FAIL

jvmsim disabled




Max Time: 43.57 us, Min Time: 7.26 us
Average Time = 11.84 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 107
FAIL

jvmsim disabled




Max Time: 41.06 us, Min Time: 7.26 us
Average Time = 11.16 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 74
FAIL

jvmsim disabled




Max Time: 41.90 us, Min Time: 7.26 us
Average Time = 12.46 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 91
FAIL

jvmsim disabled




Max Time: 40.22 us, Min Time: 6.98 us
Average Time = 11.18 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 81
FAIL

jvmsim disabled




Max Time: 41.06 us, Min Time: 6.98 us
Average Time = 12.53 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 89
FAIL

jvmsim disabled




Max Time: 38.83 us, Min Time: 7.54 us
Average Time = 11.81 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 143
FAIL

jvmsim disabled




Max Time: 42.74 us, Min Time: 7.26 us
Average Time = 11.45 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 122
FAIL

jvmsim disabled




Max Time: 42.18 us, Min Time: 7.26 us
Average Time = 12.45 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 82
FAIL

jvmsim disabled




Max Time: 61.17 us, Min Time: 7.26 us
Average Time = 12.05 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 142
FAIL

jvmsim disabled




Max Time: 37.71 us, Min Time: 7.54 us
Average Time = 11.79 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 142
FAIL

jvmsim disabled




Max Time: 65.08 us, Min Time: 6.98 us
Average Time = 11.24 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 116
FAIL

jvmsim disabled




Max Time: 40.78 us, Min Time: 7.26 us
Average Time = 12.71 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 80
FAIL

jvmsim disabled




Max Time: 38.55 us, Min Time: 6.98 us
Average Time = 12.21 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 104
FAIL

jvmsim disabled




Max Time: 38.55 us, Min Time: 7.26 us
Average Time = 12.65 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 79
FAIL

jvmsim disabled




Max Time: 40.22 us, Min Time: 7.26 us
Average Time = 12.71 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 65
FAIL

jvmsim disabled




Max Time: 45.25 us, Min Time: 7.26 us
Average Time = 11.72 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 79
FAIL

jvmsim disabled




Max Time: 43.30 us, Min Time: 7.26 us
Average Time = 11.61 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 77
FAIL

jvmsim disabled




Max Time: 39.38 us, Min Time: 6.98 us
Average Time = 11.88 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 105
FAIL

jvmsim disabled




Max Time: 40.78 us, Min Time: 7.54 us
Average Time = 12.22 us
Criteria for Passing Test: Max Time < 20000 us
No of Loops: 10000
No of Failures: 137
FAIL


--t0UkRYy7tHLRMCai--
