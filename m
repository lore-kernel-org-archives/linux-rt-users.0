From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: 26 Jul 2007 10:47:40 -0400
Message-ID: <y0mps2f1asz.fsf@ton.toronto.redhat.com>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
	<1184615557.2698.3.camel@laptopd505.fenrus.org>
	<20070726072858.GC13061@in.ibm.com> <20070726133138.GA30559@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ankita Garg <ankita@in.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>, linux@bohmer.net,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbXGZOtI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 10:49:08 -0400
In-Reply-To: <20070726133138.GA30559@Krystal>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> writes:

> [...]
> The problem is also in _stp_print_flush, not *only* in relay code:
> void _stp_print_flush (void)
> ...
>                 spin_lock(&_stp_print_lock);
>                 ...
>                 spin_unlock(&_stp_print_lock);
> 
> Those will turn into mutexes with -rt.

Indeed, plus systemtap-generated locking code uses rwlocks,
local_irq_save/restore or preempt_disable, in various places.  Could
someone point to a place that spells out what would be more
appropriate way of ensuring atomicity while being compatible with -rt?

- FChE
