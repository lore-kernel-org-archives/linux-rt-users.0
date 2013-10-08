From: Thomas Pfaff <tpfaff@pcs.com>
Subject: Re: [PATCH 3.4.62-rt77] fix irq thread scheduling
Date: Tue, 8 Oct 2013 15:58:50 +0200
Message-ID: <alpine.LNX.2.00.1310081550340.16551@lxtpfaff.pcs.ditec.de>
References: <alpine.LNX.2.00.1309191038050.7134@lxtpfaff.pcs.ditec.de> <20131004140549.GH19953@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pcs.de ([145.253.69.50]:38220 "EHLO exchange5.pcs.ditec.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754471Ab3JHN7c (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 09:59:32 -0400
In-Reply-To: <20131004140549.GH19953@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 4 Oct 2013, Sebastian Andrzej Siewior wrote:

> * Thomas Pfaff | 2013-09-19 11:02:57 [+0200]:
> 
> >If an irq is requested during device open, for example by opening a serial 
> >device, then request_irq is called in the context of the opening process.
> >If the process lacks off CAP_SYS_NICE the irq thread is running with SCHED_OTHER 
> >priority.
> >
> >The problem exists in other real time patches as well, 3.10 seems to be ok.
> 
> Hmmm. I see the same check in v3.10 compared to v3.6 which so I *think*
> v3.10 has the same problem.
> However this does not look to be -RT specific, you should see the same
> problem in mainline, too. Could you please verify whether this does
> affect v3.10? And if it does, we should try to fix up it upstream, too
> 

I did a quick check with 3.10.14-rt9 and it is not affected, because 
sched_setscheduler is called in the context of the irq thread as the mainline 
kernel does, but the 3.6 rt patch moved this into __setup_irq.

Thomas
