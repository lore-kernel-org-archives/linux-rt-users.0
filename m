From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANNOUNCE] 3.10.4-rt1
Date: Fri, 02 Aug 2013 15:05:17 +1000
Message-ID: <1375419917.3743.93.camel@pasglop>
References: <alpine.DEB.2.02.1308011215160.4089@ionos.tec.linutronix.de>
	 <CAP=VYLp1ERhS4cFtgXGHL2DfCGoJ9VbPvShH5ZOWCpPuSzQY6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52527 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab3HBFFd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Aug 2013 01:05:33 -0400
In-Reply-To: <CAP=VYLp1ERhS4cFtgXGHL2DfCGoJ9VbPvShH5ZOWCpPuSzQY6w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-08-01 at 20:03 -0400, Paul Gortmaker wrote:
> I've added Ben to the CC in case he has a suggestion on
> how best to fix this, even though it is not yet mainline.

Can you exchange with a TIF_ that isn't used in asm ? For example
TIF_PERFMON_* ? Keep all the asm ones below 16 and move up the ones
that are used in C only ?

Cheers,
Ben.


