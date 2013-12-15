From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] migrate_disable pushd down in rt_read_trylock
Date: Sun, 15 Dec 2013 15:15:23 +0100
Message-ID: <20131215141522.GA15532@opentech.at>
References: <20131123005158.GA16338@opentech.at> <20131129151401.GD31099@linutronix.de> <20131129154425.GE31099@linutronix.de> <20131130023026.GB8114@opentech.at> <20131130064755.GA12036@opentech.at> <20131215131643.GC31090@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:53976 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494Ab3LOOPY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 09:15:24 -0500
Content-Disposition: inline
In-Reply-To: <20131215131643.GC31090@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 15 Dec 2013, Sebastian Andrzej Siewior wrote:

> * Nicholas Mc Guire | 2013-11-30 07:47:55 [+0100]:
> 
> >given that the broken patch was disabling once and enabling potentially a
> >number of times it should have triggert the
> >WARN_ON_ONCE(p->migrate_disable <= 0); in migrate_enable() if the recursive
> >case would have ever bin hit... so much to testing and locking...
> 
> And is why I removed the line
> > No change of functionality
> 
> from the change log because it was not obvious to me that is a
> zero-change patch :)

well that was the intent and obviously
it was not the case - so it served its purpose
to document the intent.

> 
> Are you going to redo this one?
>
no - as David Miller stated clearly that he sees these
split-api locks as a valid idiom and there were clear
worries that this would break in the future I see no point
in pushing this. The alternative of removing the recursive
migrate_disable/enable in local_bh_* directly is good
enough I guess - see: 
0001-make-migrate-disable-enable-conditioned-on-softirq_n.patch

thx!
hofrat

