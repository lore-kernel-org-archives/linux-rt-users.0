From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Priorities of IRQ handlers
Date: Tue, 27 Nov 2007 11:26:26 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com>
References: <474AE6C7.4090204@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:35067 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808AbXK0Q0u (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Nov 2007 11:26:50 -0500
In-Reply-To: <474AE6C7.4090204@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Mon, 26 Nov 2007, John Sigler wrote:

> I need to change the priorities of several soft and hard IRQ handlers.
>
> Namely,
>
> o reduce the prio of "softirq-timer" handler to 10
>
> o reduce the prio of IRQ14 and IRQ15 handlers to 20
>    (my flash drives do not support DMA BTW...)
>
> o boost the prio of my I/O boards' IRQ handlers to 60
>    (there can be 1 or 2 boards, the driver is a kernel module
>     which is loaded after the system has booted.)
>
> I've written a short program that calls
>    sched_setscheduler(pid, SCHED_FIFO, &param);
> with the appropriate pid, which I look up using ps -ef

Look for the program "chrt". It does this for you. This program is
avaliable in all major distrobutions of Linux.

>
> I need to automate the process of tweaking priorities.
>
> Can someone offer advice and / or pointers?

Perhaps look at one of the Start up scripts, and add the chrt command
there.

-- Steve
