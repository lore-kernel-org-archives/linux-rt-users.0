From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time group or run as root
Date: Mon, 25 Feb 2013 12:55:08 -0800
Message-ID: <457E1107-480D-493F-9073-4AE455BA3BD2@thebigcorporation.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37814 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127Ab3BYUzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2013 15:55:11 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so1891467pbb.27
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Feb 2013 12:55:10 -0800 (PST)
In-Reply-To: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Feb 25, 2013, at 12:03 PM, Hartmut Behrens <hartmut.behrens@gmail.com> wrote:

> Dear RT Folks,
> 
> After successfully patching a 3.2 kernel (gumstix platform) with
> patch-3.2-rt10, I obtained the rt-tests suite from
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> 
> I enabled CONFIG_PREEMPT_RT in menuconfig and disabled "CPU frequency scaling".
> 
> Compilation of rt-tests ("make all") on the platform is also successful.
> 
> When trying to execute cyclictest, the program reports: "Unable to
> change scheduling policy! either run as root or join realtime group"
> 
> Looking in rt-utils.c, it appears that set_scheduler is unable to
> select SCHED_FIFO scheduling policy.
> 
> Do you have any hints on how to fix this problem, or at least narrow
> it down further? Could it
> 

Does "either run as root or join realtime group" fix the problem?

Sven

> Best Regards,
> Hartmut Behrens
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

