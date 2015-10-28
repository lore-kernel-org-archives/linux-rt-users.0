From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Wed, 28 Oct 2015 03:34:00 -0500
Message-ID: <20151028083400.GI8245@jcartwri.amer.corp.natinst.com>
References: <1445886895-3692-1-git-send-email-joshc@ni.com>
 <20151027004422.GH5105@linux.vnet.ibm.com>
 <20151027123153.GG8245@jcartwri.amer.corp.natinst.com>
 <1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
 <20151027150251.GH9405@kernel.org>
 <1445959673.7476.48.camel@edumazet-glaptop2.roam.corp.google.com>
 <20151027231559.GA4814@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Clark Williams <williams@redhat.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151027231559.GA4814@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 27, 2015 at 04:15:59PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 27, 2015 at 08:27:53AM -0700, Eric Dumazet wrote:
> > On Tue, 2015-10-27 at 12:02 -0300, Arnaldo Carvalho de Melo wrote:
[..]
> > > The first suggestion, with it disabled by default seems to be the most
> > > flexible tho, i.e, Paul's original message plus the boot parameter line:
> > > 
> > > Alternatively, a boot-time option could be used:
> > > 
> > > int some_rt_boot_parameter = CONFIG_SYNC_NET_DEFAULT;
> > > 
> > >         if (rtnl_is_locked() && !some_rt_boot_parameter)
> > >                 synchronize_rcu_expedited();
> > >         else
> > >                 synchronize_rcu();
> 
> This could be OK, but why not start with something very simple and automatic?
> We can always add more knobs when and if they actually prove necessary.

I suppose the question is if, for acme's usecases the answer to "when
it's proven necessary" is "now".

> In contrast, unnecessary knobs can cause confusion and might at the same time
> get locked into some misbegotten userspace application, which would make the
> unnecessary knob really hard to get rid of.

I think I would make a stronger statement; the CONFIG_SYNC_NET_DEFAULT
proposed option would be a boot/compile time parameter which says "I
require networking (and network configuration) in my critical path", why
don't we have these flags for other I/O subsystems?  What's special
about networking?

We don't because applications can make use of thread priorities to
express exactly which tasks should be more important than others.  So
perhaps the failure here is that RCU (and networking, by implication)
doesn't (can't?) take into consideration the calling thread's priority?
(And, there may be a cascade of other problems as well, like deferred
work pushed to a waitqueue, and thus losing the callers priority, etc)

(I will admit that RCU is a black box to me, so it is entirely possible
it's already capable of this, or it's fundamentally impossible, or
somewhere in between :)

> > > Then RT oriented kernel .config files would have CONFIG_SYNC_NET_DEFAULT
> > > set to 1, while upstream would have this default to 0.
> > > 
> > > RT oriented kernel users could try using this in some scenarios where
> > > networking is not the critical path.
> > 
> > Well, if synchronize_rcu_expedited() is such a problem on RT, then maybe
> > a generic solution would make synchronize_rcu_expedited() to fallback
> > synchronize_rcu() after boot time on RT.
> > 
> > Not sure why networking use of synchronize_rcu_expedited() would be
> > problematic, and not the others.
> 
> From what I can see, their testing just happened to run into this one.
> Perhaps further testing will run into others, or perhaps the others are
> off in code paths that should not be exercised while running RT apps.

I accidentally ran into this issue when I was doing testing with an
ethernet cable w/ a broken RJ-45 connector (without the tab, that I was
just too lazy to replace), and I kept accidentally knocking it out.  :)

Regardless, industrial automation environments aren't known for having
the most stable network environments; there may be deployed systems
doing high priority motion control tasks, we'd want to ensure that the
poor network technician sent in to repair a defective network switch
wouldn't end up being mangled.

> > scripts/checkpatch.pl has this comment about this :

Also, Documentation/RCU/checklist.txt mentions:

	Use of the expedited primitives should be restricted to rare
	configuration-change operations that would not normally be
	undertaken while a real-time..

I think it could have been argued at the time, that operations under
rtnl_lock() were "configuration-change" operations.  However, for our
use cases, it's not, as link changes are external events beyond control.

Thanks again,
  Josh
