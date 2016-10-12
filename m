From: Julia Cartwright <julia@ni.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 12 Oct 2016 12:15:53 -0500
Message-ID: <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
References: <20161012111251.74d1d52e@redhat.com>
 <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
 <20161012124956.3cb5f988@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        mst@redhat.com, paulmck@linux.vnet.ibm.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:60208 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754469AbcJLRRD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2016 13:17:03 -0400
In-Reply-To: <20161012124956.3cb5f988@redhat.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 12, 2016 at 12:49:56PM -0400, Luiz Capitulino wrote:
> On Wed, 12 Oct 2016 11:21:14 -0500
> Julia Cartwright <julia@ni.com> wrote:
> 
> > On Wed, Oct 12, 2016 at 11:12:51AM -0400, Luiz Capitulino wrote:
> > > Hi,
> > > 
> > > We have the following patch applied to the RT tree:
> > > 
> > >   commit a9d3cc781a3306bfa332fa7cb6134b70696058d5
> > >   Author: Josh Cartwright <joshc@ni.com>
> > >   Date:   Tue Oct 27 07:31:53 2015 -0500
> > >   
> > >       net: Make synchronize_rcu_expedited() conditional on !RT_FULL
> > > 
> > > However, as noted by Michael, making rcu_normal=1 default in the
> > > RT kernel should have the same effect (ie.  not calling
> > > synchronize_sched_expedited()).
> > > 
> > > So, honest question, is there a reason not to:
> > > 
> > >  1. Drop the patch above
> > >  2. Make rcu_normal=1 default?  
> > 
> > I think this is probably a cleaner way to fix the problems which
> > motivated this patch in the first place.  In my defense, the above patch
> > predates rcu_normal :).
> 
> No need to defend yourself! We debugged this very spike in one of
> our kernels that don't have rcu_normal. We decided to do exactly
> what you're doing before looking at upstream. Your patch helped
> us confirm that we were in the right track.

Great!  Glad I could help in some way!

> > Something like this, perhaps?
>
> Looks good, but (honest question) what does it buy us using
> rcu_normal_after_boot vs rcu_normal? Is the boot process
> improved someway?

That's the idea, although I don't have data to show much it actually
buys us.

> As long as we're rcu_normal=1 before launching user-space,
> this should be fine.

Agreed.

Thanks,
   Julia
