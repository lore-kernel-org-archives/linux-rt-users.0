From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 12 Oct 2016 13:32:23 -0700
Message-ID: <20161012203223.GK29518@linux.vnet.ibm.com>
References: <20161012111251.74d1d52e@redhat.com>
 <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
 <20161012124956.3cb5f988@redhat.com>
 <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        mst@redhat.com
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932566AbcJLUc2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2016 16:32:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9CKTIwC115191
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2016 16:32:28 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 261qhe7b8f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2016 16:32:27 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Oct 2016 14:32:27 -0600
Content-Disposition: inline
In-Reply-To: <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 12, 2016 at 12:15:53PM -0500, Julia Cartwright wrote:
> On Wed, Oct 12, 2016 at 12:49:56PM -0400, Luiz Capitulino wrote:
> > On Wed, 12 Oct 2016 11:21:14 -0500
> > Julia Cartwright <julia@ni.com> wrote:
> > 
> > > On Wed, Oct 12, 2016 at 11:12:51AM -0400, Luiz Capitulino wrote:
> > > > Hi,
> > > > 
> > > > We have the following patch applied to the RT tree:
> > > > 
> > > >   commit a9d3cc781a3306bfa332fa7cb6134b70696058d5
> > > >   Author: Josh Cartwright <joshc@ni.com>
> > > >   Date:   Tue Oct 27 07:31:53 2015 -0500
> > > >   
> > > >       net: Make synchronize_rcu_expedited() conditional on !RT_FULL
> > > > 
> > > > However, as noted by Michael, making rcu_normal=1 default in the
> > > > RT kernel should have the same effect (ie.  not calling
> > > > synchronize_sched_expedited()).
> > > > 
> > > > So, honest question, is there a reason not to:
> > > > 
> > > >  1. Drop the patch above
> > > >  2. Make rcu_normal=1 default?  
> > > 
> > > I think this is probably a cleaner way to fix the problems which
> > > motivated this patch in the first place.  In my defense, the above patch
> > > predates rcu_normal :).
> > 
> > No need to defend yourself! We debugged this very spike in one of
> > our kernels that don't have rcu_normal. We decided to do exactly
> > what you're doing before looking at upstream. Your patch helped
> > us confirm that we were in the right track.
> 
> Great!  Glad I could help in some way!
> 
> > > Something like this, perhaps?
> >
> > Looks good, but (honest question) what does it buy us using
> > rcu_normal_after_boot vs rcu_normal? Is the boot process
> > improved someway?
> 
> That's the idea, although I don't have data to show much it actually
> buys us.

It means that grace periods can be expedited during boot.  If you really
care about boot speed, you can also set rcu_expedited=1 and also
rcu_normal_after_boot=1, which will expedite all grace periods during
the boot process, but stop doing so just before spawning init.
After that point, any attempt to do an expedited grace period gets you
a normal grace period instead.

So you get fast boot and then clean realtime.

> > As long as we're rcu_normal=1 before launching user-space,
> > this should be fine.
> 
> Agreed.

Yes, you can also set them manually instead of at boot, if you wish.

							Thanx, Paul

