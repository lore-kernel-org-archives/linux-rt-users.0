From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Tue, 1 Nov 2016 00:37:04 +0200
Message-ID: <20161101003510-mutt-send-email-mst@kernel.org>
References: <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
 <20161012124956.3cb5f988@redhat.com>
 <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
 <20161012203223.GK29518@linux.vnet.ibm.com>
 <20161013191332-mutt-send-email-mst@kernel.org>
 <20161014092050.GW29518@linux.vnet.ibm.com>
 <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
 <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
 <20161031181543.GN3716@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034466AbcJaWhH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 Oct 2016 18:37:07 -0400
Content-Disposition: inline
In-Reply-To: <20161031181543.GN3716@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Oct 31, 2016 at 11:15:43AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 31, 2016 at 06:38:52PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2016-10-16 04:28:46 [-0700], Paul E. McKenney wrote:
> > > If the relevant maintainers are OK with that, I am OK with it as long
> > > as it is non-default (at least to begin with) and does not introduce
> > > additional Kconfig questions.  My guess is that a boot parameter would
> > > work best, but something to discuss.
> > 
> > Okay. For me to summary:
> > - we want rcu_normal_after_boot=1 on -RT via CONFIG_PREEMPT_RT_FULL
> 
> That would be good.
> 
> > - this makes synchronize_rcu_expedited() behave like
> >   synchronize_rcu() and therefore I can drop all patches replacing
> >   synchronize_rcu_expedited() with synchronize_rcu().
> 
> And this would be a benefit.  ;-)
> 
> > - optionally it has been requested to make synchronize_rcu() behave like
> >   synchronize_rcu_expedited() on shutdown and kexec().
> 
> You can invoke rcu_unexpedite_gp() to force all subsequennt grace periods
> to be expedited, but you do need to clear rcu_normal for this to have
> effect.  Right now, that means "WRITE_ONCE(rcu_normal, 0)", but I could
> easily supply a formal API if you would prefer.  Which you probably
> would given  that TINY_RCU doesn't have rcu_normal...
> 
> > Did I miss understood / forgot something?
> 
> It would not hurt to boot with rcu_expedited if boot speed is critical,
> but I don't know whether or not this should be enabled by default.
> 
> 							Thanx, Paul

I don't know either but I'd like to know ATM it's expedited
by default.


> > Sebastian
> > 
