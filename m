From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Wed, 12 May 2010 18:27:05 -0700
Message-ID: <4BEB5569.3040008@us.ibm.com>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEAFB7E.90304@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org,
	Asier Tamayo <asier.tamayo@ona-electroerosion.com>,
	linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:34001 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881Ab0EMB1G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 May 2010 21:27:06 -0400
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4D1Nwqa006402
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 19:23:58 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o4D1R659137714
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 19:27:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4D1R5XZ020348
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 19:27:06 -0600
In-Reply-To: <4BEAFB7E.90304@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Armin Steinhoff wrote:

>> If tuned properly, PREEMPT_RT can easily handle 1ms requirements. On a
>> standard x86 CPU (we support others than x86) our goal is never to be
>>   
> 
> I did a test with user space based CAN driver.
> Already the standard distribution of SUSE 11.2 (non RT) was able to 
> handle 1000 frames per seconds sent by a QNX6 machine !!

If your requirements are "never to exceed" a certain latency,
I highly recommend you run tests for long-durations, rather
than a short period. A 10-min or even a 1 hour run will not
give you a full idea as a 24-72 hour run will.

> The PREEMPT_RT version of SUSE 11.2 is much, much faster :-)
>> over 100us in reaction time.
>>   
> 
> The latency test of PREEMPT_RT shows a latency of ~10us for a dual-core 
> box at 1.8GHz.

Are you using cyclictest? And how long did you run it for?


thanks,
Nivedita
