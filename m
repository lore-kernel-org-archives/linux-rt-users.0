From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 08 Apr 2016 08:35:51 +0200
Message-ID: <1460097351.5582.15.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <57068F28.8010409@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36623 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757603AbcDHGfz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2016 02:35:55 -0400
In-Reply-To: <57068F28.8010409@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2016-04-07 at 18:47 +0200, Sebastian Andrzej Siewior wrote:

> > If that lock dies, we can unpin when entering lock slow path and pin
> > again post acquisition with no ABBA worries as well, and not only does
> > existing hotplug work heaping truckloads better, -rt can perhaps help
> > spot trouble as the rewrite proceeds.
> > 
> > Current state is more broken than ever.. if that's possible.
> 
> And the two patches you attached here did?

Re-reading your question, no, the only troubles I encountered were the
rt specific woes previously identified.  So the thought that started me
down this path turned up jack-diddly-spit.. but that's not a bad thing,
so I don't consider it to have been a waste of time.

	-Mike
