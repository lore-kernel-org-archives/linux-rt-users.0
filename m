From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.5-rt6
Date: Tue, 17 Dec 2013 15:26:16 +0100
Message-ID: <1387290376.2399.11.camel@marge.simpson.net>
References: <20131216091431.GA13796@linutronix.de>
	 <1387264591.5340.23.camel@marge.simpson.net>
	 <20131217063156.6ac3bfed@gandalf.local.home>
	 <20131217124248.GA21694@linutronix.de>
	 <20131217091624.65be757c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131217091624.65be757c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-12-17 at 09:16 -0500, Steven Rostedt wrote: 
> 
> > @@ -1129,11 +1127,8 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
> >  		 * is actually now running somewhere else!
> >  		 */
> >  		while (task_running(rq, p)) {
> > -			if (match_state) {
> > -				if (!unlikely(check_task_state(p, match_state)))
> > -					return 0;
> > +			if (match_state && !check_task_state(p, match_state))
> 
> Ah, it was that "!unlikely(" that caused me to miss the '!'. That
> should have been: likely(!check_task_state()). But anyway, I rather
> just keep what you wrote and drop the unlikely altogether.

Maybe better would be to put the thing back inline, with a brief
reference to the race.

-Mike
