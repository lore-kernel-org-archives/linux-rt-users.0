From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86: enable preemption in delay
Date: Sat, 31 May 2008 09:18:18 +0200
Message-ID: <20080531071817.GB5405@ucw.cz>
References: <Pine.LNX.4.58.0805242306280.3977@gandalf.stny.rr.com> <alpine.LFD.1.10.0805251406260.3295@apollo.tec.linutronix.de> <20080525180122.GA4247@ucw.cz> <Pine.LNX.4.58.0805280855250.25179@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4374 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752035AbYFAORF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Jun 2008 10:17:05 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0805280855250.25179@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed 2008-05-28 09:01:06, Steven Rostedt wrote:
> 
> 
> On Sun, 25 May 2008, Pavel Machek wrote:
> > > +		if (unlikely(cpu != smp_processor_id())) {
> > > +			if (loops <= TSC_MIGRATE_COUNT)
> > > +				break;
> > > +			cpu = smp_processor_id();
> > > +			rdtscl(bclock);
> > > +			loops -= TSC_MIGRATE_COUNT;
> > > +		} else {
> > > +			rdtscl(now);
> > > +			if ((now - bclock) >= loops)
> > > +				break;
> > > +			loops -= (now - bclock);
> > > +			bclock = now;
> >
> > What happens with different cpus running on different frequencies...?
> > Cpufreq?
> 
> It's not even protected with the old code.

Maybe, but it is simple to fix as long as preemption is disabled. When
you enable it, it becomes much harder.

Lets get that fixed.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
