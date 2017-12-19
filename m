From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Tue, 19 Dec 2017 16:04:18 +0100
Message-ID: <20171219150418.vz6hkpf4uuangb4q@linutronix.de>
References: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
 <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
 <20171219100202.3017a79f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbdLSPEW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Dec 2017 10:04:22 -0500
Content-Disposition: inline
In-Reply-To: <20171219100202.3017a79f@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-19 10:02:02 [-0500], Steven Rostedt wrote:
> On Tue, 19 Dec 2017 09:27:40 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index c2c344fda487..3971fa0c7194 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -1952,6 +1952,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
> >  	BUG_ON(cpu_online(scpu));
> >  	tick_cancel_sched_timer(scpu);
> >  
> > +	local_bh_disable();
> >  	local_irq_disable();
> >  	old_base = &per_cpu(hrtimer_bases, scpu);
> >  	new_base = this_cpu_ptr(&hrtimer_bases);
> > @@ -1979,6 +1980,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
> >  	/* Check, if we got expired work to do */
> >  	__hrtimer_peek_ahead_timers();
> >  	local_irq_enable();
> > +	local_bh_enable();
> >  	return 0;
> >  }
> 
> The above just seems wrong. local_irq_disable() should imply
> local_bh_disable(), as it doesn't let softirqs run either.

Where does local_irq_disable() imply this?

> -- Steve

Sebastian
