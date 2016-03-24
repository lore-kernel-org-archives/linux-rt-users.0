From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Thu, 24 Mar 2016 12:06:34 +0100
Message-ID: <1458817594.3972.16.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38139 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbcCXLGn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 07:06:43 -0400
In-Reply-To: <alpine.DEB.2.11.1603241140510.3978@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:
>  
> > On the bright side, with the busted migrate enable business reverted,
> > plus one dinky change from me [1], master-rt.today has completed 100
> > iterations of Steven's hotplug stress script along side endless
> > futexstress, and is happily doing another 900 as I write this, so the
> > next -rt should finally be hotplug deadlock free.
> > 
> > Thomas's state machinery seems to work wonders.  'course this being
> > hotplug, the other shoe will likely apply itself to my backside soon.
> 
> That's a given :)

blk-mq applied it shortly after I was satisfied enough to poke xmit.

> I really wonder what makes the change. The only thing which comes to my mind
> is the enforcement of running the online and down_prepare callbacks on the
> plugged cpu instead of doing it wherever the scheduler decides to run it.

No idea, but it certainly seems.. well, markedly less brick like.
 
> > 1. nest module_mutex inside hotplug_lock to prevent bloody systemd
> > -udevd from blocking in migrate_disable() while holding kernfs_mutex
> > during module load, putting a quick end to hotplug stress testing.
>  
> Did I miss a patch here or is that still in your pile?

You didn't miss it, it wasn't tested enough to consider sending.. and
now I'm starting down the familiar "next" path again.  Oh dear.

	-Mike
