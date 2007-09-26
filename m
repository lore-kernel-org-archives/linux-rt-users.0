From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 14:42:19 -0700
Message-ID: <20070926214219.GC10544@linux.vnet.ibm.com>
References: <20070926011139.GW8432@linux.vnet.ibm.com> <20070926102833.17f7c025@twins> <20070926130326.GC19496@linux.vnet.ibm.com> <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com> <20070926155656.GA9101@linux.vnet.ibm.com> <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com> <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com> <20070926195513.GA10544@linux.vnet.ibm.com> <1190840086.18147.38.camel@lappy> <Pine.LNX.4.58.0709261701460.6405@gandalf.stny.rr.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36400 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbXIZVm1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 17:42:27 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8QLgLQB016173
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 17:42:21 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8QLgLMZ564078
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 17:42:21 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8QLgJwt026102
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 17:42:20 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0709261701460.6405@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 26, 2007 at 05:07:33PM -0400, Steven Rostedt wrote:
> 
> --
> On Wed, 26 Sep 2007, Peter Zijlstra wrote:
> >
> > On Wed, 2007-09-26 at 12:55 -0700, Paul E. McKenney wrote:
> >
> > > Well, we could make spin_lock_irqsave() invoke rcu_read_lock() and
> > > spin_lock_irqrestore() invoke rcu_read_unlock(), with similar adjustments
> > > to the other primitives in this group.  Then RCU priority boosting would
> > > kick in if configured.
> >
> > Might be me, but 'hiding' the RCU scope like that makes my skin crawl.
> > What is wrong with using rcu_read_lock() explicitly where you depend on
> > it? It even makes the code cleaner in that it documents the usage.
> >
> > These blanket locks like lock_kernel(), preempt_disable(),
> > local_irq_disable() etc. are very hard to get rid of because they don't
> > document what is protected.
> >
> > Please lets not add to this mess and keep all this explicit.
> >
> > Yes, -rt changes the preemption model, and that has concequences. But
> > IMHO the resulting code is cleaner in most cases.
> >
> > I'd go as far as to depricate synchronize_sched() and replace all its
> > users with proper RCU.
> >
> > The more I think of it, the more I dislike this synchronize_all_irqs()
> > and the 'magic' property of irq handlers.
> 
> Thinking a little more about this, I fully agree with Peter.

Again, it is not me that you need to convince.  ;-)

> What code needs to know that all spin_locks have released, or you want to
> know all irq handlers are done?
> 
> Seems that this is a broad data to ask for and will be a bitch to clean up
> when we find out that this is not scalable. This all sounds like
> reinventing the BKL.

It would scale just fine, and inherently does not need priority boosting
(since preempted/blocked things cannot hold up sychronize_sched()).
That said, I do agree with you that having things explicit is a good
thing.

> If you simply want a RCU type of scheme, then simply use RCU.  I second
> deprecating "synchronize_sched". Everything that does RCU type locking
> (that is waiting for some kind of grace period to finish) should simply
> use RCU and not a "wait for all processes to voluntarily schedule" or
> "wait for all interrupt handlers to finish".

Here are the uses in 2.6.23-rc6.  There are several that might not
be so easy to replace with RCU.

						Thanx, Paul

arch/i386/oprofile/nmi_timer_int.c timer_stop 55 synchronize_sched();
arch/x86_64/kernel/mce.c mce_read 607 synchronize_sched();
drivers/acpi/processor_idle.c acpi_processor_cst_has_changed 1132 synchronize_sched();
drivers/char/ipmi/ipmi_si_intf.c try_smi_init 2879 synchronize_sched();
drivers/char/sonypi.c sonypi_remove 1435 synchronize_sched();
drivers/input/keyboard/atkbd.c atkbd_disconnect 827 synchronize_sched();
drivers/input/serio/i8042.c i8042_stop 281 synchronize_sched();
drivers/net/r8169.c rtl8169_down 2866 synchronize_sched();
drivers/net/sis190.c sis190_down 1123 synchronize_sched();
drivers/s390/cio/airq.c s390_register_adapter_interrupt 46 synchronize_sched();
drivers/s390/cio/airq.c s390_unregister_adapter_interrupt 66 synchronize_sched();
kernel/kprobes.c check_safety 127 synchronize_sched();
kernel/kprobes.c unregister_kprobe 632 synchronize_sched();
kernel/kprobes.c disable_all_kprobes 970 synchronize_sched();
kernel/module.c sys_init_module 2013 synchronize_sched();
kernel/profile.c sys_init_module 195 synchronize_sched();
kernel/rcutorture.c sched_torture_synchronize 490 synchronize_sched();
kernel/sched.c detach_destroy_domains 6329 synchronize_sched();
kernel/srcu.c synchronize_srcu 176 synchronize_sched();
kernel/srcu.c synchronize_srcu 193 synchronize_sched();
kernel/srcu.c synchronize_srcu 206 synchronize_sched();
