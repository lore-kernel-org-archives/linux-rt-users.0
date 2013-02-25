From: Diego Simak <diego.simak@gmail.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Mon, 25 Feb 2013 19:35:27 -0200
Message-ID: <CAKC-MPpLXzok4GM59+J4Q-FiwWiz_DV1LA6E3hAthC8XFEkGsQ@mail.gmail.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
 <457E1107-480D-493F-9073-4AE455BA3BD2@thebigcorporation.com> <CA+69FtAWbTm-9vJYXnV3xOFNRKd4iKvh0Uo83ct_qqm9S2b9Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:56442 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab3BYVfs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2013 16:35:48 -0500
Received: by mail-vc0-f173.google.com with SMTP id fy27so2020512vcb.4
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Feb 2013 13:35:47 -0800 (PST)
In-Reply-To: <CA+69FtAWbTm-9vJYXnV3xOFNRKd4iKvh0Uo83ct_qqm9S2b9Cw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2013/2/25 Hartmut Behrens <hartmut.behrens@gmail.com>
>
> No, neither of these work (realtime groupnames that were tried:
> realtime  / rtprio)
>
> This might be related:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=619938 but I have yet
> to dig into the details.
>
> Are there perhaps any other suggestions?
>
> Best Regards,
>
> Hartmut
>
> On Mon, Feb 25, 2013 at 10:55 PM, Sven-Thorsten Dietrich
> <sven@thebigcorporation.com> wrote:
> >
> > On Feb 25, 2013, at 12:03 PM, Hartmut Behrens <hartmut.behrens@gmail.com> wrote:
> >
> >> Dear RT Folks,
> >>
> >> After successfully patching a 3.2 kernel (gumstix platform) with
> >> patch-3.2-rt10, I obtained the rt-tests suite from
> >> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> >>
> >> I enabled CONFIG_PREEMPT_RT in menuconfig and disabled "CPU frequency scaling".
> >>
> >> Compilation of rt-tests ("make all") on the platform is also successful.
> >>
> >> When trying to execute cyclictest, the program reports: "Unable to
> >> change scheduling policy! either run as root or join realtime group"
> >>
> >> Looking in rt-utils.c, it appears that set_scheduler is unable to
> >> select SCHED_FIFO scheduling policy.
> >>
> >> Do you have any hints on how to fix this problem, or at least narrow
> >> it down further? Could it
> >>
> >
> > Does "either run as root or join realtime group" fix the problem?
> >
> > Sven
> >
> >> Best Regards,
> >> Hartmut Behrens
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




Hi,
Try add yourself to a group that allows changing scheduling policy.

Check the following link to know how to do this (I'm from the audio world)

http://www.jackaudio.org/linux_rt_config

hth
