From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT] seqlocks: use of PICK_FUNCTION breaks kernel compile when
	CONFIG_GENERIC_TIME is NOT set
Date: Wed, 17 Oct 2007 11:10:35 -0400
Message-ID: <1192633836.8265.6.camel@localhost.localdomain>
References: <1192632502.17527.129.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Remy Bohmer <linux@bohmer.net>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:53525 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbXJQPMD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 11:12:03 -0400
In-Reply-To: <1192632502.17527.129.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-10-17 at 07:48 -0700, Daniel Walker wrote:
> Steven, 
> 
> Could you include this patch, it was submitted on the list but you
> didn't get CC'd ..

Thanks, it may have been a while before I see this (/me has been nose
deep in debugging).

> > On Tue, 2007-10-16 at 10:35 +0200, Remy Bohmer wrote:
> > > Hello Daniel and Ingo,
> > > 
> > > I use 2.6.23-rt1 and the patch of Daniel below which seems to be in
> > > there breaks the compilation of the RT-kernel when CONFIG_GENERIC_TIME
> > > is NOT set.
> > > 
> > > It breaks in the do_gettimeofday(struct timeval *tv) code in the
> > > architecture specific code
> > > where there is a call to: seq = read_seqbegin_irqsave(&xtime_lock, flags);
> > > The PICK_FUNCTION implementation does not return anything, so the
> > > compile breaks here.
> > > 
> > > I am figuring out how to solve this problem nicely, but I have not
> > > found a nice solution yet. Attached I have put my hack to make it
> > > compile on ARM again, but maybe one of you can do a better proposal to
> > > fix this.
> > 
> > Here's another fix for this. I compile tested for ARM (!GENERIC_TIME) ,
> > but I didn't boot test .. Could you boot test this patch?
> > 
> > ---
> > 
> > Move the read_seqbegin() call up in the chain so the value 
> > can be returned
> > 
> > Signed-off-by: Daniel Walker <dwalker@mvista.com>
> > 
> > ---
> >  include/linux/seqlock.h |    7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > Index: linux-2.6.23/include/linux/seqlock.h
> > ===================================================================
> > --- linux-2.6.23.orig/include/linux/seqlock.h
> > +++ linux-2.6.23/include/linux/seqlock.h
> > @@ -285,21 +285,20 @@ unsigned long __read_seqbegin_irqsave_ra
> >  	unsigned long flags;
> >  
> >  	local_irq_save(flags);
> > -	__read_seqbegin_raw(sl);
> >  	return flags;
> >  }
> >  
> >  static __always_inline unsigned long __read_seqbegin_irqsave(seqlock_t *sl)
> >  {
> > -	__read_seqbegin(sl);
> >  	return 0;
> >  }

The above should be renamed. They have nothing to do with seqlocks now.

> >  
> >  #define read_seqbegin_irqsave(lock, flags)			\
> > -do {								\
> > +({								\
> >  	flags = PICK_SEQ_OP_RET(__read_seqbegin_irqsave_raw,	\
> >  		__read_seqbegin_irqsave, lock);			\
> > -} while (0)
> > +	read_seqbegin(lock);					\
> > +})

Yes, definitely the raw and unraw functions should be called
local_irqsave_raw or something else that makes this obvious to what it
is doing.

-- Steve
