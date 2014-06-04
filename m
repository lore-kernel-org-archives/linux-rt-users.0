From: "Brad Mouring" <bmouring@ni.com>
Subject: Re: [PATCH 1/1] rtmutex: Handle when top lock owner changes
Date: Wed, 4 Jun 2014 09:38:30 -0500
Message-ID: <20140604143830.GA3393@linuxgetsreal>
References: <1400855410-14773-1-git-send-email-brad.mouring@ni.com>
 <1400855410-14773-2-git-send-email-brad.mouring@ni.com>
 <20140603210609.62de6451@gandalf.local.home>
 <20140604130525.GA1621@linuxgetsreal>
 <20140604101612.0d47b399@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad Mouring <bmouring@ni.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140604101612.0d47b399@gandalf.local.home>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Jun 04, 2014 at 10:16:12AM -0400, Steven Rostedt wrote:
> On Wed, 4 Jun 2014 08:05:25 -0500
> "Brad Mouring" <bmouring@ni.com> wrote:
> 
>  >          A->L2
> > 
> > This is a slight variation on what I was seeing. To use the nomenclature
> > that you proposed at the start, rewinding to the point
> > 
> >    A->L2->B->L3->C->L4->D
> > 
> > Let's assume things continue to unfold as you explain. Task is D,
> > top_waiter is C. A is scheduled out and the chain shuffles.
> > 
> >        A->L2->B
> > C->L4->D->'
> 
> But isn't that a lock ordering problem there?
> 
> If B can block on L3 owned by C, I see the following:
> 
>   B->L3->C->L4->D->L2->B
> 
> Deadlock!
Yes, it could be. But currently no one owns L3. B is currently not
blocked. Under these circumstances, there is no deadlock. Also, I
somewhat arbitrarily picked L4, it could be Lfoo that C blocks on
since the process is
...
waiter = D->pi_blocked_on

// waiter is real_waiter D->L2

// orig_waiter still there, orig_lock still has an owner

// top_waiter was pointing to C->L4, now points to C->Lfoo
// D does have top_waiters, and, as noted above, it aliased
// to encompass a different waiter scenario

> 
> In my scenario I was very careful to point out that the lock ordering
> was: L1->L2->L3->L4
> 
> But you show that we can have both:
> 
>    L2-> ... ->L4
> 
>     and
> 
>    L4-> ... ->L2
> 
> Which is a reverse of lock ordering and a possible deadlock can occur.

So the numbering/ordering of the locks is really somewhat arbitrary.
Here we *can* have L2-> ... ->L4 (if B decides to block on L2, it
could just as easily block on L8), and we absolutely have
L4-> ... ->L2. A deadlock *could* occur, but all of the traces that
I dug through, no actual deadlocks occurred.
> 
> -- Steve
> 
> 
> > 
> > So, we now have D blocking on L2 and L4 has waiters, C again. Also,
> > since the codepath to have C block on L4 again is the same as the
> > codepath from when it blocked on it in the first place, the location
> > is the same since the stack (for what we care about) is the same.
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
