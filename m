From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.0.14-rt31 - ksoftirq running wild - FEC ethernet
 driver to blame? Yep
Date: Wed, 18 Jan 2012 10:37:37 -0500
Message-ID: <1326901057.17534.77.camel@gandalf.stny.rr.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
	 <201201171527.19165.tstone@iss.tu-darmstadt.de>
	 <1326822011.7386.40.camel@marge.simson.net>
	 <201201181211.45011.tim.sander@hbm.com>
	 <1326894866.12502.17.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>,
	Tim Sander <tstone@iss.tu-darmstadt.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326894866.12502.17.camel@marge.simson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2012-01-18 at 14:54 +0100, Mike Galbraith wrote:
> On Wed, 2012-01-18 at 12:11 +0100, Tim Sander wrote:
> 
> > > If that's it, you can apply the below, do the same edit, and see which
> > > thread is grinding away.  From there, I'd set a trap.  Let sirq threads
> > > detect that they are being awakened too fast (hey, I can't go to sleep,
> > > the sirq I just processed is busy again, N times in a row) and leave a
> > > note for wakeup_softirqd().  There, WARN_ON(ksoftirqd)[i].help_me) or
> > > such, to see who is flogging which softirq mercilessly.
> > I didn't use this tricks, since top was already doing its job good enough :-).
> 
> Ok, you now know which softirq is being flogged, maybe that's enough for
> someone who knows network goop, dunno.  If you set the trap, you'll get
> an 8x10 color glossy of the slave driver, whip in hand ;-)

This could be another trylock spin loop. I'll have to have a deeper
look.

Thanks,

-- Steve
