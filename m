From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] RFC: Set irq thread to RT priority on creation
Date: Thu, 30 May 2013 21:50:41 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1305302147290.2905@ionos>
References: <1369915975-28797-1-git-send-email-meltedpianoman@gmail.com>  <alpine.LFD.2.02.1305301602490.2905@ionos> <1369925681.26799.6.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ivo Sieben <meltedpianoman@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35043 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3E3Tuo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 May 2013 15:50:44 -0400
In-Reply-To: <1369925681.26799.6.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 30 May 2013, Steven Rostedt wrote:

> On Thu, 2013-05-30 at 16:07 +0200, Thomas Gleixner wrote:
> 
> > > This patch solves an issue for me where a device driver is expected to handle an
> > > interrupt immediatly after irq handlers are installed and interrupts enabled.
> > 
> > You miss to explain what kind of issue that is.
> 
> I could envision the case where the interrupt is initialized but doesn't
> go off until much later. If it never ran, then it would still be in
> SCHED_OTHER(), and that first interrupt could have a large delay.

Nope. As Ivo explained it's about an interrupt coming in right away,
i.e. before __setup_irq() reaches:

        if (new->thread)
	   wake_up_process(new->thread);

The ones which come much later do not have that issue as the thread
code already sits in the waiting loop and already adjusted the
priority.

Thanks,

	tglx

