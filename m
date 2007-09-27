From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Thu, 27 Sep 2007 10:24:59 -0400
Message-ID: <d120d5000709270724n1d318a88o2d9bd058f2d0f405@mail.gmail.com>
References: <20070926011139.GW8432@linux.vnet.ibm.com>
	 <20070926130326.GC19496@linux.vnet.ibm.com>
	 <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
	 <20070926155656.GA9101@linux.vnet.ibm.com>
	 <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
	 <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
	 <20070926195513.GA10544@linux.vnet.ibm.com>
	 <1190840086.18147.38.camel@lappy>
	 <Pine.LNX.4.58.0709261701460.6405@gandalf.stny.rr.com>
	 <20070926214219.GC10544@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:36853 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbXI0OZF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2007 10:25:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2231169nfb
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Sep 2007 07:25:03 -0700 (PDT)
In-Reply-To: <20070926214219.GC10544@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9/26/07, Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Sep 26, 2007 at 05:07:33PM -0400, Steven Rostedt wrote:
> >
> > --
> > On Wed, 26 Sep 2007, Peter Zijlstra wrote:
> > >
> > > On Wed, 2007-09-26 at 12:55 -0700, Paul E. McKenney wrote:
> > >
> > > > Well, we could make spin_lock_irqsave() invoke rcu_read_lock() and
> > > > spin_lock_irqrestore() invoke rcu_read_unlock(), with similar adjustments
> > > > to the other primitives in this group.  Then RCU priority boosting would
> > > > kick in if configured.
> > >
> > > Might be me, but 'hiding' the RCU scope like that makes my skin crawl.
> > > What is wrong with using rcu_read_lock() explicitly where you depend on
> > > it? It even makes the code cleaner in that it documents the usage.
> > >
> > > These blanket locks like lock_kernel(), preempt_disable(),
> > > local_irq_disable() etc. are very hard to get rid of because they don't
> > > document what is protected.
> > >
> > > Please lets not add to this mess and keep all this explicit.
> > >
> > > Yes, -rt changes the preemption model, and that has concequences. But
> > > IMHO the resulting code is cleaner in most cases.
> > >
> > > I'd go as far as to depricate synchronize_sched() and replace all its
> > > users with proper RCU.
> > >
> > > The more I think of it, the more I dislike this synchronize_all_irqs()
> > > and the 'magic' property of irq handlers.
> >
> > Thinking a little more about this, I fully agree with Peter.
>
> Again, it is not me that you need to convince.  ;-)
>
> > What code needs to know that all spin_locks have released, or you want to
> > know all irq handlers are done?
> >
> > Seems that this is a broad data to ask for and will be a bitch to clean up
> > when we find out that this is not scalable. This all sounds like
> > reinventing the BKL.
>
> It would scale just fine, and inherently does not need priority boosting
> (since preempted/blocked things cannot hold up sychronize_sched()).
> That said, I do agree with you that having things explicit is a good
> thing.
>
> > If you simply want a RCU type of scheme, then simply use RCU.  I second
> > deprecating "synchronize_sched". Everything that does RCU type locking
> > (that is waiting for some kind of grace period to finish) should simply
> > use RCU and not a "wait for all processes to voluntarily schedule" or
> > "wait for all interrupt handlers to finish".
>
> Here are the uses in 2.6.23-rc6.  There are several that might not
> be so easy to replace with RCU.
>

I will look into converting into "proper RCU" but I'd like you to
consider one more thing - proper RCU disables preemption, correct? So
it seems that converting code to "proper RCU" to some degree negates
the benefits of sleeping spinlocks introduced in -rt. If there was a
way to create synchronize_irq_spinlocks() that is separate from RCU
and could be preempted that would give the best of the 2 worlds.

-- 
Dmitry
