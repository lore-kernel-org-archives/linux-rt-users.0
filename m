From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [patch] rt: res_counter fix, v2
Date: Thu, 12 Feb 2009 15:50:11 +0100
Message-ID: <20090212145010.GB6056@nowhere>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <20090212005032.GA4788@nowhere> <20090212021257.GB4697@nowhere> <20090212101650.GA1096@elte.hu> <20090212102113.GA10031@elte.hu> <20090212142806.GA5865@nowhere> <1234449701.10603.10.camel@laptop> <20090212144624.GB14616@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41505 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbZBLOuS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 09:50:18 -0500
Content-Disposition: inline
In-Reply-To: <20090212144624.GB14616@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 12, 2009 at 03:46:24PM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > On Thu, 2009-02-12 at 15:28 +0100, Frederic Weisbecker wrote:
> > > > [   45.228589] hardirqs last disabled at (0): [<ffffffff8025449d>] copy_process+0x68d/0x1500
> > > > [   45.228602] softirqs last  enabled at (0): [<ffffffff8025449d>] copy_process+0x68d/0x1500
> > > 
> > > 
> > > The reason for which I wanted to send an irqsoff trace is that the above lines are false.
> > 
> > copy_process() has:
> > 
> > #endif
> > 	p->hardirq_enable_ip = 0;
> > 	p->hardirq_enable_event = 0;
> > 	p->hardirq_disable_ip = _THIS_IP_;
> > 	p->hardirq_disable_event = 0;
> > 	p->softirqs_enabled = 1;
> > 	p->softirq_enable_ip = _THIS_IP_;
> > 	p->softirq_enable_event = 0;
> > 	p->softirq_disable_ip = 0;
> > 	p->softirq_disable_event = 0;
> > 	p->hardirq_context = 0;
> > 	p->softirq_context = 0;
> > #endif
> > 
> > the sequence count of 0 basically tells you it hasn't been set yet.


Oh I see now, thanks Peter.

 
> maybe we should initialize it to -1 to make this more apparent?


Or why not set p->{hard,soft}irq_disable_ip = NULL ? (or 0, I don't know its type).


> 	Ingo

