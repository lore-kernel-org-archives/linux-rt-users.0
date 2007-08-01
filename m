From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
	workqueue infrastructure
Date: Wed, 01 Aug 2007 11:29:54 -0700
Message-ID: <1185992994.2636.142.camel@imap.mvista.com>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net>
	 <1185940340.2636.97.camel@imap.mvista.com>
	 <1185987663.12034.99.camel@twins>  <20070801181253.GA90@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764896AbXHASbz@vger.kernel.org>
In-Reply-To: <20070801181253.GA90@tv-sign.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-08-01 at 22:12 +0400, Oleg Nesterov wrote:

> And I personally think it is not very useful, even if it was correct.
> You can create your own workqueue and change the priority of cwq->thread.

This change is more dynamic than than just setting a single priority ..
There was some other work going on around this, so it's not totally
clear what the benefits are ..

> > > @@ -168,7 +171,7 @@ int fastcall queue_work(struct workqueue
> > >  	int ret = 0, cpu = raw_smp_processor_id();
> > >  
> > >  	if (!test_and_set_bit(WORK_STRUCT_PENDING, work_data_bits(work))) {
> > > -		BUG_ON(!list_empty(&work->entry));
> > > +		BUG_ON(!plist_node_empty(&work->entry));
> > >  		__queue_work(wq_per_cpu(wq, cpu), work);
> > >  		ret = 1;
> 
> Side note, looks like you use some strange kernel. This raw_smp_processor_id()
> above is wrong.

As the topic suggests , it's a Real Time kernel .. I can give you a link
where to download it if you want.

Daniel
