From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Sat, 04 Oct 2014 14:36:04 +0200
Message-ID: <542FE9B4.3060708@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de>	<alpine.DEB.2.11.1410010058160.4455@nanos>	<542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>,
	Patrik Lundquist <patrik.lundquist@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61395 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaJDMgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Oct 2014 08:36:10 -0400
In-Reply-To: <542FD0BE.10508@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Carsten Emde schrieb:
> Armin,
>
>> [..] But there are some sideeffects to other running
>> processes/threads related to their assigned priorities. Here is the
>> priority assignment after a fresh boot:  ps -elf  ->
>> Prio-After-OS-Restart.txt attached
>>
>> If the app "demo_mn_console" has started its first RT thread,  a lot
>> of other processes/threads are jumping to the highest RT priority
>> 99!! Please have a look to: ps -elf -> Prio-after-app-start.txt
>>
>> Do we have a problem with the RT kernel ? Or is simply the ps
>> utility broken ?
> Let me try to summarize your observations and suspicions:
> 1. After booting your RT kernel, everything works as expected.
Yes, all seems to be OK.

> 2. The ps utility works as expected.
Yes
> 3. There are no bug reports that the RT kernel autonomously and at
> random fiddles around with task priorities.

 I have submited a bug report in the meantime.

> 4. There are no bug reports that the ps utility - one of the most
> frequently used utilities - suddenly may start to display erroneous
> priority numbers.

A bug in the good old "ps" would be very unlikely.

>
> 5. At a given time, you start your application that apparently modifies
> task priorities *in some way*.

Not in some way ... the developers of the openPOWERLINK stack are using
plain POSIX calls.

> 6. Shortly afterwards you are observing that other not intended tasks
> changed their priority as well.

Yes ... most processes running previously at 80 are jumping to 99!

>
> 7. Your first suspicion is that we may have a problem with the RT kernel.
> 8. And your second suspicion is that the ps utility is broken.
   The question about the operation of "ps" was just a formal one .. sorry.

>
> Doesn't come another suspicion to mind?

Why should I have one? The same code works correctly under then non-RT
version of the kernel ... at least from the Linux point of view.

--Armin
>     -Carsten.
>


