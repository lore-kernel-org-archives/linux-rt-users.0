From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Sun, 22 Feb 2009 22:29:17 +0100
Message-ID: <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com>
References: <49A1BA49.7060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Lukasz Majewski <majess1982@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:27904 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZBVV3T (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Feb 2009 16:29:19 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1067287qwi.37
        for <linux-rt-users@vger.kernel.org>; Sun, 22 Feb 2009 13:29:18 -0800 (PST)
In-Reply-To: <49A1BA49.7060308@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Lukasz,

> I'm also using NFS to mount root file system from my host x86 ubuntu PC.

Have you tried already running from a ram-disk?

> When I start my application it runs for some time and ends as expected. It
> seems that everything is OK. Static schedule is not violated. Unfortunately,
> after running this application for couple of times (6 to 10) I can see that
> static schedule is violated(delayed in execution) for about 2-4 seconds.
> Application is running for 1-2 seconds as expected and then crashes(I mean
> exits with static schedule delay of 2-4 seconds). It looks like page fault,

You can trace the number of page-faults during run, by means of
getrusage(), see rt-wiki.
2-4 seconds sounds quite long for page fault handling to me (unless
you are using page/swap files)

> but in my main() I've add mlockall() as writen in the examples from rt.wiki.
> Moreover I've prevent stack as written  in "square_wave example". Before my
> application exits I'm calling munlockall(). When I log via ssh to my
> embedded system and start top,I cannot see that I've got some memory leaks
> or zombi processes during run of my RT application.
>
> May it be possible that by some chance some global variable is not locked in
> the memory? What is the "scope" of mlockall? Is it only valid in one .o

mlockall() is somewhat tricky. It locks all allocated data pages (and
future pages, if specified) in to RAM, but IIRC code segments are not
forced to be loaded into RAM, but only code segments that are loaded
once, will be locked. So, in theory, there could be pages still on the
NFS share that are not loaded when the problem arises. So, this could
be the problem you see, but it would not be the first suspect I would
look for.

> I'd appreciate any hints/comments what can cause this bug.

I read you use uClibc, the last time I looked at it (quite some time
ago), it lacked support for priority inheritance mutexes... Aren't you
running in a mutex priority inversion?

Or priority inversion related to other interrupt threads? You run at
prio 71, if you leave the network, or block device
softirqs/irq-threads on 50, you could have a priority inversion on
this level as well. This would be my prime suspect...

> I was trying to
> use strace and gdb to fix this problem, but this tools are to slow and they
> cause violation of my cyclic static schedule.

No ETM trace available? Really nice to have in such cases...


Kind Regards,

Remy
