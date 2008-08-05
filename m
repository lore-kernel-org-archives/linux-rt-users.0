From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Subject: Newbie: LPPTEST script question
Date: Tue, 5 Aug 2008 16:46:25 -0700
Message-ID: <BAY107-W4544F2F5847AD770F5AF52BA7B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bay0-omc1-s7.bay0.hotmail.com ([65.54.246.79]:25677 "EHLO
	bay0-omc1-s7.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757111AbYHEXwg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Aug 2008 19:52:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

I am planning to benchmark the performance of my AMD GEODE LX platform with CONFIG_PREEMPT_PATCH. I am planning to do this with LPPTEST utility that comes the patch.

My question is: For how long should I run the testlpp script in order to get the maximum latency? Right now I ran the testlpp for 15 mins. from my source machine and the max latency that it recorded for the my target system was around 677 usecs with 100% CPU load.

Below is a part of the output:

new max latency: 13.36 usecs (6681 cycles)
new max latency: 33.11 usecs (16555 cycles)
new max latency: 44.66 usecs (22330 cycles)
new max latency: 156.87 usecs (78430 cycles)
new max latency: 221.22 usecs (110605 cycles)
new max latency: 386.23 usecs (193105 cycles)
new max latency: 427.48 usecs (213730 cycles)
new max latency: 450.58 usecs (225280 cycles)
new max latency: 618.89 usecs (309430 cycles)
new max latency: 640.34 usecs (320155 cycles)
new max latency: 677.19 usecs (338575 cycles)
[ interrupted - exiting ]

total number of responses: 390755
average reponse latency:   12.70 usecs
minimum latency:           1.71 usecs
maximum latency:           677.19 usecs
LPP latency histogram:
  1 usecs:        22
  8 usecs:      2690
  9 usecs:      1325
.............................
.............................
.............................

I wonder if I run it for an entire day my max. latency would increase?

Thanks

Kushal Koolwal



_________________________________________________________________
Get Windows Live and get whatever you need, wherever you are.  Start here.
http://www.windowslive.com/default.html?ocid=TXT_TAGLM_WL_Home_082008