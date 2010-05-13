From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Thu, 13 May 2010 10:07:57 +0200
Message-ID: <4BEBB35D.6080004@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEAFB7E.90304@steinhoff.de> <4BEB5569.3040008@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50000 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0EMI4z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 04:56:55 -0400
In-Reply-To: <4BEB5569.3040008@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nivedita Singhvi wrote:
> Armin Steinhoff wrote:
>
>>> If tuned properly, PREEMPT_RT can easily handle 1ms requirements. On a
>>> standard x86 CPU (we support others than x86) our goal is never to be
>>>   
>>
>> I did a test with user space based CAN driver.
>> Already the standard distribution of SUSE 11.2 (non RT) was able to 
>> handle 1000 frames per seconds sent by a QNX6 machine !!
>
> If your requirements are "never to exceed" a certain latency,
> I highly recommend you run tests for long-durations, rather
> than a short period. A 10-min or even a 1 hour run will not
> give you a full idea as a 24-72 hour run will.

The test was running for more than 12 hours. That's the typical test 
before the software will be released.

>
>> The PREEMPT_RT version of SUSE 11.2 is much, much faster :-)
>>> over 100us in reaction time.
>>>   
>>
>> The latency test of PREEMPT_RT shows a latency of ~10us for a 
>> dual-core box at 1.8GHz.
>
> Are you using cyclictest? And how long did you run it for?

Several hours ...

--Armin

PS: my initial post has been posted again because of internet problems, 
sorry.

