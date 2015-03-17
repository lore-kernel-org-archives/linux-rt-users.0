From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Tue, 17 Mar 2015 05:45:22 +0100
Message-ID: <1426567522.12107.8.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>
	 <20150316202409.GF28130@linutronix.de> <1426557233.20938.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426557233.20938.8.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-03-17 at 02:53 +0100, Mike Galbraith wrote:
> On Mon, 2015-03-16 at 21:24 +0100, Sebastian Andrzej Siewior wrote:

> > What you do is that you accept the fact that the timer-softirq is
> > scheduled for no reason and then you try to disable the tick from within
> > the timer-softirq. I assumed that it would work get the "expired timer"
> > somehow.
> 
> Yup, it works around that otherwise crippling wakeup.  If I re-apply..
> 
>      timers-do-not-raise-softirq-unconditionally.patch
> 
> ..the workaround is not needed of course, but the livelock fix still is.
> I haven't yet tested that in 3.18-rt though, only 4.0-rt, but I presume
> it'll be the same deal there when I do.

Did that, and it is.  Fire up tbench 4 + make -j4 on my i7-4790+smt box
booted nohz_full=2,3,6,7, death spiral begins shortly thereafter.

	-Mike
