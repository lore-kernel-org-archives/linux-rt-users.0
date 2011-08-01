From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Mon, 01 Aug 2011 13:06:29 +0200
Message-ID: <1312196789.2617.447.camel@laptop>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
	 <CABcS5h0m10aWDuK5fK4C-mzMMwLyXJ_cehoTgWFutvPPrv30HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Rolando Martins <rolando.martins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51603 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1HALBs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 07:01:48 -0400
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QnqFn-000321-M0
	for linux-rt-users@vger.kernel.org; Mon, 01 Aug 2011 11:01:47 +0000
In-Reply-To: <CABcS5h0m10aWDuK5fK4C-mzMMwLyXJ_cehoTgWFutvPPrv30HQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-01 at 09:42 +0100, Rolando Martins wrote:
> Hi Peter,
> is there any progress on the CONFIG_RT_GROUP_SCHED front?
> I don't know if this is related, but in 33-rt if I used a low (=100)
> cpu_runtime_us and cpu_period_us then I would get some freezes
> (something that does not happen in 2.6.39).
> 
> 
No, I've been busy mopping up other things.. Ideally I'd rip out all the
current rt group code and put int the stuff Dario and Fabio are working
on, sadly they too are otherwise engaged atm.

I'll see if I can find a bit of time this week to stare at this mess.

