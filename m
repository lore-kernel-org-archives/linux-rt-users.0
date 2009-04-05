From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: System deadlock on 2.6.24-rt20 (-rt27 panics on
 locking-api-selftests)
Date: Sun, 5 Apr 2009 21:09:02 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904052107500.747@localhost.localdomain>
References: <3efb10970904030502q1068731fl5b92f93d5341b43e@mail.gmail.com>  <alpine.LFD.2.00.0904051257470.747@localhost.localdomain>  <3efb10970904051139ue3802b1ib33487418188e4bc@mail.gmail.com>  <alpine.LFD.2.00.0904052046030.747@localhost.localdomain>
 <3efb10970904051200g4c725badp6d05092b70dd56a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46489 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726AbZDETJl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 15:09:41 -0400
In-Reply-To: <3efb10970904051200g4c725badp6d05092b70dd56a2@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 5 Apr 2009, Remy Bohmer wrote:
> > Seriously, I'm not going to look into that as my limited capacity is
> > focussed on 2.6.29-rt.
> 
> As it should be... :-)
> I was not asking you to fix it, my apologies if you read it that way.
> It is not that important to me, just a nice-to-have.

I did not interpret it that way :) I just wanted to explain instead of
just shrugging you off.

Thanks,

	tglx
