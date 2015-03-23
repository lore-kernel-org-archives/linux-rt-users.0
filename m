From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Mon, 23 Mar 2015 05:42:54 +0100
Message-ID: <1427085774.3151.7.camel@gmail.com>
References: <20150317163541.080310081@goodmis.org>
	 <20150317163617.218582800@goodmis.org>
	 <20150317163551.3093b6c2@gandalf.local.home>
	 <1426753029.4168.80.camel@gmail.com>
	 <20150319122611.0d002d48@gandalf.local.home> <550AFC6A.4050901@hp.com>
	 <1426960943.4677.34.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426960943.4677.34.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2015-03-21 at 19:02 +0100, Mike Galbraith wrote:
> On Thu, 2015-03-19 at 10:42 -0600, Thavatchai Makphaibulchoke wrote:
> > On 03/19/2015 10:26 AM, Steven Rostedt wrote:
> > > On Thu, 19 Mar 2015 09:17:09 +0100
> > > Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> > > 
> > > 
> > >> (aw crap, let's go shopping)... so why is the one in timer.c ok?
> > > 
> > > It's not. Sebastian, you said there were no other cases of rt_mutexes
> > > being taken in hard irq context. Looks like timer.c has one.
> > > 
> > > So perhaps the real fix is to get that special case of ownership in
> > > hard interrupt context?
> > > 
> > > -- Steve
> > > 
> > 
> > Steve, I'm still working on the fix we discussed using dummy irq_task.
> > I should be able to submit some time next week, if still interested.
> > 
> > Either that, or I think we should remove the function
> > spin_do_trylock_in_interrupt() to prevent any possibility of running
> > into similar problems in the future.
> 
> Why can't we just Let swapper be the owner when in irq with no dummy?
> 
> I have "don't raise timer unconditionally" re-applied, the check for a
> running callback bits of my nohz_full fixlet, and the below on top of
> that, and all _seems_ well.

But not so well on 64 core box.  That has nothing to do with hacklet
though, re-applying timers-do-not-raise-softirq-unconditionally.patch
without thta hangs the 64 core box during boot with no help from me
other than to patchlet to let nohz work at all, seems there's another
issue lurking there.  Hohum.  Without 'don't raise..", big box is fine.

	-Mike
