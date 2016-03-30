From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Wed, 30 Mar 2016 18:13:02 +0900
Message-ID: <20160330091302.GB2769@swordfish>
References: <1458641979.15742.6.camel@gmail.com>
 <20160330085622.GA21849@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34646 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824AbcC3JLz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 05:11:55 -0400
Received: by mail-pa0-f43.google.com with SMTP id fe3so35805761pab.1
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Mar 2016 02:11:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160330085622.GA21849@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On (03/30/16 10:56), Sebastian Andrzej Siewior wrote:
[..]
> >+static inline void zram_unlock_table(struct zram_table_entry *table)
> >+{
> >+	__clear_bit(ZRAM_ACCESS, &table->value);
> >+	spin_unlock(&table->lock);
> >+}
> 
> ZRAM_ACCESS is the only bit used for locking. ZRAM_ZERO is the only flag
> set / tested. 
> Would it be possible to make value u32 and add a spinlock? value is has
> not 64bit on 64bit systems and it uses only the first 23bits for the
> size and bit 24+25 for the two flags we have now. So the size should not
> change on 64bit systems only increase by four byte on 32bit systems.
> That is without the lock debugging of course.
> 
> Minchan, Nitin, Sergey do see any reason not to do so?

that's increased size for every table entry + lock debugging bloat;
not exactly what zram is trying to do. sounds bad enough.

	-ss
