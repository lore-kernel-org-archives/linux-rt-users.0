From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Fwd: Re: RFC for a new Scheduling policy/class in the
 Linux-kernel]
Date: Mon, 03 May 2010 16:41:22 +0200
Message-ID: <1272897682.1642.124.camel@laptop>
References: <20100426115658.GA21346@cs.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: raj@ece.cmu.edu, jayhawk@soe.ucsc.edu, raistlin@linux.it,
	niehaus@ittc.ku.edu, henrik@austad.us,
	linux-kernel@vger.kernel.org, mingo@elte.hu,
	billh@gnuppy.monkey.org, linux-rt-users@vger.kernel.org,
	fabio@gandalf.sssup.it, anderson@cs.unc.edu, tglx@linutronix.de,
	dhaval.giani@gmail.com, cucinotta@sssup.it, lipari@retis.sssup.it,
	baker.tlh@comcast.net
To: Ted Baker <baker@cs.fsu.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100426115658.GA21346@cs.fsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Ted,

On Mon, 2010-04-26 at 07:56 -0400, Ted Baker wrote:
> I have not seen any more e-mail on this.  How is it going?  Is there any
> chance of rolling in some corrections for the SCHED_SPORADIC treatment?  In
> particular, could we have a DO_NOT_RUN priority, that is guaranteed to
> prevent a task from running at all?

Without having fully read the referenced paper, we're currently looking
to support the sporadic task model through SCHED_DEADLINE (by our SSSUP
friends):

  http://lkml.org/lkml/2010/2/28/107

This work aims to implement a full sporadic task scheduler [initially
(g)EDF], SCHED_SPORADIC would have been a better name, but since POSIX
stole that from us we took SCHED_DEADLINE to indicate its a deadline
scheduler.

Along with this work comes the full Deadline-inheritance (which should
be but a small change from our current Priority-inheritance code), and
also Bandwidth-inheritance (more work). Esp. the latter would also be
required for your proposed SCHED_SPORADIC since it does aim to be a
'strict' bandwidth enforcing scheduler.

[Does the proposed 'fixed' SCHED_SPORADIC deal with admission control?]

But as it stands, this work would provide much more complete sporadic
task support than the fixed SCHED_SPORADIC would.
