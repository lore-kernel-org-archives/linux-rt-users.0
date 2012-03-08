From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Thu, 08 Mar 2012 16:44:38 -0500
Message-ID: <1331243078.25686.510.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>
	 <1331230991.25686.452.camel@gandalf.stny.rr.com>
	 <1331231287.11248.396.camel@twins>
	 <1331232159.25686.456.camel@gandalf.stny.rr.com>
	 <1331235579.11248.402.camel@twins>
	 <1331237441.25686.469.camel@gandalf.stny.rr.com>
	 <1331238369.11248.426.camel@twins>
	 <1331240882.25686.499.camel@gandalf.stny.rr.com>
	 <1331241627.11248.430.camel@twins>
	 <1331241940.25686.502.camel@gandalf.stny.rr.com>
	 <1331242104.11248.432.camel@twins>
	 <1331242574.25686.505.camel@gandalf.stny.rr.com>
	 <1331242625.11248.433.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331242625.11248.433.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-03-08 at 22:37 +0100, Peter Zijlstra wrote:

> > Now when the original task releases the lock again, the other task can
> > take it just like it does on mainline.
> 
> Now interleave it with a third task of even higher priority that puts
> the spinner to sleep.

So? It will eventually have to allow the task to run. Adding a "third
higher priority" task can cause problems in any other part of the -rt
kernel.

We don't need to worry about priority inversion. If the higher task
blocks on the original task, it will boost its priority (even if it does
the adaptive spin) which will again boost the task that it preempted.

Now we may need to add a sched_yield() in the adaptive spin to let the
other task run.

-- Steve
