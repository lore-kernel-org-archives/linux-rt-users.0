From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Fri, 7 Aug 2015 11:25:41 +0200
Message-ID: <20150807092541.GE16853@twins.programming.kicks-ass.net>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
 <20150806192243.GD1342@windriver.com>
 <20150806153120.61186803@gandalf.local.home>
 <20150806213649.GB16853@twins.programming.kicks-ass.net>
 <20150806181412.5b474213@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150806181412.5b474213@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 06, 2015 at 06:14:12PM -0400, Steven Rostedt wrote:
> On Thu, 6 Aug 2015 23:36:49 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Aug 06, 2015 at 03:31:20PM -0400, Steven Rostedt wrote:
> > > > 4) poll_wait: currently it and poll_table_entry are both hard coupled
> > > >    to wait_queue_head_t -- so any users of poll_wait are not eligible
> > > >    for conversion to simple wait. (I just happened to notice that
> > > >    recently.)  A quick grep shows ~500 poll_wait users.
> > > 
> > > Looks like a good candidate to test the cwait on :-)
> > 
> > Poll uses custom wake functions, which disqualifies them on the spot.
> 
> For cwait? That's the complex wait queue (what the current wait queues
> will be called in the future).

Urgh, I don't think we should go rename that.. that's going to be lots
of pain for no to little gain.
