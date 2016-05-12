From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH RESEND -rt] mm: perform lru_add_drain_all() remotely
Date: Thu, 12 May 2016 15:52:02 -0400
Message-ID: <20160512155202.46666531@redhat.com>
References: <20160509105037.1555d0e0@redhat.com>
	<20160512084230.GA19035@linutronix.de>
	<20160512095149.2a6f7357@redhat.com>
	<20160512144943.GD19035@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47034 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbcELTwE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 May 2016 15:52:04 -0400
In-Reply-To: <20160512144943.GD19035@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 12 May 2016 16:49:43 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Luiz Capitulino | 2016-05-12 09:51:49 [-0400]:
> 
> >That's correct. This is an -RT patch for two reasons:
> >
> > 1. This solution builds on top of the per-cpu locks API implemented
> >    by -RT and already in place in the pagevecs drain code
> >
> > 2. As SCHED_FIFO is the norm in -RT, the problem is more common there  
> 
> more common so not RT-only. Would you people prefer this for mainline or
> would you rather something else in case this needs to be fixed
> mainline, too?

To have this for mainline we'd have to forward-port local_locks.
It's doable, but I think it's a bit too much only to solve this
problem.

The alternative, which is what I had in mind, was to forward-port
this change to mainline when local_locks gets merged upstream. But
I guess this will only happen when sleeping spinlocks are merged?
