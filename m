From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 18:04:01 +0200
Message-ID: <20160329160401.GB3430@twins.programming.kicks-ass.net>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <20160329115700.40acb336@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47145 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbcC2QEJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 12:04:09 -0400
Content-Disposition: inline
In-Reply-To: <20160329115700.40acb336@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 29, 2016 at 11:57:00AM -0400, Steven Rostedt wrote:
> Hmm, I probably could add tracing infrastructure that would let us
> extend existing tracepoints. That is, without modifying sched_switch,
> we could add a new tracepoint that when enabled, would attach itself to
> the sched_switch tracepoint and record different information. Like a
> special sched_switch_deadline tracepoint, that would record the existing
> runtime,deadline and period for deadline tasks. It wont add more
> tracepoints into the core scheduler, but use the existing one.

Urgh; maybe. But I would would not want the new thing to be called
_deadline, maybe _v{n} id anything and have a KERN_WARNING emitted when
people enable the old one.

Ideally we'd rename the old one, but I suspect even that would break
stuff :/
