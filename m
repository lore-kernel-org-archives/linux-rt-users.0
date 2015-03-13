From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [rfc patch] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Thu, 12 Mar 2015 23:03:29 -0400
Message-ID: <20150312230329.6eb5fa98@gandalf.local.home>
References: <20150216111822.GA21649@linutronix.de>
	<1424258514.3819.39.camel@gmail.com>
	<20150309134535.GA13768@linutronix.de>
	<1425911771.30469.8.camel@gmail.com>
	<1425980136.3507.17.camel@gmail.com>
	<1426153093.4190.2.camel@gmail.com>
	<20150312110911.1a93c8e8@gandalf.local.home>
	<1426212795.3328.21.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426212795.3328.21.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 13 Mar 2015 03:13:15 +0100
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> > > +	int softirqd = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> > > +
> > > +	softirqd &= current == this_cpu_ksoftirqd();
> > 
> > Ug, binary and logical ANDs should not be combined. Just looks nasty.
> > What about:
> > 
> > 	softirqd = !!(IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
> > 			current == this_cpu_ksoftirqd());
> 
> My way looks prettier to me, but I seem to be the only who thinks so
> (this is not the first time it got a gripe), so I'll change it ;-)

I shouldn't have said it looks nasty. It actually does look pretty, in
an artistic kind of way. It's just not very comprehensible.

-- Steve
