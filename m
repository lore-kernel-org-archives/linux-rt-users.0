From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Possible bug in 23rt3 preempt-irqs-core.patch
Date: Fri, 26 Oct 2007 11:38:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710261136550.3523@gandalf.stny.rr.com>
References: <20071025204853.GB12268@windriver.com>
 <Pine.LNX.4.58.0710260920300.18997@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:45762 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbXJZPiV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2007 11:38:21 -0400
In-Reply-To: <Pine.LNX.4.58.0710260920300.18997@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 26 Oct 2007, Steven Rostedt wrote:

>
> --
> On Thu, 25 Oct 2007, Paul Gortmaker wrote:
>
> > I was looking over the patches in preempt-irqs-core.patch in the broken
> > out 23rt3 series and came across this chunk:
> >
> > -----------
> > @@ -325,6 +349,11 @@ int setup_irq(unsigned int irq, struct i
> >         if (!shared) {
> >                 irq_chip_set_defaults(desc->chip);
> >
> > +       /*
> > +        * Propagate any possible IRQF_NODELAY flag into IRQ_NODELAY:
> > +        */
> > +       recalculate_desc_flags(desc);
> > +
> >  #if defined(CONFIG_IRQ_PER_CPU)
> >                 if (new->flags & IRQF_PERCPU)
> >                         desc->status |= IRQ_PER_CPU;
> > -----------
> >
> > Note the recalculate is actually contained within the "if (!shared)"
> > even though at a casual glance the indentation suggests otherwise.
> >
> > Looking at older versions of the broken out patches leads me to believe
> > the if clause should be after the recalculate.  I've attached a patch to
> > do just that, but if you'd rather I just respin the preempt-irqs-core.patch
> > then I could just as easily do that as well.
> >
>
> Grumble,  That's what I get for keeping fuzzy patching turned on in quilt
> :-(
>

Looking at the patch set I started with, the bug exists there too. I just
did a full -F0 rework of what I started with and didn't find anything else
that could have been caused by fuzzy logic. Seems this bug crept in before
I took over as patch monkey.

-- Steve
