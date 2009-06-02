From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NOHZ: local_softirq_pending 02
Date: Tue, 2 Jun 2009 22:32:31 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906022231480.3419@localhost.localdomain>
References: <4de7f8a60905290458y478c73ban1275d92ff01997c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Jan Blunck <jblunck@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56521 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZFBUc4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2009 16:32:56 -0400
In-Reply-To: <4de7f8a60905290458y478c73ban1275d92ff01997c5@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 May 2009, Jan Blunck wrote:

> With 2.6.29.4-rt16 I get after some time under load following warnings:
> 
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> NOHZ: local_softirq_pending 02
> Clocksource tsc unstable (delta = 65308166 ns)
> 
> Seems that TIMER_SOFTIRQ is not run when properly. Any idea who caused this?

Hmm, no. Any receipe how to reproduce that ?

Thanks,

	tglx
