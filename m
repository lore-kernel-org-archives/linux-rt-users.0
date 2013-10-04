From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Fri, 04 Oct 2013 16:08:47 +0200
Message-ID: <1380895727.5432.16.camel@marge.simpson.net>
References: <1379051751.5455.112.camel@marge.simpson.net>
	 <1379052760.5455.127.camel@marge.simpson.net>
	 <5234D94D.8010608@colorfullife.com>
	 <1379220340.5545.93.camel@marge.simpson.net>
	 <20131004104450.GB19953@linutronix.de>
	 <1380885410.5432.5.camel@marge.simpson.net>
	 <524EA673.5050400@linutronix.de>
	 <1380894919.5432.12.camel@marge.simpson.net>
	 <524ECA5F.1090803@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Manfred Spraul <manfred@colorfullife.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54811 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab3JDOI7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 10:08:59 -0400
In-Reply-To: <524ECA5F.1090803@colorfullife.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-10-04 at 16:02 +0200, Manfred Spraul wrote: 
> On 10/04/2013 03:55 PM, Mike Galbraith wrote:
> > On Fri, 2013-10-04 at 13:28 +0200, Sebastian Andrzej Siewior wrote:
> >> On 10/04/2013 01:16 PM, Mike Galbraith wrote:
> >>> Manfred's race fix also kills loop, and thereby the -rt livelock, so the
> >>> only question is does -rt want to use his completion wakeup scheme, and
> >>> does it want to do something about spin_unlock_wait() unconditionally
> >>> grabbing/releasing every lock in the array.
> >> So his patches went into v3.11 or so right? So all -RT released post
> >> this point will have it fixed right?
> > Most fixes have gone into master.  There's still at least one in the
> > pipe, ipc/sem.c: synchronize semop and semctl with IPC_RMID, and I
> > _think_ there's still one open issue.
> >
> > <quoting Manfred>
> > And now new:
> > 1) ipc/namespace.c:
> >       free_ipcs() still assumes the "old style" free calls:
> >       rcu_lock and ipc_lock dropped within the callback.
> >
> >       freeary() was converted - but free_ipcs was not updated.
> >
> >       Thus:
> >       Closing a namespace with sem arrays and threads that are waiting
> > on
> > the array with semtimedop() and bad timing can deadlock the semtimedop
> > thread.
> >       (i.e.: spin_lock() waiting forever).
> > </quoting Manfred>
> That one was a false alarm, i.e. everything is fixed in -mm.

Cool, that works out rather nicely.  I looked at fixing it, and couldn't
figure out what the heck was wrong with it :)

-Mike

