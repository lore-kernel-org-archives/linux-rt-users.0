From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Tue, 30 Sep 2014 19:22:07 +0200
Message-ID: <542AE6BF.6090500@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de> <CAKudYbMN0W2uiKN-TEMMkHLUNyeBP38syjg0x7DtAvj1fZq+YA@mail.gmail.com> <542AA2E5.1050507@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63521 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaI3RWK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Sep 2014 13:22:10 -0400
In-Reply-To: <542AA2E5.1050507@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

pthread_setschedparam seems to be broken in my PREEMPT_RT version !!
The pthread_attr_ interface is working ...

Any comments ??

cheers

--Armin

Armin Steinhoff schrieb:
> Harry,
>
> I'm running as root. The same code works w/o problem with the normal
> (non RT) kernel.
> "chrt -m" shows  1/99 for SCHED_FIFO. I did also add @root - rtprio 99
> to limits.conf ... no success, as expected. 
>
> --Armin
>
> Harry van Haaren schrieb:
>> On Tue, Sep 30, 2014 at 11:40 AM, Armin Steinhoff <armin@steinhoff.de> wrote:
>>> a "pthread_setschedparam" call of the code below terminates with an
>>> errno == 1  ... means "Operation not permitted"
>> At risk of asking the obvious: are you running as root, or does the
>> user running this code have RT priorities?
>>
>> User priorities controlled by /etc/security/limits.conf : you can set
>> a groups max-rtprio like so:
>> @audio          -       rtprio          65
>>
>>> KERNEL_EVENT_THREAD_PRIORITY is 55!
>>> How to solve that problem ?
>> Anything above 50 requrires changing limits.conf  or root IIRC.
>>
>> HTH, -Harry
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

