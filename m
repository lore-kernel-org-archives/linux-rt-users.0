From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Wed, 24 Feb 2016 09:48:22 +0100
Message-ID: <20160224084822.GC22868@gmail.com>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
 <20160222213017.GN6357@twins.programming.kicks-ass.net>
 <20160222173043.24873ae8@gandalf.local.home>
 <20160223104408.GO6357@twins.programming.kicks-ass.net>
 <20160223081046.529d615c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160223081046.529d615c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 23 Feb 2016 11:44:08 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > No it very much illustrates the problem and is a very clear indication
> > that tracepoints are an ABI.
> 
> Yes they are. But note, they can change if nobody notices ;-)

Which is rather seldom for something as high profile as core scheduler
tracepoints ...

You can be cavalier about tracepoints in subsystems where the tracepoints are at 
most used by the maintainers with specialized, closely maintained tooling that is 
easy to change. Not so much about scheduler tracepoints which are being widely 
utilized by various projects.

Thanks,

	Ingo
