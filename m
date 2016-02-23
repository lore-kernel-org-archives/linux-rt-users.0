From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/4] tools lib traceevent: Implements '%' operation
Date: Tue, 23 Feb 2016 11:38:19 -0300
Message-ID: <20160223143819.GA2749@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
 <5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
 <20160222152303.02f79376@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160222152303.02f79376@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Mon, Feb 22, 2016 at 03:23:03PM -0500, Steven Rostedt escreveu:
> On Mon, 22 Feb 2016 14:08:22 -0300
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
> > The operation '%' is not implemented on event-parse.c, causing
> > an error on the parse of events with '%' operation on its
> > printk format. For example,
> > 
> > # perf record -e sched:sched_deadline_yield ~/y
> >   Warning: [sched:sched_deadline_yield] unknown op '%'
> > ....
> > # perf script
> >   Warning: [sched:sched_deadline_yield] unknown op '%'
> > 	y  1641 [006]  3364.109319: sched:sched_deadline_yield: \
> > 			[FAILED TO PARSE] now=3364109314595 	\
> > 			deadline=3364139295135 runtime=19975597
> > 
> > This patch implements the '%' operation. With this patch, we see the
> > correct output:
> > 
> > # perf record -e sched:sched_deadline_yield ~/y
> >   No Warning
> > 
> > # perf script
> > 	y  4005 [001]  4623.650978: sched:sched_deadline_yield: \
> > 		now=4623.650974050				\
> > 		deadline=4623.680957364 remaining_runtime=19979611
> > 
> > Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> Arnaldo,
> 
> This patch is not dependent on the rest of the series and looks like a
> good general fix.
> 
> Can you pull this one into your tree, and please add my:
> 
> Reviewed-by: Steven Rostedt <rsotedt@goodmis.org>

Done, thanks.

- Arnaldo
