From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.1-rt1
Date: Wed, 10 Oct 2012 13:48:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210101347410.2853@ionos>
References: <alpine.LFD.2.02.1210091535140.10988@ionos>  <1349806792.24256.34.camel@gandalf.local.home>  <1349828517.24256.47.camel@gandalf.local.home> <1349833878.24256.49.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42927 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2JJLsM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2012 07:48:12 -0400
In-Reply-To: <1349833878.24256.49.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 9 Oct 2012, Steven Rostedt wrote:

> On Tue, 2012-10-09 at 20:21 -0400, Steven Rostedt wrote:
> 
> > > 0007-stomp-machine-deal-clever-with-stopper-lock.patch
> > 
> > With this one, things have changed quite a bit. I'll take a deeper look
> > at what you did and figure out how this applies to v3.0-rt.
> 
> It doesn't look like this patch is needed for v3.0-rt as the patch
> addresses the new stop_machine_from_inactive_cpu() API used by the mtrr
> code added by this commit:
> 
> commit 192d8857427dd23707d5f0b86ca990c3af6f2d74
> Author: Suresh Siddha <suresh.b.siddha@intel.com>
> Date:   Thu Jun 23 11:19:29 2011 -0700
> 
>     x86, mtrr: use stop_machine APIs for doing MTRR rendezvous
> 
> 
> This was added in 3.1 so the patch is still required for v3.2-rt.

Correct. 3.0 is not affected.

	 tglx
