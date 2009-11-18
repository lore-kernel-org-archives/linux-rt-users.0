From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cleanup sched_yield (sys)call nesting.
Date: Wed, 18 Nov 2009 22:34:38 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911182233510.24119@localhost.localdomain>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>  <20091107210147.3e754278@hyperion.delvare>  <4AF7148C.9090706@thebigcorporation.com>  <20091112211255.09cd884a@hyperion.delvare>  <alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
  <20091116155606.GC29479@sirena.org.uk>  <c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>  <20091118010520.4cd397d4@lxorguk.ukuu.org.uk>  <c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>  <20091118175202.490989d8@hyperion.delvare>
  <1258577194.12429.86.camel@sven.thebigcorporation.com>  <alpine.LFD.2.00.0911182153010.24119@localhost.localdomain> <1258578290.12429.108.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jean Delvare <khali@linux-fr.org>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-i2c@vger.kernel.org,
	rt-users <linux-rt-users@vger.kernel.org>,
	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932230AbZKRVfA@vger.kernel.org>
In-Reply-To: <1258578290.12429.108.camel@sven.thebigcorporation.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 18 Nov 2009, Sven-Thorsten Dietrich wrote:

> On Wed, 2009-11-18 at 21:56 +0100, Thomas Gleixner wrote:
> > On Wed, 18 Nov 2009, Sven-Thorsten Dietrich wrote:
> > > On Wed, 2009-11-18 at 17:52 +0100, Jean Delvare wrote:
> > > > On Wed, 18 Nov 2009 17:28:53 +0100, Leon Woestenberg wrote:
> > > > > On Wed, Nov 18, 2009 at 2:05 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > > > Our timers are very efficient and some day we will need to make jiffies a
> > > > > > function and stop the timer ticking for best performance. At that point
> > > > > > timers are probably the most efficient way to do much of this.
> > > > >
> > > > > The problem with I2C bitbanged is the stringent timing, we need a way
> > > > > to have fine-grained sleeping
> > > > > mixed with real-time tasks in order to make this work.
> > > > 
> > > > FWIW, the problem that was initially reported has nothing to do with
> > > > this. i2c-algo-bit used mdelay() during transactions, not yield().
> > > > yield() is used only in once place, _between_ transactions attempts.
> > > > There are no strict timing constraints there.
> > > > 
> > > 
> > > I agree that dropping out sched_yield entirely should maybe start by
> > > deprecating / flagging as a warning in sched_rt.c.
> > 
> > Errm, that's unrelated to sched_rt.c. 
> > 
> > yield() in the kernel in general is needs to be deprecated.
> >  
> > > This is just a minimal cleanup I stumbled across while looking at it -
> > > to get away from the uglyness of calling into the syscall interface from
> > > inside the Kernel.
> > 
> > And why exactly is that ugly ?
> 
> Calling from a function returning void into a non-void function and then
> ignoring the return code ?
 
Care to read what I wrote further down ?

>> Which is completely irrelevant because the return code is always 0. 

Thanks,

	tglx
