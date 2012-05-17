From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Thu, 17 May 2012 08:47:55 -0700
Message-ID: <20120517154755.GG2567@linux.vnet.ibm.com>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>
 <20120517151838.GA8692@linux.vnet.ibm.com>
 <1337268779.4281.38.camel@twins>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1337268779.4281.38.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, May 17, 2012 at 05:32:59PM +0200, Peter Zijlstra wrote:
> On Thu, 2012-05-17 at 08:18 -0700, Paul E. McKenney wrote:
> > Some researchers at MIT RCU-ified this lock:
> > 
> > http://people.csail.mit.edu/nickolai/papers/clements-bonsai.pdf 
> 
> Ah, as have I [1].. and they seem to have gotten about as far as I have,
> which means almost there but not quite [2] :-)

I had forgotten about that -- that was the first call for call_srcu(),
if I remember correctly.

> The most interesting case is file maps and they simply ignored those.
> While I appreciate that from an academic pov, -- they can still write a
> paper on the other interesting bits -- I don't really like it from a
> practical point.
> 
> [1] https://lkml.org/lkml/2010/1/4/257
> [2] https://lkml.org/lkml/2010/1/4/532

Hmmm...  Do the recent dcache changes cover some of the things that
Linus called out?  Probably not, but some at least.

							Thanx, Paul
