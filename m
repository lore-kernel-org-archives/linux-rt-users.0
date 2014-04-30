From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.14-rt1
Date: Wed, 30 Apr 2014 17:15:57 +0200
Message-ID: <1398870957.5220.2.camel@marge.simpson.net>
References: <20140411185739.GA6644@linutronix.de>
	 <1397918766.5436.16.camel@marge.simpson.net>
	 <1398411635.11930.45.camel@marge.simpson.net>
	 <1398501491.12941.5.camel@marge.simpson.net>
	 <1398520699.28726.22.camel@marge.simpson.net>
	 <1398661784.30930.33.camel@marge.simpson.net>
	 <1398676186.30930.49.camel@marge.simpson.net>
	 <20140428101805.75032f45@gandalf.local.home>
	 <1398695832.14475.10.camel@marge.simpson.net>
	 <1398748869.5514.81.camel@marge.simpson.net>
	 <20140429201308.63292691@gandalf.local.home>
	 <1398843793.26071.52.camel@marge.simpson.net>
	 <1398863189.26071.97.camel@marge.simpson.net>
	 <20140430091550.1177bc90@gandalf.local.home>
	 <1398866403.26071.125.camel@marge.simpson.net>
	 <20140430101919.70b2f622@gandalf.local.home>
	 <20140430103308.1e46dd18@gandalf.local.home>
	 <1398869686.26071.151.camel@marge.simpson.net>
	 <20140430111100.72a7a71b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140430111100.72a7a71b@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2014-04-30 at 11:11 -0400, Steven Rostedt wrote:

> > Another little bug.  This hunk of patches/stomp-machine-raw-lock.patch
> > should be while (atomic_read(&done.nr_todo)) 
> > 
> > @@ -647,7 +671,7 @@ int stop_machine_from_inactive_cpu(int (
> >         ret = multi_cpu_stop(&msdata);
> > 
> >         /* Busy wait for completion. */
> > -       while (!completion_done(&done.completion))
> > +       while (!atomic_read(&done.nr_todo))
                   ^--- that ! needs to go away 
> 
> I don't see this in the code. That is, there is no "completion_done()"
> in stop_machine_from_inactive_cpu(). It is already an atomic_read().

Yes, but it should read "while (atomic_read(&done.nr_todo))"

-Mike
