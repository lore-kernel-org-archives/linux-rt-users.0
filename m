From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 15:59:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708101555290.24727@gandalf.stny.rr.com>
References: <200708081514.31864.jbe@pengutronix.de>  <200708081409.28105.dvhltc@us.ibm.com>
  <200708091610.58134.jbe@pengutronix.de>  <200708091128.44043.dvhltc@us.ibm.com>
  <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
 <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
 <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
 <Pine.LNX.4.58.0708101209350.21632@gandalf.stny.rr.com>
 <3efb10970708101247k30d375a6p274b8ae37fcedca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34655 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbXHJUAF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 16:00:05 -0400
In-Reply-To: <3efb10970708101247k30d375a6p274b8ae37fcedca7@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 10 Aug 2007, Remy Bohmer wrote:

>
> Arnaldo mentioned to use the irq-name for this, and to me this sounds good.

Yeah, that wouldn't be too hard to implement.

>
> > > possible to use 1 target image usable on multiple boards with  1
> > > single kernel and 1 single config.
> >
> > You can still have one kernel and one config. A command line is separate.
>
> My mistake: I meant with config the grub, u-boot or ... config, not
> the kernel config

OK, understood.

>
> >
> > five if you count my writing of the chapter in the O'Reilly book
> > "Building Embedded Linux Systems" about RT.  But these are some of the
>
> Interesting... When will this book be finished? I am always curious

hehe, it was due last year! I'm only doing the RT chapter about Ingo's
patch.  I wont give a time frame, since I'm working my butt on getting it
out. But it is due soon.

> about the point of view of others on RT... (I am working with Ingo's
> RT-patch for several years now, started with the early preemption
> patches on 2.4 kernels)

I've been developing Ingo's patches for a few years now too.  I'm one of
the authors of the rt-mutex.c code.  Actually, I started out on RT Linux
programing as a kernel developer at TimeSys working on their Linux 2.2
port.  Now I'm at Red Hat with Ingo, but I'm on other projects that keep
me from doing RT full time :-(

-- Steve
