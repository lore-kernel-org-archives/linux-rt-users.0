From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Mon, 14 Sep 2015 11:50:08 +0200
Message-ID: <20150914095008.GA31704@gmail.com>
References: <20150904011900.730816481@goodmis.org>
 <alpine.DEB.2.11.1509051217330.15006@nanos>
 <20150905120457.GA21338@gmail.com>
 <alpine.DEB.2.11.1509070959440.15006@nanos>
 <20150908073116.GA6565@gmail.com>
 <alpine.DEB.2.11.1509080959460.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509080959460.15006@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > And if we are into getting reference counts, why not solve it at a higher 
> > level and get a reference count to 'x' to make sure it's safe to use? Then we 
> > could do:
> >
> >         lock(y->lock);
> > retry:
> >         x = y->x;
> >         if (!trylock(x->lock)) {
> >                 get_ref(x->count)
> >                 unlock(y->lock);
> >                 lock(x->lock);
> >                 lock(y->lock);
> >                 put_ref(x->count);
> >                 if (y->x != x) { /* Retry if 'x' got dropped meanwhile */
> >                         unlock(x->lock);
> >                         goto retry;
> >                 }
> >          }
> > 
> > Or so.
> 
> In the case of dcache::dentry_kill() we probably do not have to take refcounts 
> and it might be actually counterproductive to do so. y->x, i.e. dentry->parent, 
> cannot vanish under us, if I understand the life time rules correctly.

Ok, that's even better.

> Aside of that, yes, I was thinking about a similar scheme for that. I need some 
> more time to grok all the rules there :)

Ok, great! :-)

I really don't think we need a new locking primitive - and with something like the 
above we could improve the code upstream as well and make it scale better in some 
scenarios, right?

Thanks,

	Ingo
