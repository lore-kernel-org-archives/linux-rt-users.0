From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT] blk-mq: revert raw locks, post pone notifier to
 POST_DEAD
Date: Wed, 07 May 2014 11:07:17 +0200
Message-ID: <1399453637.5142.40.camel@marge.simpson.net>
References: <1399135344-5349-1-git-send-email-bigeasy@linutronix.de>
	 <1399136587.5158.29.camel@marge.simpson.net>
	 <5369EC9E.1010904@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:33669 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbaEGJHU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 May 2014 05:07:20 -0400
Received: by mail-ee0-f53.google.com with SMTP id c13so483472eek.40
        for <linux-rt-users@vger.kernel.org>; Wed, 07 May 2014 02:07:19 -0700 (PDT)
In-Reply-To: <5369EC9E.1010904@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2014-05-07 at 10:19 +0200, Sebastian Andrzej Siewior wrote: 
> On 05/03/2014 07:03 PM, Mike Galbraith wrote:
> >> Mike, I see that lockdep splat (sleeping while atomic) during cpu-hotplug.
> >> Don't you see this, too?
> > 
> > Nope, didn't.
> 
> Hmm. blk_mq_hctx_notify(). It does
> 	spin_lock(&ctx->lock);
> 
> Isn't this a sleeping spinlock for you or don't get here at all?

Hm, cts->lock...

git@marge:~/suse/scratch_area/linux-3.12-SLE12-RT> grep -IR cpu_lock block
git@marge:~/suse/scratch_area/linux-3.12-SLE12-RT>

(here lock lock lock, here boy)

marge:/usr/local/src/kernel/linux-3.x.git # grep -IR cpu_lock block
marge:/usr/local/src/kernel/linux-3.x.git # 

marge:/usr/local/src/kernel/linux-3.14 # grep -IR cpu_lock block
marge:/usr/local/src/kernel/linux-3.14 #

(what the..)

marge:/usr/local/src/kernel/linux-3.14-rt # grep -IR cpu_lock block
block/blk-mq.c: spin_lock(&ctx->cpu_lock);
block/blk-mq.c: spin_unlock(&ctx->cpu_lock);
block/blk-mq.c:                         spin_unlock(&ctx->cpu_lock);
block/blk-mq.c:                         spin_lock(&ctx->cpu_lock);
block/blk-mq.c:         spin_lock_init(&__ctx->cpu_lock);
block/blk-mq.h: spinlock_t              cpu_lock;
marge:/usr/local/src/kernel/linux-3.14-rt #

(aha!)

Nope, I definitely don't get there.

	-Mike

