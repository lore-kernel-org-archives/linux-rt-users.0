From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert "timers: Don't wake ktimersoftd on every tick"
Date: Sun, 4 Jun 2017 16:17:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706041558150.2813@nanos>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de> <20170203182112.18053-1-haris.okanovic@ni.com> <20170210170207.3kzfqyfa4ueh7mih@linutronix.de> <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de> <faa23f3e-28c0-6de1-66a6-2b6ab5e99462@ni.com>
 <alpine.DEB.2.20.1705262147510.2137@nanos> <4b4df775-53b8-cdeb-381b-af8cabb364a8@ni.com> <alpine.DEB.2.20.1705262232590.2137@nanos> <b1486490-5a96-7ba3-c280-5d5622c8c488@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.cartwright@ni.com, gratian.crisan@ni.com
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdFDOSA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Jun 2017 10:18:00 -0400
In-Reply-To: <b1486490-5a96-7ba3-c280-5d5622c8c488@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2 Jun 2017, Haris Okanovic wrote:
> On 05/26/2017 03:50 PM, Thomas Gleixner wrote:
> > > >  static void expire_timers(struct timer_base *base)
> > > >  {
> > > >         struct hlist_head *head;
> > > > +       int expCount = base->expired_count;
> > 
> > No camel case for heavens sake!
> > 
> > And this requires:
> > 
> >    	 cnt = READ_ONCE(base->expired_count);
> > 
> > > > -       while (base->expired_count--) {
> > > > -               head = base->expired_lists + base->expired_count;
> > > > +       while (expCount--) {
> > > > +               head = base->expired_lists + expCount;
> > > >                 __expire_timers(base, head);
> > > >         }
> > 
> > Plus a comment.
> 
> Fixed, thanks.
> 
> Are your recommending READ_ONCE() purely for documentation purposes?

Yes.

> > The other thing I noticed was this weird condition which does not do the
> > look ahead when base->clk is back for some time.
> 
> The soft interrupt fires unconditionally if base->clk hasn't advanced in some
> time to limit how long cpu spends in hard interrupt context.

That makes no sense.

> > Why don't you use the
> > existing optimization which uses the bitmap for fast forward?
> > 
> 
> Are you referring to forward_timer_base()/base->next_expiry? I think it's only
> updated in the nohz case. Can you share function name/line number(s) if you're
> thinking of something else.

I think just using collect_expired_timers() should be enough. In the !NOHZ
case the base shouldn't be that far back, right?

> > The other issue I have is that this can race at all. If you raised the
> > softirq in the look ahead then you should not go into that function until
> > the softirq has actually completed. There is no point in wasting time in
> > the hrtimer interrupt if the softirq is running anyway.
> > 
> 
> Makes sense. Skipping the large `if` block in run_local_timers() when
> `local_softirq_pending() & TIMER_SOFTIRQ`.

No. You need your own state tracking. The TIMER_SOFTIRQ bit is cleared when
the softirq is invoked, but that does not mean that it finished running.

run_local_timers()
{
	lock(base->lock);
	if (!base->softirq_activated)
		if (base_has_timers_to_expire()) {
			base->softirq_activated = true;
			raise_softirq(TIMER_SOFTIRQ);
		}
	}
	unlock(base->lock);
}

timer_softirq()
{
	lock(base->lock);
	expire_timers();
	base->softirq_activated = false;
	unlock(base->lock);
}

That way you avoid any operation in the tick interrupt as long as the soft
interrupt processing has not completed.

Thanks,

	tglx
