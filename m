From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [2.6.23-rt3] NMI watchdog trace of deadlock
Date: Sat, 27 Oct 2007 10:29:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710271028480.28295@gandalf.stny.rr.com>
References: <1193245634.20679.8.camel@localhost.localdomain>
 <1193462494.25330.7.camel@Homer.simpson.net>  <200710271915.42363.nickpiggin@yahoo.com.au>
  <20071027094407.GA12047@elte.hu> <1193480269.8374.3.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45658 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXJ0O3m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 10:29:42 -0400
In-Reply-To: <1193480269.8374.3.camel@Homer.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sat, 27 Oct 2007, Mike Galbraith wrote:
>
> Hm.  Looking at the change to mm/bounce.c, perhaps I should do this
> instead?
>
> --- ./fs/ntfs/aops.c.org	2007-10-27 10:16:40.000000000 +0200
> +++ ./fs/ntfs/aops.c	2007-10-27 12:11:07.000000000 +0200
> @@ -139,13 +139,13 @@ static void ntfs_end_buffer_async_read(s
>  		recs = PAGE_CACHE_SIZE / rec_size;
>  		/* Should have been verified before we got here... */
>  		BUG_ON(!recs);
> -		local_irq_save(flags);
> +		local_irq_save_nort(flags);
>  		kaddr = kmap_atomic(page, KM_BIO_SRC_IRQ);
>  		for (i = 0; i < recs; i++)
>  			post_read_mst_fixup((NTFS_RECORD*)(kaddr +
>  					i * rec_size), rec_size);
>  		kunmap_atomic(kaddr, KM_BIO_SRC_IRQ);
> -		local_irq_restore(flags);
> +		local_irq_restore_nort(flags);
>  		flush_dcache_page(page);
>  		if (likely(page_uptodate && !PageError(page)))
>  			SetPageUptodate(page);
>

Thanks, applied.

-- Steve
