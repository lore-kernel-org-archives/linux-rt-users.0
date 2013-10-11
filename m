From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.4.62-rt77] fix irq thread scheduling
Date: Fri, 11 Oct 2013 12:58:12 +0200
Message-ID: <20131011105812.GF6983@linutronix.de>
References: <alpine.LNX.2.00.1309191038050.7134@lxtpfaff.pcs.ditec.de>
 <20131004140549.GH19953@linutronix.de>
 <alpine.LNX.2.00.1310081550340.16551@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>
To: Thomas Pfaff <tpfaff@pcs.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60603 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab3JKK6N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 06:58:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1310081550340.16551@lxtpfaff.pcs.ditec.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Thomas Pfaff | 2013-10-08 15:58:50 [+0200]:

>I did a quick check with 3.10.14-rt9 and it is not affected, because 
>sched_setscheduler is called in the context of the irq thread as the mainline 
>kernel does, but the 3.6 rt patch moved this into __setup_irq.

Thanks for that report. It looks that this is broken upstream as well.
I'm going to merge the patch that broke it, your fix and try to do the
same for upstream.

>Thomas

Sebastian
