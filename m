From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
	workqueue infrastructure
Date: Wed, 01 Aug 2007 13:43:52 -0700
Message-ID: <1186001032.2636.176.camel@imap.mvista.com>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net>
	 <1185940340.2636.97.camel@imap.mvista.com>
	 <1185987663.12034.99.camel@twins> <20070801181253.GA90@tv-sign.ru>
	 <1185992994.2636.142.camel@imap.mvista.com>
	 <20070801201802.GA225@tv-sign.ru>  <20070801203212.GC225@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:41152 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbXHAUpr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2007 16:45:47 -0400
In-Reply-To: <20070801203212.GC225@tv-sign.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-08-02 at 00:32 +0400, Oleg Nesterov wrote:
> On 08/02, Oleg Nesterov wrote:
> >
> > And I don't understand why rt_mutex_setprio() is called just before
> > calling work->func(). This means that a high-priority work could
> > be delayed by the low-priority ->current_work.
> 
> Aha, I missed the rt_mutex_setprio() in insert_work().
> 
> This is not good either. Suppose we have
> 
> 	void work_handler(struct work_struct *self)
> 	{
> 		if (!try_lock()) {
> 			// try again later...
> 			queue_work(wq, self);
> 			return;
> 		}
> 
> 		do_the_work();
> 	}
> 
> What if that work was queued by the low-priority thread, and
> then a high-priority thread inserts a new work when work_handler()
> is running?

You mean the above queue_work(wq, self) would get an arbitrarily higher
priority vs. what it would normally? 

Yeah, I suppose we would want follow the priority inside the workqueue
thread only ..

Daniel
