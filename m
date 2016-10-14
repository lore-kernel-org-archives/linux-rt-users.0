From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Fri, 14 Oct 2016 02:20:50 -0700
Message-ID: <20161014092050.GW29518@linux.vnet.ibm.com>
References: <20161012111251.74d1d52e@redhat.com>
 <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
 <20161012124956.3cb5f988@redhat.com>
 <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
 <20161012203223.GK29518@linux.vnet.ibm.com>
 <20161013191332-mutt-send-email-mst@kernel.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org, bigeasy@linutronix.de
To: "Michael S. Tsirkin" <mst@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752436AbcJNJVA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Oct 2016 05:21:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9E9J9hP126033
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Oct 2016 05:20:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 262uvbtess-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Oct 2016 05:20:54 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Oct 2016 03:20:53 -0600
Content-Disposition: inline
In-Reply-To: <20161013191332-mutt-send-email-mst@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Oct 13, 2016 at 07:25:56PM +0300, Michael S. Tsirkin wrote:
> On Wed, Oct 12, 2016 at 01:32:23PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 12, 2016 at 12:15:53PM -0500, Julia Cartwright wrote:
> > > On Wed, Oct 12, 2016 at 12:49:56PM -0400, Luiz Capitulino wrote:
> > > > On Wed, 12 Oct 2016 11:21:14 -0500
> > > > Julia Cartwright <julia@ni.com> wrote:
> > > > 
> > > > > On Wed, Oct 12, 2016 at 11:12:51AM -0400, Luiz Capitulino wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > We have the following patch applied to the RT tree:
> > > > > > 
> > > > > >   commit a9d3cc781a3306bfa332fa7cb6134b70696058d5
> > > > > >   Author: Josh Cartwright <joshc@ni.com>
> > > > > >   Date:   Tue Oct 27 07:31:53 2015 -0500
> > > > > >   
> > > > > >       net: Make synchronize_rcu_expedited() conditional on !RT_FULL
> > > > > > 
> > > > > > However, as noted by Michael, making rcu_normal=1 default in the
> > > > > > RT kernel should have the same effect (ie.  not calling
> > > > > > synchronize_sched_expedited()).
> > > > > > 
> > > > > > So, honest question, is there a reason not to:
> > > > > > 
> > > > > >  1. Drop the patch above
> > > > > >  2. Make rcu_normal=1 default?  
> > > > > 
> > > > > I think this is probably a cleaner way to fix the problems which
> > > > > motivated this patch in the first place.  In my defense, the above patch
> > > > > predates rcu_normal :).
> > > > 
> > > > No need to defend yourself! We debugged this very spike in one of
> > > > our kernels that don't have rcu_normal. We decided to do exactly
> > > > what you're doing before looking at upstream. Your patch helped
> > > > us confirm that we were in the right track.
> > > 
> > > Great!  Glad I could help in some way!
> > > 
> > > > > Something like this, perhaps?
> > > >
> > > > Looks good, but (honest question) what does it buy us using
> > > > rcu_normal_after_boot vs rcu_normal? Is the boot process
> > > > improved someway?
> > > 
> > > That's the idea, although I don't have data to show much it actually
> > > buys us.
> > 
> > It means that grace periods can be expedited during boot.  If you really
> > care about boot speed, you can also set rcu_expedited=1 and also
> > rcu_normal_after_boot=1, which will expedite all grace periods during
> > the boot process, but stop doing so just before spawning init.
> > After that point, any attempt to do an expedited grace period gets you
> > a normal grace period instead.
> > 
> > So you get fast boot and then clean realtime.
> > 
> > > > As long as we're rcu_normal=1 before launching user-space,
> > > > this should be fine.
> > > 
> > > Agreed.
> > 
> > Yes, you can also set them manually instead of at boot, if you wish.
> > 
> > 							Thanx, Paul
> 
> FWIW
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> But I have a question - here's the commit that started
> it all:
> 
> 
> commit be3fc413da9eb17cce0991f214ab019d16c88c41
> Author: Eric Dumazet <eric.dumazet@gmail.com>
> Date:   Mon May 23 23:07:32 2011 +0000
> 
>     net: use synchronize_rcu_expedited()
>     
>     synchronize_rcu() is very slow in various situations (HZ=100,
>     CONFIG_NO_HZ=y, CONFIG_PREEMPT=n)
>     
>     Extract from my (mostly idle) 8 core machine :
>     
>      synchronize_rcu() in 99985 us
>      synchronize_rcu() in 79982 us
>      synchronize_rcu() in 87612 us
>      synchronize_rcu() in 79827 us
>      synchronize_rcu() in 109860 us
>      synchronize_rcu() in 98039 us
>      synchronize_rcu() in 89841 us
>      synchronize_rcu() in 79842 us
>      synchronize_rcu() in 80151 us
>      synchronize_rcu() in 119833 us
>      synchronize_rcu() in 99858 us
>      synchronize_rcu() in 73999 us
>      synchronize_rcu() in 79855 us
>      synchronize_rcu() in 79853 us
>     
>     When we hold RTNL mutex, we would like to spend some cpu cycles but not
>     block too long other processes waiting for this mutex.
>     
>     We also want to setup/dismantle network features as fast as possible at
>     boot/shutdown time.
> 
> 
> To make sure this does not regress for RT,
> how about clearing this flag on shutdown as well?

By that, you mean having some way to force all grace periods to be
expedited during shutdown?  Or am I missing your point?

							Thanx, Paul

