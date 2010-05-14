From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Fri, 14 May 2010 11:34:47 +0200
Message-ID: <4BED1937.6080907@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61402 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab0ENKXw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 06:23:52 -0400
In-Reply-To: <20100513175842.GN6055@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robert Schwebel wrote:
> On Thu, May 13, 2010 at 10:01:12AM +0200, Armin Steinhoff wrote:
>   
>> I did a test with user space based CAN driver.
>>     
> The Linux CAN interface is SocketCAN. Do you see a usecase where this
> doesn't fit?
>   

IMHO, the SocketCAN interface is simply an overkill for the handling of
small CAN messages.
I estimate that the  amount of executed code for handling of a single
CAN frame is much bigger as the frame itself :)
Every read and write action creates context switches ...

This is not the case with the user space based driver.  Same story with
our PROFIBUS-DP drivers ...

>> Already the standard distribution of SUSE 11.2 (non RT) was able to
>> handle 1000 frames per seconds sent by a QNX6 machine !!
>>     
>
> Realtime != fast.
>   

But a small response time is a technological requirement in order to
meet deadlines.
The standard kernel is a _good base_ in order to implement predictive
behavior ... this would not the case if the response time would be in
the range of 100us.
OK ... you can have real-time behavior with a response time of 100us ..
but this would be useless for most real-time applications.

>> The latency test of PREEMPT_RT shows a latency of ~10us for a
>> dual-core box at 1.8GHz.
>>     
>
> It depends on the load.
>   

It depends on the load and the used priorities.

--Armin


