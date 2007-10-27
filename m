From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6.23-rt3] NMI watchdog trace of deadlock
Date: Sat, 27 Oct 2007 15:16:19 +0200
Message-ID: <20071027131618.GA22589@elte.hu>
References: <1193245634.20679.8.camel@localhost.localdomain> <1193462494.25330.7.camel@Homer.simpson.net> <200710271915.42363.nickpiggin@yahoo.com.au> <20071027094407.GA12047@elte.hu> <1193480269.8374.3.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:35671 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbXJ0NQe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 09:16:34 -0400
Content-Disposition: inline
In-Reply-To: <1193480269.8374.3.camel@Homer.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> > it's not atomic interrupt context but irq thread context - and -rt 
> > remaps kmap_atomic() to kmap() internally.
> 
> Hm.  Looking at the change to mm/bounce.c, perhaps I should do this 
> instead?

yeah, this looks better.

	Ingo
