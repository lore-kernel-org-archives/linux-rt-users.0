From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Tue, 27 Oct 2015 12:02:51 -0300
Message-ID: <20151027150251.GH9405@kernel.org>
References: <1445886895-3692-1-git-send-email-joshc@ni.com>
 <20151027004422.GH5105@linux.vnet.ibm.com>
 <20151027123153.GG8245@jcartwri.amer.corp.natinst.com>
 <1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Cartwright <joshc@ni.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Clark Williams <williams@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Tue, Oct 27, 2015 at 07:18:01AM -0700, Eric Dumazet escreveu:
> On Tue, 2015-10-27 at 07:31 -0500, Josh Cartwright wrote:
> 
> > Okay, yes, I like the first suggestion better as well, I've included a
> > patch below that does just that.  I hope you don't mind me turning it
> > into a Suggested-by :).
> > 
> > Thanks for taking a look!
> >   Josh
> 
> 
> > @@ -6969,7 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
> >  void synchronize_net(void)
> >  {
> >  	might_sleep();
> > -	if (rtnl_is_locked())
> > +	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> >  		synchronize_rcu_expedited();
> >  	else
> >  		synchronize_rcu();
> 
> No objection from me. Thanks.
> 
> Acked-by: Eric Dumazet <edumazet@google.com>

The first suggestion, with it disabled by default seems to be the most
flexible tho, i.e, Paul's original message plus the boot parameter line:

Alternatively, a boot-time option could be used:

int some_rt_boot_parameter = CONFIG_SYNC_NET_DEFAULT;

        if (rtnl_is_locked() && !some_rt_boot_parameter)
                synchronize_rcu_expedited();
        else
                synchronize_rcu();

Then RT oriented kernel .config files would have CONFIG_SYNC_NET_DEFAULT
set to 1, while upstream would have this default to 0.

RT oriented kernel users could try using this in some scenarios where
networking is not the critical path.

- Arnaldo
