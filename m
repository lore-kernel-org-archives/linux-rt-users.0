From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
Date: Fri, 2 May 2014 21:01:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1405022100351.6261@ionos.tec.linutronix.de>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org> <534DADF1.6060608@meduna.org> <20140422115439.GA20669@linutronix.de> <20140422094657.5b6ca1e2@gandalf.local.home> <53569E05.8010600@linutronix.de> <20140422134802.73fc1fa4@gandalf.local.home>
 <20140422141650.7f43d5ba@gandalf.local.home> <20140502183824.GH9178@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140502183824.GH9178@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2 May 2014, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2014-04-22 14:16:50 [-0400]:
> > /*
> >  * Called by the local, per-CPU timer interrupt on SMP.
> >  */
> >@@ -1467,7 +1473,7 @@ void run_local_timers(void)
> > 		return;
> > 	}
> > 
> >-	if (!spin_do_trylock(&base->lock)) {
> >+	if (timer_should_raise_softirq(&base->lock)) {
> > 		raise_softirq(TIMER_SOFTIRQ);
> > 		return;
> > 	}
> 
> Okay. So Peter said that it is okay to apply this since FULL_NO_HZ users
> wouldn't complain on UP. I still wouldn't say it is broken but that is a
> different story.
> We have two users of this trylock. run_local_timers() which pops up
> quite often (and you patched here) and the other is
> get_next_timer_interrupt(). What do you suggest we do here? It is
> basically the same thing.

It's different as it CANNOT fail on UP. That's called from the idle
code and there is no way that anything holds that lock on UP when idle
runs.

Thanks,

	tglx
