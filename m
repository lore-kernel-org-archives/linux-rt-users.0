From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/4] tools lib traceevent: Implements '%' operation
Date: Tue, 23 Feb 2016 11:44:32 -0300
Message-ID: <20160223144432.GB2749@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
 <5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
 <20160222152303.02f79376@gandalf.local.home>
 <20160223143819.GA2749@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, acme@kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160223143819.GA2749@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Tue, Feb 23, 2016 at 11:38:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Feb 22, 2016 at 03:23:03PM -0500, Steven Rostedt escreveu:
> > On Mon, 22 Feb 2016 14:08:22 -0300
> > Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> > 
> > > The operation '%' is not implemented on event-parse.c, causing
> > > an error on the parse of events with '%' operation on its
> > > printk format. For example,
> > > 
> > > # perf record -e sched:sched_deadline_yield ~/y
> > >   Warning: [sched:sched_deadline_yield] unknown op '%'
> > > ....
> > > # perf script

Daniel, please add two spaces before examples, specially examples with
the '#' root prompt.

Had I not done that when applying this patch, those lines would have
been removed by git-am, as it would interpret those as comments.

Thanks,

- Arnaldo
