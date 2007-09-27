From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Thu, 27 Sep 2007 10:32:30 -0400
Message-ID: <d120d5000709270732p7caf393cjf6fd5c4d789cc740@mail.gmail.com>
References: <20070926011139.GW8432@linux.vnet.ibm.com>
	 <20070926155656.GA9101@linux.vnet.ibm.com>
	 <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
	 <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
	 <20070926195513.GA10544@linux.vnet.ibm.com>
	 <1190840086.18147.38.camel@lappy>
	 <Pine.LNX.4.58.0709261701460.6405@gandalf.stny.rr.com>
	 <20070926214219.GC10544@linux.vnet.ibm.com>
	 <d120d5000709270724n1d318a88o2d9bd058f2d0f405@mail.gmail.com>
	 <Pine.LNX.4.58.0709271026040.7748@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48476 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363AbXI0Occ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2007 10:32:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2233327nfb
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Sep 2007 07:32:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709271026040.7748@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9/27/07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> --
> On Thu, 27 Sep 2007, Dmitry Torokhov wrote:
> > >
> > > Here are the uses in 2.6.23-rc6.  There are several that might not
> > > be so easy to replace with RCU.
> > >
> >
> > I will look into converting into "proper RCU" but I'd like you to
> > consider one more thing - proper RCU disables preemption, correct? So
> > it seems that converting code to "proper RCU" to some degree negates
> > the benefits of sleeping spinlocks introduced in -rt. If there was a
> > way to create synchronize_irq_spinlocks() that is separate from RCU
> > and could be preempted that would give the best of the 2 worlds.
> >
>
> Not at all. In -rt, we then use preemptible RCU. So read_rcu_lock does not
> disable preemption in the -rt kernel (and hopefully soon in mainline as
> well - configured not to that is).
>

Ah, OK then.

-- 
Dmitry
