From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] mm: change irqs_disabled() test to spin_is_locked() in
 mem_cgroup_swapout
Date: Fri, 29 May 2015 14:26:14 -0700
Message-ID: <20150529142614.37792b9ff867626dcf5e0f08@linux-foundation.org>
References: <20150529104815.2d2e880c@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
	RT <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56615 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbE2V0Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 May 2015 17:26:16 -0400
In-Reply-To: <20150529104815.2d2e880c@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 May 2015 10:48:15 -0500 Clark Williams <williams@redhat.com> wrote:

> The irqs_disabled() check in mem_cgroup_swapout() fails on the latest
> RT kernel because RT mutexes do not disable interrupts when held. Change
> the test for the lock being held to use spin_is_locked.
>
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5845,7 +5845,7 @@ void mem_cgroup_swapout(struct page *page,
> swp_entry_t entry) page_counter_uncharge(&memcg->memory, 1);
>  
>  	/* XXX: caller holds IRQ-safe mapping->tree_lock */
> -	VM_BUG_ON(!irqs_disabled());
> +	VM_BUG_ON(!spin_is_locked(&page_mapping(page)->tree_lock));
>  
>  	mem_cgroup_charge_statistics(memcg, page, -1);
>  	memcg_check_events(memcg, page);

spin_is_locked() returns zero on uniprocessor builds.  The results will
be unhappy.  

I suggest just deleting the check.
