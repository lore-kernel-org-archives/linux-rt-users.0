From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert "timers: Don't wake ktimersoftd on every tick"
Date: Fri, 26 May 2017 22:50:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705262232590.2137@nanos>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de> <20170203182112.18053-1-haris.okanovic@ni.com> <20170210170207.3kzfqyfa4ueh7mih@linutronix.de> <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de> <faa23f3e-28c0-6de1-66a6-2b6ab5e99462@ni.com>
 <alpine.DEB.2.20.1705262147510.2137@nanos> <4b4df775-53b8-cdeb-381b-af8cabb364a8@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.cartwright@ni.com, gratian.crisan@ni.com
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b4df775-53b8-cdeb-381b-af8cabb364a8@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 May 2017, Haris Okanovic wrote:

> Oh crap. I think I see the problem. I decrement expired_count before
> processing the list. Dropping the lock permits another run of
> tick_find_expired()->find_expired_timers() in the middle of __expire_timers()
> since it uses expired_count==0 as a condition.
> 
> This should fix it, but I'll wait for Anna-Maria's test next week before
> submitting a patch.
> 
> >  static void expire_timers(struct timer_base *base)
> >  {
> >         struct hlist_head *head;
> > +       int expCount = base->expired_count;

No camel case for heavens sake!

And this requires:

   	 cnt = READ_ONCE(base->expired_count);

> > -       while (base->expired_count--) {
> > -               head = base->expired_lists + base->expired_count;
> > +       while (expCount--) {
> > +               head = base->expired_lists + expCount;
> >                 __expire_timers(base, head);
> >         }

Plus a comment.

> >         base->expired_count = 0;

Anna-Maria spotted the same issue, but I voted for the revert right now
because I was worried about the consistency of base->clk under all
circumstances.

The other thing I noticed was this weird condition which does not do the
look ahead when base->clk is back for some time. Why don't you use the
existing optimization which uses the bitmap for fast forward?

The other issue I have is that this can race at all. If you raised the
softirq in the look ahead then you should not go into that function until
the softirq has actually completed. There is no point in wasting time in
the hrtimer interrupt if the softirq is running anyway.

Thanks,

	tglx
