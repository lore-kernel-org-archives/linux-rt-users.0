From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 13:47:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709261345530.19844@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
 <20070925193454.GH8432@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
 <20070926012447.7ffdd45a@lappy> <20070926011139.GW8432@linux.vnet.ibm.com>
 <20070926102833.17f7c025@twins> <20070926130326.GC19496@linux.vnet.ibm.com>
 <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
 <20070926155656.GA9101@linux.vnet.ibm.com> <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
 <20070926174341.GF9101@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61872 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbXIZRsU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 13:48:20 -0400
In-Reply-To: <20070926174341.GF9101@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--

On Wed, 26 Sep 2007, Paul E. McKenney wrote:
> >
> > As long as the list includes code guarded by
> > spin_lock_irqsave()/spin_unlock_irqrestore() I am happy. Does this
> > count as an irq-disable region? Peter said earlier that in -rt such
> > code still runs with IRQs enabled...
>
> If I remember correctly, it depends on whether the underlying spinlock
> is spinlock_t or raw_spinlock_t.
>
> However, doesn't spin_lock_irqsave() disable preemption in both cases
> (either explicitly for the spinlock_t case or implicitly via irq
> disable in the raw_spinlock_t case)?  If so, synchronize_all_irqs()
> should do what you want in both cases.

Nope not at all. In RT spin_lock_irqsave does not disable preemption.
That's part of the "features" of RT. And also why we want everyone to use
spin_lock_irqsave instead of local_irq_save. Because the later does
prevent preemption and adds latencies.

-- Steve
