From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 6/6] vtime: Convert vtime_seqlock into
 raw_spinlock_t and seqcount combo
Date: Thu, 11 Jul 2013 10:30:22 -0400
Message-ID: <1373553022.17876.11.camel@gandalf.local.home>
References: <20130626192806.107564905@goodmis.org>
	 <20130626193050.529670718@goodmis.org>
	 <20130710171212.GA13553@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130710171212.GA13553@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-07-10 at 13:12 -0400, Paul Gortmaker wrote:
> [[RFC][PATCH RT 6/6] vtime: Convert vtime_seqlock into raw_spinlock_t and seqcount combo] On 26/06/2013 (Wed 15:28) Steven Rostedt wrote:
> 
> > The vtime seqlock needs to be taken in true interrupt context on -rt.
> > The normal seqlocks are converted to mutexes when PREEMPT_RT_FULL is
> > enabled, which will break the vtime code as the calls are done from
> > interrupt context.
> > 
> > Convert the vtime seqlock into the raw_spinlock_t and seqcount combo
> > that can be done in interrupt context.
> 
> Alternatively, we could revive the raw seqlock patch from Thomas?
> 
> https://lkml.org/lkml/2010/2/17/238
> 
> Below is a version updating it to 3.8.x-RT.  One downside is that
> current mainline kernels have raw_seqcount_begin() function, which has
> nothing to do with preempt-rt, so the seqcount function namespace can
> get confusing unless we rename raw_seqcount_begin to something that
> doesn't sound RT-ish.

There's a reason that Thomas didn't bring that patch forward, but I
don't recall what it was.

Thomas?

-- Steve
