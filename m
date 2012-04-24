From: Mark Hounschell <markh@compro.net>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 13:25:52 -0400
Message-ID: <4F96E220.6010506@compro.net>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>	<4F966AFC.7070803@cfl.rr.com> <CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com> <4F967574.8030104@cfl.rr.com> <BA425197-1889-4161-8726-860E30EC943A@thebigcorporation.com>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dmarkh@cfl.rr.com, linux-kernel-rt <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:14356 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756993Ab2DXRk2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 13:40:28 -0400
In-Reply-To: <BA425197-1889-4161-8726-860E30EC943A@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/24/2012 12:26 PM, Sven-Thorsten Dietrich wrote:
>>
>> Your in lala land. The Linux kernel, even with the RT patch has so much "per CPU" crap in it, there is no way to prevent it from steeling usecs from your application. The per CPU timer interrupt alone takes a few usecs away from your application every HZ. A hard RT env is one in which you can always, every time, do a predefined work in the same amount of time. Fast or slow isn't the key. It's determinism. The timer interrupt alone prevents that. And it's not the only thing. I've got 8 cpus on my machine but the kernel has to have a piece of every one of them. Until there is isolation from the kernel, there cannot be "Hard RT". This is fact.
>>
>
>
> Mark,
>
> there is a big difference between real-time processing and bare-metal processing.
>
> In bare metal, we do care about individual cycles, but not all real-time is bare-metal.
>
> Determinism , or "RT requirements" is defined by the application.
>
> Many applications, with critical functionality, that we an define as hard real-time,
> can exist fine using the Linux kernel as infrastructure and meet deadlines in a time-critical manner.
>
> The OS meets deterministic hard-real-time requirements, if the application is not late to execute.
>
> Generally, hard real-time is defined as the value of the computation being at most 0 when executed late.
>
> Soft real time implies a diminished value.
>
> Bare metal today, since you bring up counting cycles, is a bit hard to reach with all the caching layers, pipelining, memory and bus architecture and so on, all aimed at throughput.
>
> You will be hard pressed to find predictable behavior in anything but the simplest loops, bare-bones CPUs, and even then, pressure to differentiate in the market ends up with odd designs making CPUs do funky things.
>
> Please do refrain from making such broad and sweeping statements, such as calling people in lala land (I have been there and its quite nice btw).
>

Yea, I've been there too. But go back to the OP. I then was simply 
informing him of what Hard RT (you may call it bare-bones if you like) 
was and still is in my opinion. I was then accused of spreading FUD by 
someone named Lars. The response you quoted above was my response to 
being accused of spreading FUD when I gave my opinion of what Hard-RT 
and the RT patch set is.

I've been in the Hard and Soft RT business since the 70s and understand 
what it is, why it is, how programmers in the past have done things 
considered wrong now, simply because they could then, and that there 
really isn't any hardware designed for it these days. But even if there 
was, what you quoted above would still be true.

I will have to admit though that processing speed has certainly helped 
in recent years. We are able to replace _some_ of these old "designed 
for HRT" machines with modern boxes simply because they are so fast. 
Maybe when they are fast enough to handle timer interrupts in less than 
a usec or so, I'll be able to replace more of them.

But, as my original response to the original OP was, the RT kernel patch 
is NOT making the kernel capable of HARD RT but certainly gives good 
Soft RT results. If ya lower the bar, you'll never get to the top of the 
pole.

Regards
Mark
