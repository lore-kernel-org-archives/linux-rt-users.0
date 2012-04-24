From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 09:26:13 -0700
Message-ID: <BA425197-1889-4161-8726-860E30EC943A@thebigcorporation.com>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>	<4F966AFC.7070803@cfl.rr.com> <CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com> <4F967574.8030104@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel-rt <linux-rt-users@vger.kernel.org>
To: dmarkh@cfl.rr.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:38298 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753Ab2DXQ0S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 12:26:18 -0400
Received: by dadz8 with SMTP id z8so1126626dad.10
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Apr 2012 09:26:18 -0700 (PDT)
In-Reply-To: <4F967574.8030104@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 
> Your in lala land. The Linux kernel, even with the RT patch has so much "per CPU" crap in it, there is no way to prevent it from steeling usecs from your application. The per CPU timer interrupt alone takes a few usecs away from your application every HZ. A hard RT env is one in which you can always, every time, do a predefined work in the same amount of time. Fast or slow isn't the key. It's determinism. The timer interrupt alone prevents that. And it's not the only thing. I've got 8 cpus on my machine but the kernel has to have a piece of every one of them. Until there is isolation from the kernel, there cannot be "Hard RT". This is fact.
> 


Mark,

there is a big difference between real-time processing and bare-metal processing.

In bare metal, we do care about individual cycles, but not all real-time is bare-metal.

Determinism , or "RT requirements" is defined by the application. 

Many applications, with critical functionality, that we an define as hard real-time, 
can exist fine using the Linux kernel as infrastructure and meet deadlines in a time-critical manner.

The OS meets deterministic hard-real-time requirements, if the application is not late to execute.

Generally, hard real-time is defined as the value of the computation being at most 0 when executed late.

Soft real time implies a diminished value.

Bare metal today, since you bring up counting cycles, is a bit hard to reach with all the caching layers, pipelining, memory and bus architecture and so on, all aimed at throughput.

You will be hard pressed to find predictable behavior in anything but the simplest loops, bare-bones CPUs, and even then, pressure to differentiate in the market ends up with odd designs making CPUs do funky things.

Please do refrain from making such broad and sweeping statements, such as calling people in lala land (I have been there and its quite nice btw).

Such statements carry no value, they can always be picked apart, and I do agree, bring a heavy toll of mis-understanding and FUD amongst those of us who are not as deeply involved in the intricacies.

Thanks

Sven


> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

