From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Sat, 04 Oct 2014 12:49:34 +0200
Message-ID: <542FD0BE.10508@osadl.org>
References: <542A88A8.7060800@steinhoff.de>	<alpine.DEB.2.11.1410010058160.4455@nanos>	<542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>,
	Patrik Lundquist <patrik.lundquist@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51893 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbaJDL2r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Oct 2014 07:28:47 -0400
In-Reply-To: <542D0689.8050602@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Armin,

> [..] But there are some sideeffects to other running
> processes/threads related to their assigned priorities. Here is the
> priority assignment after a fresh boot:  ps -elf  ->
> Prio-After-OS-Restart.txt attached
>
> If the app "demo_mn_console" has started its first RT thread,  a lot
> of other processes/threads are jumping to the highest RT priority
> 99!! Please have a look to: ps -elf -> Prio-after-app-start.txt
>
> Do we have a problem with the RT kernel ? Or is simply the ps
> utility broken ?
Let me try to summarize your observations and suspicions:
1. After booting your RT kernel, everything works as expected.
2. The ps utility works as expected.
3. There are no bug reports that the RT kernel autonomously and at
random fiddles around with task priorities.
4. There are no bug reports that the ps utility - one of the most
frequently used utilities - suddenly may start to display erroneous
priority numbers.

5. At a given time, you start your application that apparently modifies
task priorities *in some way*.
6. Shortly afterwards you are observing that other not intended tasks
changed their priority as well.

7. Your first suspicion is that we may have a problem with the RT kernel.
8. And your second suspicion is that the ps utility is broken.

Doesn't come another suspicion to mind?

	-Carsten.
