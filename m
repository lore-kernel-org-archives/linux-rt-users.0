From: Yao Zhao <yao.zhao@windriver.com>
Subject: Re: rt-tester testcase t4-l2-pi-deboost.tst failed
Date: Thu, 28 Feb 2013 09:53:35 -0500
Message-ID: <512F6F6F.5050700@windriver.com>
References: <512E5D41.3000103@windriver.com> <alpine.LFD.2.02.1302272315460.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41416 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab3B1Oxv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Feb 2013 09:53:51 -0500
In-Reply-To: <alpine.LFD.2.02.1302272315460.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-02-27 05:16 PM, Thomas Gleixner wrote:
> On Wed, 27 Feb 2013, Yao Zhao wrote:
>
>> Hi,
>>
>> I tested rt-tester with mainline 3.8.0 kernel and
>> the kernel scripts/rt-tester/t4-l2-pi-deboost.tst failed at
>>
>> # Verify prio of T0 (still pending owner,
>> # but T2 is enqueued due to the previous boost by T3
>> T: prioeq:              0:      82
>>
>> The current T0's prio is -21 so it failed.
>>
>> Reading source code, it should be 82 as T2 is at prio 82 and
>> T0 owns the L1 and T2 is waiting for the L1.
>>
>> Can I ask
>> 1.is the rt-tester test only for preempt-rt kernel?
> No
>
>> 2.any idea why it failed?
> No
>
> It would be nice if you could figure out whether that's a failure of
> the test case or a failure in the kernel.
For the whole check-all.sh t4-l2-pi-deboost.tst is the first test case
which failed and in t4-l2-pi-deboost.tst: that line is the first "test"
failed.
I didn't see any failures in the kernel.

But I will spend some time to debug around and get familiar with
the rt-mutex code.

thanks,
yao
> Thanks
>
> 	tglx

