From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 13:19:05 -0400
Message-ID: <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
	 <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
	 <20070925193454.GH8432@linux.vnet.ibm.com>
	 <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
	 <20070926012447.7ffdd45a@lappy>
	 <20070926011139.GW8432@linux.vnet.ibm.com>
	 <20070926102833.17f7c025@twins>
	 <20070926130326.GC19496@linux.vnet.ibm.com>
	 <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
	 <20070926155656.GA9101@linux.vnet.ibm.com>
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
Received: from nf-out-0910.google.com ([64.233.182.186]:47513 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbXIZRTL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 13:19:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2022470nfb
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 10:19:09 -0700 (PDT)
In-Reply-To: <20070926155656.GA9101@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9/26/07, Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Sep 26, 2007 at 09:16:55AM -0400, Dmitry Torokhov wrote:
>
> > No, I don't think synchronize_irq() will work for me. While in i8042 I
> > know there are 2 possible IRQs (so I'd need 2 calls to
> > synchronize_irq()) other drivers may not know what IRQ triggered their
> > handler (or whether it was an IRQ at all).
> >
> > Actually, I need clarifucation on what you mean by "interrupt
> > handlers" in sync_all_irqs(). Right now (if I understand it correctly)
> > synchronize_sched() in mainline will wait for completion of all
> > IRQ-like contexts. By IRQ-like context I mean code guardede by
> > spinlock + IRQ off. Serio (input) drivers have their "interrupt"
> > routines run in that IRQ-like context. They may be invoked as a result
> > of real IRQ being raised but they also be invoked as a result of
> > userspace action of some sort. It all depends on implementation of
> > underlying serio port. So if sync_all_irqs() only waits for real IRQ
> > handlers to complete it is not sufficient in my case...
>
> The synchronize_all_irqs() will not return until:
>
> 1.      All pre-existing hardirqs have completed.
>
> 2.      All pre-existing threaded irqs have completed.
>
> 3.      All preempt_disable() regions of code have completed.
>
> 4.      All irq-disable regions of code have completed.
>
> It will not necessarily wait for all softirqs to complete, but
> then again, synchronize_sched() in non-rt might not wait for all
> softirqs either, for example, if ksoftirqd is handling softirqs.
>
> Does that do what you need, or am I missing a case that needs
> to be covered?

As long as the list includes code guarded by
spin_lock_irqsave()/spin_unlock_irqrestore() I am happy. Does this
count as an irq-disable region? Peter said earlier that in -rt such
code still runs with IRQs enabled...

-- 
Dmitry
