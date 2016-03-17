From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Thu, 17 Mar 2016 08:05:26 +0000
Message-ID: <20160317080526.GB6679@osadl.at>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
 <20160316233530.GA8731@kroah.com>
 <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
 <20160316221751.71816309@grimm.local.home>
 <20160317073605.GM6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <agnel.joel@gmail.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160317073605.GM6344@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Mar 17, 2016 at 08:36:05AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 10:17:51PM -0400, Steven Rostedt wrote:
> > Actually, the preempt off section here is not really an issue:
> > 
> > 	rcu_read_lock();
> > 	while (owner_running(lock, owner)) {
> > 		if (need_resched())
> > 			break;
> > 
> > 		cpu_relax_lowlatency();
> > 	}
> > 	rcu_read_unlock();
> > 
> > Although preemption may be disabled, that "need_resched()" check will
> > break out of the loop if a higher priority task were to want to run on
> > this CPU.
> > 
> > I probably should add a hook there to let the preemptoff tracer know
> > that this is not an issue.
> 
> Urgh, there's a lot of such spin loops all over, that's going to be a
> pain to annotate all.

scanning for that patter with a quite relaxed spatch did not
turn up more than a hand full:

@resched_spin exists@
position p;
@@

(
* while@p (...) {
          ...
          if (need_resched() || ...)
                  break;
          ...
          \(cpu_relax\|cpu_relax_lowlatency\)();
  }
|
* while@p (!need_resched()) {
          ...
          \(cpu_relax\|cpu_relax_lowlatency\)();
  }
)

@script:python@
p << resched_spin.p;
@@
print "%s:%s " % (p[0].file,p[0].line)                                          


is this making some wrong assumptions here or is this
really so infrequent ? 

thx!
hofrat
