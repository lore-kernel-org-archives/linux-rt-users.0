From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Wed, 28 Dec 2011 16:10:37 +0100
Message-ID: <1325085037.16165.31.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324968044.5217.103.camel@marge.simson.net>
	 <1324977605.5217.132.camel@marge.simson.net>
	 <4EFB1A56.1040902@linux.intel.com>
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
Received: from mailout-de.gmx.net ([213.165.64.23]:53087 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752875Ab1L1PKp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Dec 2011 10:10:45 -0500
In-Reply-To: <4EFB1A56.1040902@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-12-28 at 14:32 +0100, Arjan van de Ven wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/27/2011 10:20 AM, Mike Galbraith wrote:
> > 
> > Quoting removal commit af5ab277ded04bd9bc6b048c5a2f0e7d70ef0867 
> > Historically, Linux has tried to make the regular timer tick on
> > the various CPUs not happen at the same time, to avoid contention
> > on xtime_lock.
> > 
> > Nowadays, with the tickless kernel, this contention no longer
> > happens since time keeping and updating are done differently. In
> > addition, this skew is actually hurting power consumption in a
> > measurable way on many-core systems. End quote
> > 
> > Contention remains a problem if NO_HZ is either not configured, or
> > is nohz=off disabled due to workload constraints.  The RT kernel
> > running nohz=off was measured to be using > 1.4% CPU just ticking
> > 64 CPUs, with tick perturbation reaching ~80us.  For loads where
> > measured (>100us) NO_HZ latencies are intolerable, a must have.
> 
> I think we need to just say no to this, and kill the nohz=off option
> entirely.
> 
> Seriously, are people still running with ticks for any legitimate
> reasons? (and not just because they goofed their config file)

Yup.  Realtime loads sometimes need it.  Even without contention
problems, entering/leaving nohz is a latency source.  If every little
bit counts, you may have the choice of letting the electric meter spin
or not getting the job done at all.

	-Mike

