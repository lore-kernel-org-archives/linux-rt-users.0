From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Sun, 15 Sep 2013 06:45:40 +0200
Message-ID: <1379220340.5545.93.camel@marge.simpson.net>
References: <1379051751.5455.112.camel@marge.simpson.net>
	 <1379052760.5455.127.camel@marge.simpson.net>
	 <5234D94D.8010608@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Manfred Spraul <manfred@colorfullife.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59094 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab3IOEpy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Sep 2013 00:45:54 -0400
In-Reply-To: <5234D94D.8010608@colorfullife.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2013-09-14 at 23:46 +0200, Manfred Spraul wrote: 
> Hi Mike,
> 
> On 09/13/2013 08:12 AM, Mike Galbraith wrote:
> > goto again loop can and does induce livelock in -rt.  Remove it.
> >
> > spin_unlock_wait(lock) in -rt kernels takes/releases the lock in question, so
> > all it takes to create a self perpetuating loop is for one task to start the
> > ball rolling by taking the array lock, other tasks see this, and react by
> > take/release/retry endlessly.
> I think your code inherits the race I just sent to you:
> The test of complex_count must be after spin_is_locked().
> 
> http://marc.info/?l=linux-kernel&m=137919453307294
> 
> Could you check that?

I think you're right.

> Or alternatively: Is my proposed sem_lock() function -rt friendly?

Some way of making spin_unlock_wait() _go away_ along with the livelock
would be better, but patches look good to me.  I'll apply both and stare
at the sum, and ask boxen what they think.. they're better at spotting
locking troubles ;-)

-Mike

