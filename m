From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 23:03:43 +0200
Message-ID: <20160329210343.GP3408@twins.programming.kicks-ass.net>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <20160329115700.40acb336@gandalf.local.home>
 <20160329160401.GB3430@twins.programming.kicks-ass.net>
 <20160329131056.5b01780b@gandalf.local.home>
 <20160329201145.GC3430@twins.programming.kicks-ass.net>
 <20160329162907.418cb972@gandalf.local.home>
 <56FAEC3D.1070300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59841 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbcC2VDq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 17:03:46 -0400
Content-Disposition: inline
In-Reply-To: <56FAEC3D.1070300@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> And any change on it, now and in the future, will cause confusion for
> 99.999% of raw sched_switch users.

Sod that, this attitude makes me want to rip out all sched tracepoints.

> Without considering those who wrote bad applications that will break,

That's bonus points, right?

I'm seriously annoyed with this hard ABI for tracepoints crap.

