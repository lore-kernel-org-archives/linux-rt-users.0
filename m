From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Thu, 27 Sep 2007 10:28:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709271026040.7748@gandalf.stny.rr.com>
References: <20070926011139.GW8432@linux.vnet.ibm.com>
 <20070926130326.GC19496@linux.vnet.ibm.com>
 <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
 <20070926155656.GA9101@linux.vnet.ibm.com>
 <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
 <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
 <20070926195513.GA10544@linux.vnet.ibm.com>  <1190840086.18147.38.camel@lappy>
  <Pine.LNX.4.58.0709261701460.6405@gandalf.stny.rr.com>
 <20070926214219.GC10544@linux.vnet.ibm.com>
 <d120d5000709270724n1d318a88o2d9bd058f2d0f405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulmck@linux.vnet.ibm.com,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60034 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbXI0O3J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2007 10:29:09 -0400
In-Reply-To: <d120d5000709270724n1d318a88o2d9bd058f2d0f405@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Thu, 27 Sep 2007, Dmitry Torokhov wrote:
> >
> > Here are the uses in 2.6.23-rc6.  There are several that might not
> > be so easy to replace with RCU.
> >
>
> I will look into converting into "proper RCU" but I'd like you to
> consider one more thing - proper RCU disables preemption, correct? So
> it seems that converting code to "proper RCU" to some degree negates
> the benefits of sleeping spinlocks introduced in -rt. If there was a
> way to create synchronize_irq_spinlocks() that is separate from RCU
> and could be preempted that would give the best of the 2 worlds.
>

Not at all. In -rt, we then use preemptible RCU. So read_rcu_lock does not
disable preemption in the -rt kernel (and hopefully soon in mainline as
well - configured not to that is).

-- Steve
