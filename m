From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 06 Jun 2011 00:39:35 +0200
Message-ID: <4DEC05A7.7060306@steinhoff.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <4DEB4B97.9030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55199 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab1FEW37 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 18:29:59 -0400
In-Reply-To: <4DEB4B97.9030005@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jan Kiszka wrote:
> On 2011-06-05 10:46, Armin Steinhoff wrote:
>> Nicholas Mc Guire wrote:
>>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>>
>>>> Hello,
>>>> I'm studying how to develop drivers in a real time OS and how do they
>>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
>>>> I would like to know the priority when executing open(), read(), write()
>>>> and close() operations.
>>>> In my example the thread which is using the driver runs with 10 RTPRIO,
>>>> but I don't know what happens in kernel context with the priority when
>>>> running the I/O operations.
>>>> Thank you for your help, I don't know where to learn about this.
>>>>
>>> []
>>> Also when using bottom half mechanisms you need to take into account the
>>> priority of the kernel thread that manages the defered work items, so
>>> rt-drivers may have a different structure than normal drivers.
>> That's the reason why I prefer UIO based user space drivers !
> ...which are forced to use threaded IRQs over -rt as well.

What's wrong with that approach? You have an ISR in the kernel module 
and an interrupt thread at user space.
Seem OK for me since a long time with QNX :)
> Taking threaded IRQs out of the picture, bottom-half mechanisms usually
> come into play when dispatch workload that cannot be assigned to a
> specific user context is significant. But then UIO is the wrong approach
> anyway as it doesn't match well the requirements of multi-user device
> interfaces.
   Support of multi-user device interfaces at user space is just a 
design issue ... I use this concept since a long time with QNX :)

--Armin



> Jan
>

