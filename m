From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] RT: fix spin_trylock_irq
Date: Mon, 15 Oct 2007 10:44:06 -0700
Message-ID: <1192470246.17527.15.camel@imap.mvista.com>
References: <20071011142417.1d965820@bull.net>
	 <Pine.LNX.4.58.0710111046170.20114@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:53302 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbXJORpl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 13:45:41 -0400
In-Reply-To: <Pine.LNX.4.58.0710111046170.20114@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-10-11 at 10:49 -0400, Steven Rostedt wrote:

> > ---
> >  include/linux/spinlock.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-2.6.23-rc9-rt2/include/linux/spinlock.h
> > ===================================================================
> > --- linux-2.6.23-rc9-rt2.orig/include/linux/spinlock.h
> > +++ linux-2.6.23-rc9-rt2/include/linux/spinlock.h
> > @@ -501,7 +501,7 @@ do {									\
> >
> >  #define spin_trylock_irq(lock)	\
> >  	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irq,		\
> > -		__spin_trylock_irq, lock))
> > +		_spin_trylock_irq, lock))
> >
> >  #define spin_trylock_irqsave(lock, flags) \
> >  	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irqsave, 	\
> 
> Thanks! Applied.
> 
> Daniel, this BUG was introduced by your conversion to PICK_FUNCTION patch.
> Please be more careful, and do an audit of your patch. (I don't have time
> ATM). This could also be the source of other bugs I've been chasing.
> 
> I might be pulling the PICK_FUNCTION patches if there's more bugs like
> this.

This is the second fix for this .. The first was in this email (over a
month ago)

http://lkml.org/lkml/2007/8/31/318

The above was emailed to Thomas, but I also sent you that link in IRC as
a link of patches to include .. I'll be happy to audit my code better,
but you should also audit your inclusion process better.. There have
been too many missed patches, and too many double and triples fixes..

Daniel
