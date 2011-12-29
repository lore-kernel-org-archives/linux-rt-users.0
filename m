From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Thu, 29 Dec 2011 08:22:30 +0100
Message-ID: <1325143350.4819.13.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324968044.5217.103.camel@marge.simson.net>
	 <1324977605.5217.132.camel@marge.simson.net>
	 <1325049448.4726.16.camel@marge.simson.net>
	 <4EFB1B28.7090203@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:52935 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751284Ab1L2HWf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Dec 2011 02:22:35 -0500
In-Reply-To: <4EFB1B28.7090203@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-12-28 at 14:35 +0100, Arjan van de Ven wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/28/2011 6:17 AM, Mike Galbraith wrote:
> > On Tue, 2011-12-27 at 10:20 +0100, Mike Galbraith wrote:
> >> Quoting removal commit af5ab277ded04bd9bc6b048c5a2f0e7d70ef0867 
> >> Historically, Linux has tried to make the regular timer tick on
> >> the various CPUs not happen at the same time, to avoid contention
> >> on xtime_lock.
> >> 
> >> Nowadays, with the tickless kernel, this contention no longer
> >> happens since time keeping and updating are done differently. In
> >> addition, this skew is actually hurting power consumption in a
> >> measurable way on many-core systems. End quote
> > 
> > Hm, nohz enabled, hogs burning up 60 of 64 cores.
> > 
> > 56.11%  [kernel]      [k] ktime_get 5.54%  [kernel]      [k]
> > scheduler_tick 4.02%  [kernel]      [k] cpuacct_charge 3.78%
> > [kernel]      [k] __rcu_pending 3.76%  [kernel]      [k]
> > tick_sched_timer 3.42%  [kernel]      [k] native_write_msr_safe 
> > 1.58%  [kernel]      [k] run_timer_softirq 1.28%  [kernel]      [k]
> > __schedule 1.21%  [kernel]      [k] apic_timer_interrupt 1.07%
> > [kernel]      [k] _raw_spin_lock 0.81%  [kernel]      [k]
> > __switch_to 0.67%  [kernel]      [k] thread_return
> > 
> > Maybe skew-me wants to become a boot option?
> 
> this is 56% of kernel time.. of how much total time?

To answer the question..

 99.57%  burn                        [.] main
  0.14%  [kernel]                    [k] ktime_get

That's the DL980 running a 250Hz kernel.  Dinky, but for my picky RT
load, too much nonetheless.  (hm, what would SGI monster box say?)

	-Mike

