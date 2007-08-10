From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 21:47:49 +0200
Message-ID: <3efb10970708101247k30d375a6p274b8ae37fcedca7@mail.gmail.com>
References: <200708081514.31864.jbe@pengutronix.de>
	 <200708081409.28105.dvhltc@us.ibm.com>
	 <200708091610.58134.jbe@pengutronix.de>
	 <200708091128.44043.dvhltc@us.ibm.com>
	 <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
	 <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
	 <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
	 <Pine.LNX.4.58.0708101209350.21632@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Darren Hart" <dvhltc@us.ibm.com>, "Ingo Molnar" <mingo@elte.hu>,
	"Juergen Beisert" <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:6723 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933488AbXHJTru (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 15:47:50 -0400
Received: by py-out-1112.google.com with SMTP id d32so1514479pye
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Aug 2007 12:47:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0708101209350.21632@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

> Actually, the handler thread runs _all_ register interrupt handlers. So
> there's no way to make one a higher priority than the other. This is a
> tough problem. If you have two shared handlers on the same irq line,
> and think you can make one a higher priority than the other, you can't.
> If the lower one is running (at the lower priority), and it gets
> preempted by an RT task with a priority that is between the lower
> priority handler and the higher priority handler, the higher priority
> handler may never run. The interrupt line for the IRQ is masked while
> the handlers are running. So by preempting the lower priority handler
> you are also preempting the higher priority IRQ from coming in.
>

Hmm, I think you did not get my point... What you mention is basic
knowledge... ;-))

What I meant was that from Embedded point of view, some developer
probably don't care about what the irq-line-number is of some device.
But, such a developer probably wants to prioritize the interrupt
handler of his device. Dependant on how the hardware layout looks like
it can be interrupt # X, Y or Z. If the kernel can match the device
name to a certain IRQ #, the implementation is probably much more
flexible than by just specifying the IRQ # at the kernel commandline.
In the case where the IRQ handler is shared with some other device,
than there are 2 options: the developer does not care, or should
choose different hardware.

Arnaldo mentioned to use the irq-name for this, and to me this sounds good.

> > possible to use 1 target image usable on multiple boards with  1
> > single kernel and 1 single config.
>
> You can still have one kernel and one config. A command line is separate.

My mistake: I meant with config the grub, u-boot or ... config, not
the kernel config

>
> five if you count my writing of the chapter in the O'Reilly book
> "Building Embedded Linux Systems" about RT.  But these are some of the

Interesting... When will this book be finished? I am always curious
about the point of view of others on RT... (I am working with Ingo's
RT-patch for several years now, started with the early preemption
patches on 2.4 kernels)

Kind Regards,

Remy
