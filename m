From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on PREEMPT_RT
Date: Wed, 16 Jan 2019 11:07:51 +0100
Message-ID: <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
References: <20190115123910.2b18df54@gandalf.local.home>
 <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
 <20190115145815.13713791@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115145815.13713791@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue 2019-01-15 14:58:15, Steven Rostedt wrote:
> On Tue, 15 Jan 2019 19:54:33 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2019-01-15 12:39:10 [-0500], Steven Rostedt wrote:
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -1742,6 +1742,13 @@ static int console_trylock_spinning(void)
> > >  	if (console_trylock())
> > >  		return 1;
> > >  
> > > +	/*
> > > +	 * The consoles are preemptable in PREEMPT_RT, which can cause
> > > +	 * spinning to deadlock.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> > > +		return 0;
> > > +
> > >  	printk_safe_enter_irqsave(flags);
> > >  
> > >  	raw_spin_lock(&console_owner_lock);  
> > 
> > So my ("printk: Make rt aware") patch does:
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 6553508ff3889..d983c509f74a2 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1617,6 +1617,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
> >         return do_syslog(type, buf, len, SYSLOG_FROM_READER);
> >  }
> >  
> > +#ifndef CONFIG_PREEMPT_RT_FULL
> >  /*
> >   * Special console_lock variants that help to reduce the risk of soft-lockups.
> >   * They allow to pass console_lock to another printk() call using a busy wait.
> > @@ -1757,6 +1758,15 @@ static int console_trylock_spinning(void)
> >         return 1;
> >  }
> >  
> > +#else
> > +
> > +static int console_trylock_spinning(void)
> > +{
> > +       return console_trylock();
> > +}
> > +
> > +#endif
> > +
> >  /*
> >   * Call the console drivers, asking them to write out
> >   * log_buf[start] to log_buf[end - 1].
> > 
> > 
> > So it never gets into the codepath where you try to avoid spinning.
> > Right?
> >
> 
> You right! Which appears to be missing from my 4.14, and I thought I
> looked for that in 4.19-rt too, but I guess I was still looking at
> 4.14 :-/. OK, ignore. Sorry for the noise.
> 
> Well, it wasn't a total waste. I now know what to backport to 4.14-rt
> ;-)

The patch makes perfect sense. But it is not ready for upstream
because CONFIG_PREEMPT_RT_FULL is not there yet. Do I get it
correctly, please?

Best Regards,
Petr
