From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 20:46:50 +0200
Message-ID: <200709172046.50850.ak@suse.de>
References: <200709172012.21102.ak@suse.de> <1190053712.3253.79.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50377 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759219AbXIQSqy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 14:46:54 -0400
In-Reply-To: <1190053712.3253.79.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> > -static DEFINE_SPINLOCK(die_lock);
> > +static __raw_spinlock_t die_lock = __RAW_SPIN_LOCK_UNLOCKED;
> 
> You mean DEFINE_RAW_SPINLOCK() maybe? Unless I'm not following what your
> doing here..

I just copied that from tsc_sync.c.  If it's correct there it's presumably
correct here too.

-Andi
