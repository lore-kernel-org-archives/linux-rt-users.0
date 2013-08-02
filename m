From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANNOUNCE] 3.10.4-rt1
Date: Sat, 03 Aug 2013 07:20:57 +1000
Message-ID: <1375478457.15999.25.camel@pasglop>
References: <alpine.DEB.2.02.1308011215160.4089@ionos.tec.linutronix.de>
	 <CAP=VYLp1ERhS4cFtgXGHL2DfCGoJ9VbPvShH5ZOWCpPuSzQY6w@mail.gmail.com>
	 <1375419917.3743.93.camel@pasglop> <51FBA9CC.2090206@linutronix.de>
	 <20130802141936.GA8267@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51848 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab3HBVV1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Aug 2013 17:21:27 -0400
In-Reply-To: <20130802141936.GA8267@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-08-02 at 10:19 -0400, Paul Gortmaker wrote:
> 
> Yep, 3.8 shuffled TIF_MEMDIE to the end of the queue, but
> in 3.10, mainline commit 22ecbe8dcef has already done that trick.
> 
> The list of donor victims that aren't used in asm is getting
> smaller, but TIF_POLLING_NRFLAG seems OK and it puts RESCHED
> and RESCHED_LAZY right beside each other.

Worst case we can turn it into a 32-bit and but I'd rather avoid it
as long as we can :-)

Cheers,
Ben.


