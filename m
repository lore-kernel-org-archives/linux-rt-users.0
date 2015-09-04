From: Ioan-Adrian Ratiu <adrian.ratiu@ni.com>
Subject: Re: ARMv7 futex latency spike
Date: Fri, 4 Sep 2015 17:45:57 +0300
Message-ID: <55E9AEA5.50504@ni.com>
References: <55E950B1.4070603@ni.com>
 <alpine.DEB.2.11.1509041430340.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:34858 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750766AbbIDOqI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Sep 2015 10:46:08 -0400
In-Reply-To: <alpine.DEB.2.11.1509041430340.15006@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04.09.2015 15:34, Thomas Gleixner wrote:
> On Fri, 4 Sep 2015, Ioan-Adrian Ratiu wrote:
>
>> Hello
>>
>> I wrote a C program to check jitter levels in userspace (source attached), ran
>> it on various kernels (3.14.19-rt9, 3.18.9-rt5 and 4.1.5-rt5) and on multiple
>> machines.
>
> <snip>
>
>> At .412321, "Low-prio******"'s priority is raised by "High-prio******" again,
>> as if "High-prio******" is waiting for something, but then why was it woken up
>> before?
>> * did "Low-prio******" acquire the lock again? How could it manage this feat
>> since it is already in the unlock system call?
>
> That looks like highprio is trying to acquire a kernel internal lock
> held by lowprio. The only lock which can cause this is the futex
> hashbucket lock.
>
> Now, I can see why that happens in 3.14.19-rt9, 3.18.9-rt5, but
> 4.1.5-rt5 has a fix for that. Are you sure that you that this happens
> on 4.1.5-rt5 as well?

It was a 4.1.3-rt3 build, sorry.

I will try the latest 4.1.5-rt5 and come back if this is still an issue.

Thank you,
Adrian

