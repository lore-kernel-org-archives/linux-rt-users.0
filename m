From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Tue, 27 Oct 2015 08:27:53 -0700
Message-ID: <1445959673.7476.48.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1445886895-3692-1-git-send-email-joshc@ni.com>
	 <20151027004422.GH5105@linux.vnet.ibm.com>
	 <20151027123153.GG8245@jcartwri.amer.corp.natinst.com>
	 <1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
	 <20151027150251.GH9405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Josh Cartwright <joshc@ni.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Clark Williams <williams@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151027150251.GH9405@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-10-27 at 12:02 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 27, 2015 at 07:18:01AM -0700, Eric Dumazet escreveu:
> > On Tue, 2015-10-27 at 07:31 -0500, Josh Cartwright wrote:
> > 
> > > Okay, yes, I like the first suggestion better as well, I've included a
> > > patch below that does just that.  I hope you don't mind me turning it
> > > into a Suggested-by :).
> > > 
> > > Thanks for taking a look!
> > >   Josh
> > 
> > 
> > > @@ -6969,7 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
> > >  void synchronize_net(void)
> > >  {
> > >  	might_sleep();
> > > -	if (rtnl_is_locked())
> > > +	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> > >  		synchronize_rcu_expedited();
> > >  	else
> > >  		synchronize_rcu();
> > 
> > No objection from me. Thanks.
> > 
> > Acked-by: Eric Dumazet <edumazet@google.com>
> 
> The first suggestion, with it disabled by default seems to be the most
> flexible tho, i.e, Paul's original message plus the boot parameter line:
> 
> Alternatively, a boot-time option could be used:
> 
> int some_rt_boot_parameter = CONFIG_SYNC_NET_DEFAULT;
> 
>         if (rtnl_is_locked() && !some_rt_boot_parameter)
>                 synchronize_rcu_expedited();
>         else
>                 synchronize_rcu();
> 
> Then RT oriented kernel .config files would have CONFIG_SYNC_NET_DEFAULT
> set to 1, while upstream would have this default to 0.
> 
> RT oriented kernel users could try using this in some scenarios where
> networking is not the critical path.


Well, if synchronize_rcu_expedited() is such a problem on RT, then maybe
a generic solution would make synchronize_rcu_expedited() to fallback
synchronize_rcu() after boot time on RT.

Not sure why networking use of synchronize_rcu_expedited() would be
problematic, and not the others.

scripts/checkpatch.pl has this comment about this :

# Check for expedited grace periods that interrupt non-idle non-nohz
# online CPUs.  These expedited can therefore degrade real-time response
# if used carelessly, and should be avoided where not absolutely
# needed.  It is always OK to use synchronize_rcu_expedited() and
# synchronize_sched_expedited() at boot time (before real-time applications
# start) and in error situations where real-time response is compromised in
# any case.  Note that synchronize_srcu_expedited() does -not- interrupt
# other CPUs, so don't warn on uses of synchronize_srcu_expedited().
# Of course, nothing comes for free, and srcu_read_lock() and
# srcu_read_unlock() do contain full memory barriers in payment for
# synchronize_srcu_expedited() non-interruption properties.
