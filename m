From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 11:54:04 -0700
Message-ID: <1190055244.3253.95.camel@imap.mvista.com>
References: <200709172012.21102.ak@suse.de>
	 <1190053712.3253.79.camel@imap.mvista.com>  <200709172046.50850.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:40830 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbXIQS4R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 14:56:17 -0400
In-Reply-To: <200709172046.50850.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 20:46 +0200, Andi Kleen wrote:
> > > -static DEFINE_SPINLOCK(die_lock);
> > > +static __raw_spinlock_t die_lock = __RAW_SPIN_LOCK_UNLOCKED;
> > 
> > You mean DEFINE_RAW_SPINLOCK() maybe? Unless I'm not following what your
> > doing here..
> 
> I just copied that from tsc_sync.c.  If it's correct there it's presumably
> correct here too.
> 
> -Andi

/*
 * We use a raw spinlock in this exceptional case, because
 * we want to have the fastest, inlined, non-debug version
 * of a critical section, to be able to prove TSC time-warps:
 */
static __cpuinitdata __raw_spinlock_t sync_lock = __RAW_SPIN_LOCK_UNLOCKED;


Since it's all got "__" in the front, not good to use this method all
over .. If you just need a real spinlock best to use
DEFINE_RAW_SPINLOCK() unless your a special situation ..

Daniel
