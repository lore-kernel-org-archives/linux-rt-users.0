From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Wed, 30 Mar 2016 11:23:56 +0200
Message-ID: <1459329836.4175.16.camel@gmail.com>
References: <1458641979.15742.6.camel@gmail.com>
	 <20160330085622.GA21849@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37023 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcC3JX7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 05:23:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id p65so62376690wmp.0
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Mar 2016 02:23:59 -0700 (PDT)
In-Reply-To: <20160330085622.GA21849@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2016-03-30 at 10:56 +0200, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2016-03-22 11:19:39 [+0100]:
> 
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -568,12 +570,13 @@ static int zram_decompress_page(struct z
> > 	> > unsigned long handle;
> > 	> > size_t size;
> > 
> > -> > 	> > bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
> > +> > 	> > zram_lock_table(&meta->table[index]);
> > 	> > handle = meta->table[index].handle;
> > 	> > size = zram_get_obj_size(meta, index);
> > 
> > 	> > if (!handle || zram_test_flag(meta, index, ZRAM_ZERO)) {
> > 	> > 	> > bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
> > +> > 	> > 	> > zram_unlock_table(&meta->table[index]);
> 
> shouldn't you remove that ZRAM_ACCESS lock here?

Oops, yup.

> ZRAM_ACCESS is the only bit used for locking. ZRAM_ZERO is the only flag
> set / tested. 
> Would it be possible to make value u32 and add a spinlock? value is has
> not 64bit on 64bit systems and it uses only the first 23bits for the
> size and bit 24+25 for the two flags we have now. So the size should not
> change on 64bit systems only increase by four byte on 32bit systems.
> That is without the lock debugging of course.

I started going the raw locks route for the allocator instead of
whacking the bit spinlocks, given what it is, but chickened out when I
saw compression, and started thinking of just disabling it for rt
instead.  I flipped back, figuring a bloated zram gizmo is better than
no gizmo at all :-/

	-Mike
