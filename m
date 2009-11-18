From: Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>
Subject: Re: [PATCH] cleanup sched_yield (sys)call nesting.
Date: Wed, 18 Nov 2009 13:04:50 -0800
Message-ID: <1258578290.12429.108.camel@sven.thebigcorporation.com>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	 <20091107210147.3e754278@hyperion.delvare>
	 <4AF7148C.9090706@thebigcorporation.com>
	 <20091112211255.09cd884a@hyperion.delvare>
	 <alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
	 <20091116155606.GC29479@sirena.org.uk>
	 <c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
	 <20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
	 <c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
	 <20091118175202.490989d8@hyperion.delvare>
	 <1258577194.12429.86.camel@sven.thebigcorporation.com>
	 <alpine.LFD.2.00.0911182153010.24119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.0911182153010.24119-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2009-11-18 at 21:56 +0100, Thomas Gleixner wrote:
> On Wed, 18 Nov 2009, Sven-Thorsten Dietrich wrote:
> > On Wed, 2009-11-18 at 17:52 +0100, Jean Delvare wrote:
> > > On Wed, 18 Nov 2009 17:28:53 +0100, Leon Woestenberg wrote:
> > > > On Wed, Nov 18, 2009 at 2:05 AM, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
> > > > > Our timers are very efficient and some day we will need to make jiffies a
> > > > > function and stop the timer ticking for best performance. At that point
> > > > > timers are probably the most efficient way to do much of this.
> > > >
> > > > The problem with I2C bitbanged is the stringent timing, we need a way
> > > > to have fine-grained sleeping
> > > > mixed with real-time tasks in order to make this work.
> > > 
> > > FWIW, the problem that was initially reported has nothing to do with
> > > this. i2c-algo-bit used mdelay() during transactions, not yield().
> > > yield() is used only in once place, _between_ transactions attempts.
> > > There are no strict timing constraints there.
> > > 
> > 
> > I agree that dropping out sched_yield entirely should maybe start by
> > deprecating / flagging as a warning in sched_rt.c.
> 
> Errm, that's unrelated to sched_rt.c. 
> 
> yield() in the kernel in general is needs to be deprecated.
>  
> > This is just a minimal cleanup I stumbled across while looking at it -
> > to get away from the uglyness of calling into the syscall interface from
> > inside the Kernel.
> 
> And why exactly is that ugly ?

Calling from a function returning void into a non-void function and then
ignoring the return code ?
