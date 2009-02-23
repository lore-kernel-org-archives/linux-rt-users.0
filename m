From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Mon, 23 Feb 2009 11:12:31 +0100
Message-ID: <3efb10970902230212q7122b7b8ue28054fdbce25e5@mail.gmail.com>
References: <49A1BA49.7060308@gmail.com>
	 <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com>
	 <49A1D930.4010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Lukasz Majewski <majess1982@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:58906 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbZBWKMd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 05:12:33 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1161985qwi.37
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2009 02:12:31 -0800 (PST)
In-Reply-To: <49A1D930.4010600@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Lukasz,

2009/2/23 Lukasz Majewski <majess1982@gmail.com>:
> Hello,
>
> Thank you for this extremely fast response. :-)

No thanks :-)

> Now some explanation about uClibc. I know that this C library lacks of many
> features (for instance NTPL support for ARM). Unfortunately, for ARM
> architecture, there is nice utility -> buildroot  for building toolchain and
>  root filesystems. I'm not using x86 as target architecture, so cross
> compiling toolchain without errors is success as it is :-).
> I've tried pxtdist tool from pengutronix.de , but I cannot build proper
> toolchain without errors for my Atmel's ARM9 device (ARMv5tej arch to be
> precise). Or saying it in another way -> I gave up after spending some time
> and moved back toward working uClibc. I've build some toolchains, but during
> build I've encountered some errors and despite of that it, built

If you have problems building compiler toolchains, there are other
ways to do it.
You can use a precompiled (and tested) toolchain, for example:
* http://www.codesourcery.com/sgpp/lite/arm.
* http://www.denx.de/wiki/DULG/ELDK
* ....
The advantage of such a precompiled toolchain, is that it saves you a
lot of build time, and you can focus on the things that matter for
your application.

> arm-linux-gcc which worked, I wasn't sure if glibc is not cracked in some
> way.
>
> On my first post I haven't mention that I was checking rusage struct for
> minor and major page faults.
> In my program I checked it twice: first before calling mlockall() - on the
> beginning of the program and after munlockall() when program ends either
> when delay occurs or in normal termination. In both cases I've got the same
> number of minor and major page faults. So it looks that no page fault
> appears.

Strange, normally mlockall generates a lot of pagefaults by just
calling it, so there should be a difference before and directly after
calling mlockall.

> I've checked, and it turns out that uClibc 0.9.30 is not supporting PI
> (priority inversion) and futexes. This may cause my bug ,since I'm heavily
> using read/write on /dev/ files (read/write to 4 differen files). There's a
> lot of space for priority inversion in my code :-/. I was writing this code
> with holly faith that "in some way" priority inversion is avoided. I
> assumed, that access to some device (resource in this case) has some
> mechanism to inheritance the priority.

That depends on the driver behind it. In kernel there is always PI
support on mutexes.
PI mutexes should be enabled for mutexes in your own code.

Do not forget to look at the priority of softirq-s/irq-threads related
to your RT-threads.
if, for example, you have a thread running at prio 60, softirqs and
irq-threads running at 50, and your RT thread is running at 70, and it
has some dependency to the prio 50 irqs, then you could have an
inversion problem here as well. The prio 60 task could prevent the
softirqs and irq-threads from running, leaving the prio 70 task
waiting for a very long time.

> Is looks,that the only solution for me is to build toolchain with glibc at
> least 2.6 and gcc 4.+ with full support of Priority Inheritance, futexses
> and "clock_" set of functions.  As I mentioned it's a bit tricky for ARM
> (especialy with proper ABI and software floating point support
> (msoft-float)). But it looks as the only feasible solution.

As mentioned above, you could use a precompiled toolchain.
It would at least safe you time to get it working, and if you still
want to compile one yourself, you can always do it later...

Kind Regards,

Remy
