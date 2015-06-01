From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] mm: ifdef out VM_BUG_ON check on PREEMPT_RT_FULL
Date: Mon, 1 Jun 2015 15:28:23 -0400
Message-ID: <20150601152823.405157c3@gandalf.local.home>
References: <20150529104815.2d2e880c@sluggy>
	<20150529142614.37792b9ff867626dcf5e0f08@linux-foundation.org>
	<20150601131452.3e04f10a@sluggy>
	<20150601190047.GA5879@cmpxchg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
	RT <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Johannes Weiner <hannes@cmpxchg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:40174 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750851AbbFAT21 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Jun 2015 15:28:27 -0400
In-Reply-To: <20150601190047.GA5879@cmpxchg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 1 Jun 2015 15:00:47 -0400
Johannes Weiner <hannes@cmpxchg.org> wrote:

> Andrew's suggestion makes sense, we can probably just delete the check
> as long as we keep the comment.
> 
> That being said, I think it's a little weird that this doesn't work:
> 
> spin_lock_irq()
> BUG_ON(!irqs_disabled())
> spin_unlock_irq()
> 
> I'd expect that if you change the meaning of spin_lock_irq() from
> "mask hardware interrupts" to "disable preemption by tophalf", you
> would update the irqs_disabled() macro to match.  Most people using
> this check probably don't care about the hardware state, only that
> they don't get preempted by an interfering interrupt handler, no?

The thing is, in -rt, there's no state to check if a spin_lock_irq()
was done. Adding that would add overhead to the rt_mutexes without much
gain.

The fast path of spin_lock_irq() in -rt looks like this:

	migrate_disable();
	rt_mutex_cmpxchg(lock, NULL, current);

Now, the migrate_disable() is more like preempt disable.

Although, maybe we could have -rt change irq_disabled() just check
that, and add a raw_irq_disabled() for when we need to make sure
interrupts are really off.

-- Steve


