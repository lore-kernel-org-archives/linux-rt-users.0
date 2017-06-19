From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 13:50:20 +0200
Message-ID: <20170619115019.6zpsoiwubl22mjqs@linutronix.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
 <1497687277.6908.31.camel@gmx.de>
 <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
 <1497867291.19618.52.camel@gmx.de>
 <20170619104459.prmicsbbmljc6smb@linutronix.de>
 <1497871888.19618.90.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497871888.19618.90.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-19 13:31:28 [+0200], Mike Galbraith wrote:
> > > Scratch that "appears", changing it to TASK_NORMAL just fixed my DL980
> > > running otherwise absolutely pristine 4.9-rt21, after having double
> > > verified that rt20 works fine.  Now to go back to 4.11/master/tip-rt,
> > > make sure that the little bugger really really REALLY ain't fscking
> > > with me for the sheer fun of it, futexes being made of pure evil :)
> > 
> > So v4.9-rt20 works fine but -rt21 starts to lose wakeups on DL980 in
> > general or just with "futex_wait -n 4" ?
> 
> -rt20 is verified to work fine, -rt21 starts hanging with futextest.
>  The futex_wait -n 4 testcase was distilled out of seeing the full
> futextest/run.sh hanging.  The only symptom I've _seen_ on the DL980 is
> futextest hanging.  On the desktop, I've seen more, and may still, I'll
> know when I see or don't see desktop gizmos occasionally go comatose.

rt20…rt21 is just
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/sched-Prevent-task-state-corruption-by-spurious-lock.patch?h=linux-4.9.y-rt-patches

Let me verify that here and fire maybe the four socket box. 

> > > My testcase is to run futex_wait -n 4 in a modest sized loop.  Odd
> > > thing is that it only reproduces on the DL980 if I let it use multiple
> > > sockets, pin it to one, and all is peachy, (rather seems to be given)
> > > whereas on desktop box, the hang is far more intermittent, but there.
> > 
> > do I parse it right, as v4.9-rt21 (without the change above) works with
> > the testcase mentioned if you pin it to one socket but does not work if
> > you let it use multiple sockets.
> > And your desktop box hangs no matter what?
> 
> No no, desktop box will reproduce, but not nearly as reliably as the 8
> socket box does, but yes, it seems to work fine on the DL980 when
> pinned to one socket.  I was testing 4.9-rt because hunt was in
> progress when 4.11-rt was born.

Let me try futex-wait test on more boxes then…

> 	-Mike

Sebastian
