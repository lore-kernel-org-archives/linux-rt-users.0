From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Wed, 6 Jul 2016 09:32:56 -0400
Message-ID: <20160706093256.29406f9b@gandalf.local.home>
References: <20160630170134.GA3932@pd.tnic>
	<57755449.7070302@acm.org>
	<20160630172611.GC3932@pd.tnic>
	<57755CC6.60506@acm.org>
	<20160630182257.GD3932@pd.tnic>
	<577576AA.8040004@mvista.com>
	<20160630203457.GF3932@pd.tnic>
	<5775A181.2050404@acm.org>
	<20160701072050.GA4593@pd.tnic>
	<577C580F.8010004@acm.org>
	<20160706083704.GA7300@pd.tnic>
	<577CF39F.5010400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Borislav Petkov <bp@alien8.de>, Corey Minyard <minyard@acm.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:42551 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754040AbcGFNdA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jul 2016 09:33:00 -0400
In-Reply-To: <577CF39F.5010400@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 6 Jul 2016 07:03:43 -0500
Corey Minyard <cminyard@mvista.com> wrote:

> > ---
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> > index aaf4b9b94f38..cc70d98a30f6 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
> >   
> >   static void mce_notify_work(void)
> >   {
> > -	wake_up_process(mce_notify_helper);
> > +	if (mce_notify_helper)
> > +		wake_up_process(mce_notify_helper);
> >   }

Actually, this appears to be the fix in 4.6-rt.

> >   #else
> >   static void mce_notify_work(void)
> >
> >  
> I did think about that option, but I'm not sure why the current RT patch
> has that as a separate bool.
> 
> This appears to come in here:
> 
> http://www.spinics.net/lists/linux-rt-users/msg12779.html
> 
> I'm copying Sebastian, who appears to be the original source of this
> change.

You can see why this is different by looking at the commit that changed
it. Or this email:

 lkml.kernel.org/r/1365704626.9609.55.camel@gandalf.local.home

-- Steve
