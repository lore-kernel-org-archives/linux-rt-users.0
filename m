From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Thu, 17 Mar 2016 15:36:20 +0000
Message-ID: <20160317153620.GA8933@osadl.at>
References: <20160316233530.GA8731@kroah.com>
 <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
 <20160316221751.71816309@grimm.local.home>
 <20160317073605.GM6344@twins.programming.kicks-ass.net>
 <20160317080526.GB6679@osadl.at>
 <20160317101823.GQ6344@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1603171214530.3978@nanos>
 <20160317080629.1af8f733@grimm.local.home>
 <20160317121333.GU6344@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1603171431490.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <agnel.joel@gmail.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603171431490.3978@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Mar 17, 2016 at 02:32:54PM +0100, Thomas Gleixner wrote:
> On Thu, 17 Mar 2016, Peter Zijlstra wrote:
> > On Thu, Mar 17, 2016 at 08:06:29AM -0400, Steven Rostedt wrote:
> > > On Thu, 17 Mar 2016 12:16:11 +0100 (CET)
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > > > On Thu, 17 Mar 2016, Peter Zijlstra wrote:
> > > > > Also, maybe the tracer should measure the time from need_resched()
> > > > > getting true until the next preemption point, instead of the entire time
> > > > > preemption was disabled. Which would avoid the entire issue altogether.  
> > > > 
> > > > Well, that only gives you the information on a actual preemption, but not
> > > > information about long preempt disabled regions which can cause a problem
> > > > eventually.
> > > > 
> > > 
> > > Actually, I was thinking the reverse. If need_resched() is called and
> > > is false, then do a reset of the preemption time. But if need_resched()
> > > is true, then do nothing, as that would measure the total time preempt
> > > disable was set and a task could not schedule.
> > > 
> > > Question is, should this be a hook and each location audited, or add
> > > this to need_resched() itself?
> > 
> > Is anybody calling need_resched() and then not doing anything with the
> > value?
> 
> Probably not. So Stevens idea makes a lot of sense.
>

Provably not (provided I did not screw up the spec). So all need_resched
are ither in a if|while condition, an argument to a function or part of a 
return value.

<snip>
@need_resched exists@
identifier func,val;
statement S1,S2;
expression E1,E2;
position p;
@@

(
  if(<+... need_resched()@p ...+>) S1 else S2
|
  while (<+... need_resched()@p ...+>) S1
//|
//  Do while not supported in coccinelle :(
//  do { ... } while (<+... need_resched()@p ...+>);
|
  val = need_resched()@p ? E1 : E2;
|
  func(..., need_resched()@p, ...);
|
  return <+... need_resched()@p ...+>;
)

@need_resched_unused exists@
position p != need_resched.p;
@@

* need_resched()@p

@script:python@
p << need_resched_unused.p;
@@
print "need_resched() in %s line %s not used" % (p[0].file,p[0].line)
<snip> 

 except for the unhandled do{...} while(need_resched()); cases as cocci
 currently does not support do{}while(); constructs this does not report
 any unused need_resched() cases and the 5 reported findings:
need_resched() in ./include/net/busy_poll.h line 112 not used
need_resched() in ./kernel/sched/core.c line 3453 not used
need_resched() in ./kernel/sched/core.c line 3573 not used
need_resched() in ./kernel/sched/core.c line 3546 not used
need_resched() in ./kernel/sched/core.c line 3406 not used
 where manually checked and are all do{}while(need_resched()); cases.

thx!
hofrat
