From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
	workqueue infrastructure
Date: Wed, 01 Aug 2007 13:34:27 -0700
Message-ID: <1186000468.2636.168.camel@imap.mvista.com>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net>
	 <1185940340.2636.97.camel@imap.mvista.com>
	 <1185987663.12034.99.camel@twins> <20070801181253.GA90@tv-sign.ru>
	 <1185992994.2636.142.camel@imap.mvista.com>
	 <20070801201802.GA225@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:37561 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbXHAUgT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2007 16:36:19 -0400
In-Reply-To: <20070801201802.GA225@tv-sign.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-08-02 at 00:18 +0400, Oleg Nesterov wrote:
> On 08/01, Daniel Walker wrote:
> >
> > On Wed, 2007-08-01 at 22:12 +0400, Oleg Nesterov wrote:
> > 
> > > And I personally think it is not very useful, even if it was correct.
> > > You can create your own workqueue and change the priority of cwq->thread.
> > 
> > This change is more dynamic than than just setting a single priority ..
> > There was some other work going on around this, so it's not totally
> > clear what the benefits are ..
> 
> Yes, I see. But still I think the whole idea is broken, not just the
> implementation.

It's translating priorities through the work queues, which doesn't seem
to happen with the current implementation. A high priority, say
SCHED_FIFO priority 99, task may have to wait for a nice -5 work queue
to finish.. You can set the priority of your work queue, but you never
know what the priority of the tasks are that use the work queue ..

> What about delayed_work? insert_work() will use ->normal_prio of
> the random interrupted process, while queue_work() uses current.

Actually it would be the priority of the timer softirq .. I think what
is desired here would be saving the priority of the task calling
delayed_work then using that..

> What if a niced thread queues the work? This work may have no chance
> to run if workqueue is actively used.

Yes , if it actively used by higher priority threads .. We could
restrict it to SCHED_FIFO/SCHED_RR tho ..

> > As the topic suggests , it's a Real Time kernel .. I can give you a link
> > where to download it if you want.
> 
> Ok, thanks, I'll take a look. Still, we can't use raw_smp_processor_id()
> unless we disabled cpu-hotplug.

I didn't touch this particular piece of code, but I'm assuming the
raw_smp_processor_id() is safe giving the rest of the code in -rt ..

Daniel
