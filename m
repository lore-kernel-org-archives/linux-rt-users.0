From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: I/O operations priority in RTOS
Date: Sun, 05 Jun 2011 10:46:55 +0200
Message-ID: <4DEB427F.9020104@steinhoff.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59805 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab1FEIhZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 04:37:25 -0400
In-Reply-To: <20110604234214.GA30640@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nicholas Mc Guire wrote:
> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>
>> Hello,
>> I'm studying how to develop drivers in a real time OS and how do they
>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
>> I would like to know the priority when executing open(), read(), write()
>> and close() operations.
>> In my example the thread which is using the driver runs with 10 RTPRIO,
>> but I don't know what happens in kernel context with the priority when
>> running the I/O operations.
>> Thank you for your help, I don't know where to learn about this.
>>
> []
> Also when using bottom half mechanisms you need to take into account the
> priority of the kernel thread that manages the defered work items, so
> rt-drivers may have a different structure than normal drivers.

That's the reason why I prefer UIO based user space drivers !

--Armin

> hofrat
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

