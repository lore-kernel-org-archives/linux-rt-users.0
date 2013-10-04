From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.4.62-rt77] fix irq thread scheduling
Date: Fri, 4 Oct 2013 16:05:49 +0200
Message-ID: <20131004140549.GH19953@linutronix.de>
References: <alpine.LNX.2.00.1309191038050.7134@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org
To: Thomas Pfaff <tpfaff@pcs.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54131 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3JDOFv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 10:05:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1309191038050.7134@lxtpfaff.pcs.ditec.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Thomas Pfaff | 2013-09-19 11:02:57 [+0200]:

>If an irq is requested during device open, for example by opening a serial 
>device, then request_irq is called in the context of the opening process.
>If the process lacks off CAP_SYS_NICE the irq thread is running with SCHED_OTHER 
>priority.
>
>The problem exists in other real time patches as well, 3.10 seems to be ok.

Hmmm. I see the same check in v3.10 compared to v3.6 which so I *think*
v3.10 has the same problem.
However this does not look to be -RT specific, you should see the same
problem in mainline, too. Could you please verify whether this does
affect v3.10? And if it does, we should try to fix up it upstream, too

Sebastian
