From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 06 Jun 2011 09:41:58 +0200
Message-ID: <4DEC84C6.4090702@steinhoff.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at> <4DEB5015.7070601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50772 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab1FFHc0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 03:32:26 -0400
In-Reply-To: <4DEB5015.7070601@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jan Kiszka wrote:
> On 2011-06-05 11:28, Nicholas Mc Guire wrote:
>> On Sun, 05 Jun 2011, Armin Steinhoff wrote:
>>
>>> Nicholas Mc Guire wrote:
>>>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>>>
>>>>> Hello,
>>>>> I'm studying how to develop drivers in a real time OS and how do they
>>>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
>>>>> I would like to know the priority when executing open(), read(), write()
>>>>> and close() operations.
>>>>> In my example the thread which is using the driver runs with 10 RTPRIO,
>>>>> but I don't know what happens in kernel context with the priority when
>>>>> running the I/O operations.
>>>>> Thank you for your help, I don't know where to learn about this.
>>>>>
>>>> []
>>>> Also when using bottom half mechanisms you need to take into account the
>>>> priority of the kernel thread that manages the defered work items, so
>>>> rt-drivers may have a different structure than normal drivers.
>>> That's the reason why I prefer UIO based user space drivers !
>>>
>> ...and how to resolve DMA ? if DMA were resolved cleanly I would agree.
> Regarding that limitation, there is some hope: "next-generation" UIO is
> called VFIO.

I found in a posting about VFIO that  " ioctls are used for all the 
basic interactions"  ... that means VFIO works with a lot of context 
switches.
That's not the case with UIO.  So why should VFIO be a mainline approach 
or next generation UIO at all?

--Armin

