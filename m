From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] hotplug, hrtimer: Migrate expired/deferred timers
 during cpu offline
Date: Thu, 17 Aug 2017 18:50:42 +0200
Message-ID: <20170817165041.3agf2btidfdcspiq@linutronix.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
 <1501913583.7917.42.camel@gmx.de>
 <1501945043.5473.31.camel@gmx.de>
 <20170807073350.nwytftryfp34mrwi@linutronix.de>
 <1502094121.5568.22.camel@gmx.de>
 <1502186459.8042.31.camel@gmx.de>
 <1502438116.16425.18.camel@gmx.de>
 <1502439312.16425.19.camel@gmx.de>
 <1502697588.12319.199.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502697588.12319.199.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-14 09:59:48 [+0200], Mike Galbraith wrote:
> On Fri, 2017-08-11 at 10:15 +0200, Mike Galbraith wrote:
> > On Fri, 2017-08-11 at 09:55 +0200, Mike Galbraith wrote:
> > > The below fixes the list debug explosion up.
> > > 
> > > If we do not migrate expired/deferred timers during cpu offline, ->cb_entry
> > > will be corrupted by online initialization of base->expired, leading to a
> > > loud list debug complaint should someone call __remove_hrtimer() thereafter.
> > > 
> > > Signed-off-by: Mike Galvraith <efault@gmx.de>
> > ahem.....................b
> 
> (actually, I shouldn't have signed, question being why we now leave
> them lying about when we _apparently_ previously did not)

takedown_cpu() invokes early smpboot_park_threads() which parks/ stops
the ksoftirqd. That means each hrtimer that fires after that and is not
marked as irqsafe won't be processed but just enqueued onto the
->expired list. The timer would be processed once the CPU goes back
online. Be not really. The thing is that once the CPU goes back online
the "expired" list head will be initialized and that timer is lost. Once
you try to cancel it, it will remove itself from the expired list and
this is when the list corruption is noticed.
My guess here is that the hotplug rework changed the timing and the bug
is more obvious now: if you cancel the timer before the CPU goes back
online then nothing happens.

> > > ---
> > >  kernel/time/hrtimer.c |   13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > --- a/kernel/time/hrtimer.c
> > > +++ b/kernel/time/hrtimer.c
> > > @@ -1802,6 +1802,19 @@ static void migrate_hrtimer_list(struct
> > >  		 */
> > >  		enqueue_hrtimer(timer, new_base);
> > >  	}
> > > +
> > > +	/*
> > > +	 * Finally, migrate any expired timers deferred by RT.
> > > +	 */
> > > +	while (!list_empty(&old_base->expired)) {
> > > +		struct list_head *entry = old_base->expired.next;
> > > +
> > > +		timer = container_of(entry, struct hrtimer, cb_entry);
> 
> (oops, forgot to change that back too. [scribble scribble])
> 
> > > +		/* XXX: hm, perhaps defer again instead of enqueueing. */
> > > +		__remove_hrtimer(timer, old_base, HRTIMER_STATE_ENQUEUED, 0);
> > > +		timer->base = new_base;
> > > +		enqueue_hrtimer(timer, new_base);

__remove_hrtimer() shouldn't be required because it has been done
already. It should be enough to just list_splice() one list to the
other and raise the softirq afterwards.

> > > +	}
> > >  }
> > >  
> > >  int hrtimers_dead_cpu(unsigned int scpu)

Sebastian
