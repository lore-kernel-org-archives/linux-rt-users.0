From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] release quicklist before free_page
Date: Mon, 23 Jul 2007 09:26:19 -0700
Message-ID: <1185207979.2573.55.camel@imap.mvista.com>
References: <20070723152129.036573829@mvista.com>
	 <1185208378.8197.20.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, paulmck@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:30790 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765548AbXGWQh2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 12:37:28 -0400
In-Reply-To: <1185208378.8197.20.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-23 at 18:32 +0200, Peter Zijlstra wrote:
> On Mon, 2007-07-23 at 08:21 -0700, Daniel Walker wrote:
> > Resolves,
> > 
> > BUG: sleeping function called from invalid context cc1(29651) at kernel/rtmutex.c:636
> > in_atomic():1 [00000001], irqs_disabled():0
> >  [<c0119f50>] __might_sleep+0xf3/0xf9
> >  [<c031600e>] __rt_spin_lock+0x21/0x3c
> >  [<c014102c>] get_zone_pcp+0x20/0x29
> >  [<c0141a40>] free_hot_cold_page+0xdc/0x167
> >  [<c013a3f4>] add_preempt_count+0x12/0xcc
> >  [<c0110d92>] pgd_dtor+0x0/0x1
> >  [<c015d865>] quicklist_trim+0xb7/0xe3
> >  [<c0111025>] check_pgt_cache+0x19/0x1c
> >  [<c0148df5>] free_pgtables+0x54/0x12c
> >  [<c013a3f4>] add_preempt_count+0x12/0xcc
> >  [<c014e5be>] unmap_region+0xeb/0x13b
> > 
> > 
> > It looks like the quicklist isn't used after a few variables are evaluated.
> > So no need to keep preemption disabled over the whole function.
> 
> Not quite, it uses preempt_disable() to avoid migration and stick to a
> cpu. Without that it might end up freeing pages from another quicklist.
> 
> How about this - compile tested only

How about a comment to go with it ?  Which says something like what's
above, notes on how the locking is getting used..

Daniel
