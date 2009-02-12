From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] rt: res_counter fix, v2
Date: Thu, 12 Feb 2009 15:58:04 +0100
Message-ID: <1234450684.10603.18.camel@laptop>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <20090212005032.GA4788@nowhere> <20090212021257.GB4697@nowhere>
	 <20090212101650.GA1096@elte.hu> <20090212102113.GA10031@elte.hu>
	 <20090212142806.GA5865@nowhere> <1234449701.10603.10.camel@laptop>
	 <20090212144624.GB14616@elte.hu>  <20090212145010.GB6056@nowhere>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:46276 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312AbZBLO6Z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 09:58:25 -0500
In-Reply-To: <20090212145010.GB6056@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-02-12 at 15:50 +0100, Frederic Weisbecker wrote:
>  
> > maybe we should initialize it to -1 to make this more apparent?
> 
> 
> Or why not set p->{hard,soft}irq_disable_ip = NULL ? (or 0, I don't know its type).

It is to reflect the actual state at copy_process(), although I think
here's a little buglet:

ifdef CONFIG_TRACE_IRQFLAGS
	p->irq_events = 0;
#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
	p->hardirqs_enabled = 1;
#else
	p->hardirqs_enabled = 0;
#endif
	p->hardirq_enable_ip = 0;
	p->hardirq_enable_event = 0;
	p->hardirq_disable_ip = _THIS_IP_;
	p->hardirq_disable_event = 0;
	p->softirqs_enabled = 1;
	p->softirq_enable_ip = _THIS_IP_;
	p->softirq_enable_event = 0;
	p->softirq_disable_ip = 0;
	p->softirq_disable_event = 0;
	p->hardirq_context = 0;
	p->softirq_context = 0;
#endif

I think the hardirq_enable/disable_ip should also depend on
__ARCH_WANT_INTERRUPTS_ON_CTXSW.



