From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 20 Mar 2015 10:30:05 -0400
Message-ID: <20150320103005.3914fd8d@gandalf.local.home>
References: <20150318144946.2f3cc982@gandalf.local.home>
	<20150320103120.GZ23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150320103120.GZ23123@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 20 Mar 2015 11:31:20 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Parts-suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> OK, queued it.

Feel free to update that loop.

> Do we want to look into making the same change for
> deadline once this has settled?

Hmm, looks like it could use it as well. Should that code be made a bit
more generic to share the same algorithm? Would need to pass in a
pointer to the mask to check.

-- Steve
