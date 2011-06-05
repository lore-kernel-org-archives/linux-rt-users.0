From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: I/O operations priority in RTOS
Date: Sun, 5 Jun 2011 11:28:54 +0200
Message-ID: <20110605092854.GA7576@opentech.at>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:46289 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab1FEJ2z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 05:28:55 -0400
Content-Disposition: inline
In-Reply-To: <4DEB427F.9020104@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 05 Jun 2011, Armin Steinhoff wrote:

> Nicholas Mc Guire wrote:
>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>
>>> Hello,
>>> I'm studying how to develop drivers in a real time OS and how do they
>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
>>> I would like to know the priority when executing open(), read(), write()
>>> and close() operations.
>>> In my example the thread which is using the driver runs with 10 RTPRIO,
>>> but I don't know what happens in kernel context with the priority when
>>> running the I/O operations.
>>> Thank you for your help, I don't know where to learn about this.
>>>
>> []
>> Also when using bottom half mechanisms you need to take into account the
>> priority of the kernel thread that manages the defered work items, so
>> rt-drivers may have a different structure than normal drivers.
>
> That's the reason why I prefer UIO based user space drivers !
>
...and how to resolve DMA ? if DMA were resolved cleanly I would agree.

hofrat
