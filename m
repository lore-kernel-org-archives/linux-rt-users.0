From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: sleeping function called from invalid context on
 3.10.10-rt7
Date: Wed, 11 Sep 2013 15:19:10 -0400
Message-ID: <20130911151910.3f415c3b@gandalf.local.home>
References: <20130911102809.GA31663@uudg.org>
	<20130911092623.42efd930@gandalf.local.home>
	<5230895B.5070400@hurleysoftware.com>
	<5230B673.6090800@tuebingen.mpg.de>
	<20130911143557.14c1fe6a@gandalf.local.home>
	<5230BF5E.9000207@tuebingen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Hurley <peter@hurleysoftware.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Mario Kleiner <mario.kleiner@tuebingen.mpg.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5230BF5E.9000207@tuebingen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Sep 2013 21:07:10 +0200
Mario Kleiner <mario.kleiner@tuebingen.mpg.de> wrote:

> 
> 
> On 11.09.13 20:35, Steven Rostedt wrote:
> > On Wed, 11 Sep 2013 20:29:07 +0200
> > Mario Kleiner <mario.kleiner@tuebingen.mpg.de> wrote:
> >
> >> That said, maybe preempt_disable is no longer the optimal choice there
> >> and there's some better way to achieve good protection against
> >> interruptions of that bit of code? My knowledge here is a bit rusty, and
> >> the intel kms drivers and rt stuff has changed quite a bit.
> >
> > If you set your code to a higher priority than other tasks (and
> > interrupts) than it wont be preempted there. Unless of course it blocks
> > on a lock, but even then, priority inheritance will take place and it
> > still should be rather quick. (unless the holder of the lock is doing
> > that strange polling).
> >
> > -- Steve
> >
> 
> Right, on a rt kernel. But that creates the problem of not very computer 
> savvy users (psychologists and biologists mostly) somehow having to 
> choose proper priorities for gpu interrupt threads and for the 
> x-server/wayland/..., and not much protection on a non-rt kernel?

IIUC, the preempt_disable() is only for -rt, the non-rt case already
disables preemption with the spin_locks called before it.

> 
> preempt_disable() a few years ago looked like a good "plug and play" 
> default solution, because the ->get_crtc_scanoutpos() function was 
> supposed to have a very low and bounded execution time. At the time we 
> wrote the patches for intel/radeon/nouveau, that was the case. Typical 
> execution time (= preempt off time) was like 1-4 usecs, even on very low 
> end hardware.
> 
> Seems that at least intel's kms driver does a lot of things now, which 
> can sleep and spin inside that section? I tried to follow the posted 
> stack trace, but got lost somewhere around the i915_read32 code and 
> power management stuff...

Note, the sleeps only happen on -rt, and not in mainline.

If one is going to use -rt for real-time work, it requires a bit more
knowledge of the system. The problem with RT in general, is that it's
hard, and anyone telling you they have a generic RT system that
requires no computer savvyness can also be selling you a bridge over
the east river.

-- Steve
