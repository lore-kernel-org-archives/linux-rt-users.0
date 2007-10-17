From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [RT] seqlocks: use of PICK_FUNCTION breaks kernel compile when
	CONFIG_GENERIC_TIME is NOT set
Date: Wed, 17 Oct 2007 08:24:05 -0700
Message-ID: <1192634645.17527.134.camel@imap.mvista.com>
References: <1192632502.17527.129.camel@imap.mvista.com>
	 <1192633836.8265.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Remy Bohmer <linux@bohmer.net>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:4793 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760028AbXJQP0I (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 11:26:08 -0400
In-Reply-To: <1192633836.8265.6.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-10-17 at 11:10 -0400, Steven Rostedt wrote:

> > >  
> > >  #define read_seqbegin_irqsave(lock, flags)			\
> > > -do {								\
> > > +({								\
> > >  	flags = PICK_SEQ_OP_RET(__read_seqbegin_irqsave_raw,	\
> > >  		__read_seqbegin_irqsave, lock);			\
> > > -} while (0)
> > > +	read_seqbegin(lock);					\
> > > +})
> 
> Yes, definitely the raw and unraw functions should be called
> local_irqsave_raw or something else that makes this obvious to what it
> is doing.

Hmm.. I'm not sure what else to name them .. Since it's in the seqlock.h
I don't think it should be called anything "local_irq*" .. It could be
seq_irqsave_{raw} . 

Daniel
