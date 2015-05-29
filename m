From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC] mm: change irqs_disabled() test to spin_is_locked() in
 mem_cgroup_swapout
Date: Fri, 29 May 2015 15:11:59 -0400
Message-ID: <20150529191159.GA29078@cmpxchg.org>
References: <20150529104815.2d2e880c@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gum.cmpxchg.org ([85.214.110.215]:50139 "EHLO gum.cmpxchg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539AbbE2TMT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 May 2015 15:12:19 -0400
Content-Disposition: inline
In-Reply-To: <20150529104815.2d2e880c@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

On Fri, May 29, 2015 at 10:48:15AM -0500, Clark Williams wrote:
> @@ -5845,7 +5845,7 @@ void mem_cgroup_swapout(struct page *page,
> swp_entry_t entry) page_counter_uncharge(&memcg->memory, 1);
>  
>  	/* XXX: caller holds IRQ-safe mapping->tree_lock */
> -	VM_BUG_ON(!irqs_disabled());
> +	VM_BUG_ON(!spin_is_locked(&page_mapping(page)->tree_lock));
>  
>  	mem_cgroup_charge_statistics(memcg, page, -1);

It's not about the lock, it's about preemption.  The charge statistics
use __this_cpu operations and they're updated from process context and
interrupt context both.

This function really should do a local_irq_save().  I only added the
VM_BUG_ON() to document that we know the caller is holding an IRQ-safe
lock and so we don't need to bother with another level of IRQ saving.

So how does this translate to RT?  I don't know.  But if switching to
explicit IRQ toggling would help you guys out we can do that.  It is
in the swapout path after all, the optimization isn't that important.
