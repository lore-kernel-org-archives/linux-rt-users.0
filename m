From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: rt for newbie
Date: Fri, 28 Oct 2011 18:50:04 +0200
Message-ID: <4EAADD3C.3090501@osadl.org>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com> <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com> <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com> <4EA9D980.5080903@osadl.org> <4EAA5BC2.4020908@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sashka@mail.ru, linux-rt-users@vger.kernel.org
To: Dennis Borgmann <dennis.borgmann@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:50066 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab1J1RCI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Oct 2011 13:02:08 -0400
In-Reply-To: <4EAA5BC2.4020908@googlemail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Dennis,

>>  [..]
>> 2. Configure the kernel for RT
>> # make menuconfig
>> Processor type and features --->
>> [ ] Tickless System (Dynamic Ticks)
>> Preemption Model (Fully Preemptible Kernel (RT)) --->
>> Kernel hacking --->
>> [ ] Check for stack overflows
> I think, your small "howto" is a little confusing. You are describing
> the kernel options needed for RT-capabilities, but there is no asterisk
> within the square brackets in order to show, that they should be
> enabled. The way it is written in your email, it seems like they should
> be disabled. Or did you really mean to disable the "Tickless System"
> option and the "Check for stack overflows" option?
Thank you for pointing this out. My description may, indeed, be 
misleading. I simply wanted to show how the line of the configuration 
menu should look like, i.e. not crossed -> not enabled.

Checking for stack overflows almost certainly leads to a longer 
worst-case latency and, while tickless operating is good for the 
financial budget, it may be bad for the real-time behavior. The latter 
applies to a configuration that allows the processor to enter a sleep 
state when idle and to a situation when rarely occurring external events 
trigger a real-time process so the processor has time to go to sleep.

Thanks,
	-Carsten.
