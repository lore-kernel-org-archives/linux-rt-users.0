From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange spikes using linux-rt kernel
Date: Mon, 6 Jul 2009 17:30:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907061726190.19480@localhost.localdomain>
References: <190013.60215.qm@web112503.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicholas Mc Guire <mcguire@lzu.edu.cn>,
	linux-rt-users@vger.kernel.org
To: Pedro R <eusou15@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41177 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbZGFPar (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jul 2009 11:30:47 -0400
In-Reply-To: <190013.60215.qm@web112503.mail.gq1.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pedro,

please do not top post and please fix your mailer to do proper
linewraps at around 78 chars.

On Fri, 3 Jul 2009, Pedro R wrote:

> The posixcputmr/0 and watchdog/0 seem to be running at a higher
> priority! Is this normal?

Yes, but they do not interfere and are not the cause of your latency
problems.
 
> I looked at the distribution of the jitter and these are very rare
> spikes. I ran cyclictest with 5 threads for 30000 cycles and the
> delay is always around 10-35 us except when there is a spike, which
> goes from 1000 to 7000us. These spikes are one-time ocurrences -
> they only last for one sample and sometimes only one of the threads
> is delayed, on other occasions 2 or 3 threads are delayed...

Can you please add "nohz=off" to the kernel command line and check
whether the problem persists ?

Thanks,

	tglx
