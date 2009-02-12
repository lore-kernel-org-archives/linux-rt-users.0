From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] rt: fix ipi kfree(), introduce IPI_SOFTIRQ
Date: Thu, 12 Feb 2009 09:27:51 +0100
Message-ID: <20090212082751.GA29856@elte.hu>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <20090212005032.GA4788@nowhere> <20090212021257.GB4697@nowhere> <20090212081801.GA22979@elte.hu> <20090212081923.GA26838@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:54757 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbZBLI2O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 03:28:14 -0500
Content-Disposition: inline
In-Reply-To: <20090212081923.GA26838@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm, that's a complex one - we do kfree() from IPI context, [...]
> 
> The patch below might do the trick - it offloads this to a softirq.
> Not tested yet.

ok, it's lightly tested now: it built and booted up fine to X with your config.

	Ingo
