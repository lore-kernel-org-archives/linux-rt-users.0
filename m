From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Wed, 28 Dec 2011 14:35:36 +0100
Message-ID: <4EFB1B28.7090203@linux.intel.com>
References: <1324717569.5025.73.camel@marge.simson.net>  <1324968044.5217.103.camel@marge.simson.net>  <1324977605.5217.132.camel@marge.simson.net> <1325049448.4726.16.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8122 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab1L1Nfj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Dec 2011 08:35:39 -0500
In-Reply-To: <1325049448.4726.16.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/28/2011 6:17 AM, Mike Galbraith wrote:
> On Tue, 2011-12-27 at 10:20 +0100, Mike Galbraith wrote:
>> Quoting removal commit af5ab277ded04bd9bc6b048c5a2f0e7d70ef0867 
>> Historically, Linux has tried to make the regular timer tick on
>> the various CPUs not happen at the same time, to avoid contention
>> on xtime_lock.
>> 
>> Nowadays, with the tickless kernel, this contention no longer
>> happens since time keeping and updating are done differently. In
>> addition, this skew is actually hurting power consumption in a
>> measurable way on many-core systems. End quote
> 
> Hm, nohz enabled, hogs burning up 60 of 64 cores.
> 
> 56.11%  [kernel]      [k] ktime_get 5.54%  [kernel]      [k]
> scheduler_tick 4.02%  [kernel]      [k] cpuacct_charge 3.78%
> [kernel]      [k] __rcu_pending 3.76%  [kernel]      [k]
> tick_sched_timer 3.42%  [kernel]      [k] native_write_msr_safe 
> 1.58%  [kernel]      [k] run_timer_softirq 1.28%  [kernel]      [k]
> __schedule 1.21%  [kernel]      [k] apic_timer_interrupt 1.07%
> [kernel]      [k] _raw_spin_lock 0.81%  [kernel]      [k]
> __switch_to 0.67%  [kernel]      [k] thread_return
> 
> Maybe skew-me wants to become a boot option?

this is 56% of kernel time.. of how much total time?

(and are you using a system where tsc/lapic can be used, or are you
using one of those boatanchors that need hpet?)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJO+xsmAAoJEEHdSxh4DVnEcDoIAK8Q0rTCNb/xX3mNm7QpLpIU
kLXEHvv7Xk58TxKfOC7EDmD4EMdJxbebL6ZR7ol/J7mkQjnUjsFdGF1qF1TAW1Ph
YdPV5liDMfwO+Aczj0ZdBBacuoIivUrFcwArKwonttwSB0dh1vyJU9VsRC7nTu4z
eILaiYOr2pTBSKReYiQxr9u+1/zfmlwsENbbq/Z/JnbQYdf1y0ZNZ1kDF4zOwuHQ
EdVu4o1RPRXwBlMI+6E3CaEyl6wACOGyoy3tsuHoR7Ax6YcwJUoDFmAVP8Bb+YE8
19AlRDnBwSCV+AaJ3qbaEdPdpX7Alp1h3fpdH8rZ/Ndu5DTeGDAuYI1HIDicZgA=
=pSVy
-----END PGP SIGNATURE-----
