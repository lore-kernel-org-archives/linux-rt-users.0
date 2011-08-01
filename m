From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Mon, 01 Aug 2011 12:34:02 +0200
Message-ID: <1312194842.8233.88.camel@marge.simson.net>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
	 <CABcS5h0m10aWDuK5fK4C-mzMMwLyXJ_cehoTgWFutvPPrv30HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Rolando Martins <rolando.martins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:47007 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753624Ab1HAKeH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 06:34:07 -0400
In-Reply-To: <CABcS5h0m10aWDuK5fK4C-mzMMwLyXJ_cehoTgWFutvPPrv30HQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-01 at 09:42 +0100, Rolando Martins wrote:
> Hi Peter,
> is there any progress on the CONFIG_RT_GROUP_SCHED front?

Out of curiosity, why would you want that in a -rt kernel?

(I haven't done any PI testing with that, but I can imagine the throttle
causing heartburn)

	-Mike

> I don't know if this is related, but in 33-rt if I used a low (=100)
> cpu_runtime_us and cpu_period_us then I would get some freezes
> (something that does not happen in 2.6.39).

(providing a realtime budget of 100 whole microseconds to a kernel where
everything and it's brother is realtime is unlikely to go well)

