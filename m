From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 09:16:55 -0400
Message-ID: <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
	 <20070923173432.GA10542@linux.vnet.ibm.com>
	 <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
	 <20070925193454.GH8432@linux.vnet.ibm.com>
	 <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
	 <20070926012447.7ffdd45a@lappy>
	 <20070926011139.GW8432@linux.vnet.ibm.com>
	 <20070926102833.17f7c025@twins>
	 <20070926130326.GC19496@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.229]:46153 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbXIZNQ6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 09:16:58 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1098342hue
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 06:16:56 -0700 (PDT)
In-Reply-To: <20070926130326.GC19496@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Paul,

On 9/26/07, Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Sep 26, 2007 at 10:28:33AM +0200, Peter Zijlstra wrote:
> > On Tue, 25 Sep 2007 18:11:39 -0700 "Paul E. McKenney"
> > <paulmck@linux.vnet.ibm.com> wrote:
> >
> > > On Wed, Sep 26, 2007 at 01:24:47AM +0200, Peter Zijlstra wrote:
> > > > On Tue, 25 Sep 2007 16:02:45 -0400 (EDT) Steven Rostedt
> > > > <rostedt@goodmis.org> wrote:
> > > >
> > > > > > This would of course require that synchronize_all_irqs() be in the
> > > > > > RCU code rather than the irq code so that it could access the static
> > > > > > wakeme_after_rcu() definition and the rcu_synchronize structure.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > I do like this better. Anyone else care to comment?
> > > >
> > > > I'm still wondering why the IRQ users cannot user proper RCU as it
> > > > stands:
> > >
> > > Well, that was my initial proposal.  ;-)
> >
> > handler:
> > > >   rcu_read_lock();
> > > >   foo = rcu_dereference(bar);
> > > >   if (foo)
> > > >     foo();
> > > >   rcu_read_unlock();
> > >
> >
> > control routine (!handler)
> > > > vs
> > > >
> > > >   rcu_assign(foo, NULL);
> > > >   synchronize_rcu();
>
> Ah, OK -- yes, that was what I originally proposed -- that individual
> handlers using RCU place the rcu_read_lock() and rcu_read_unlock() as
> needed.
>
> > > > The implicit rcu_read_lock() as placed in handle_IRQ_event() seems
> > > > misplaced.
> > >
> > > OK -- where would you put them instead?  I have them covering the
> > > call to the handler, so what am I missing here?
> >
> > in do_hardirq() (-rt) that is specific to threaded interrupts.
>
> My concern there is that some of the functions called from do_hardirq()
> can loop processing multiple interrupts.  An interrupt storm, otherwise
> harmless in -rt, could cause a very long RCU read-side critical section
> if it happened within thread_edge_irq().
>
> > That said, I'm wondering if we need this whole extra sync_all_irqs()
> > thing. I'm just not getting why IRQ handlers should be an implicit RCU
> > safe context.
>
> Because they are in non-rt -- synchronize_sched() is guaranteed to
> wait for all interrupt handlers.  In contrast, in -rt, synchronize_sched()
> only waits for hardirq.  So Dmitry Torokhov asked for a primitive
> that would wait for all irq handlers, whether threaded or not.
>

That is correct. IIRC synchronize_sched() was introduced to show that
it is not related (other than implementation-wise) to RCU mechanisms.

> But given that he has not responded to this thread, perhaps he
> found that synchronize_irq() worked for him.
>

Sorry, I am just being slow.

No, I don't think synchronize_irq() will work for me. While in i8042 I
know there are 2 possible IRQs (so I'd need 2 calls to
synchronize_irq()) other drivers may not know what IRQ triggered their
handler (or whether it was an IRQ at all).

Actually, I need clarifucation on what you mean by "interrupt
handlers" in sync_all_irqs(). Right now (if I understand it correctly)
synchronize_sched() in mainline will wait for completion of all
IRQ-like contexts. By IRQ-like context I mean code guardede by
spinlock + IRQ off. Serio (input) drivers have their "interrupt"
routines run in that IRQ-like context. They may be invoked as a result
of real IRQ being raised but they also be invoked as a result of
userspace action of some sort. It all depends on implementation of
underlying serio port. So if sync_all_irqs() only waits for real IRQ
handlers to complete it is not sufficient in my case...

Thanks.

-- 
Dmitry
