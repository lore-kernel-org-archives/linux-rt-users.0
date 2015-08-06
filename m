From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Thu, 6 Aug 2015 15:31:20 -0400
Message-ID: <20150806153120.61186803@gandalf.local.home>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
	<20150806192243.GD1342@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <bigeasy@linutronix.de>,
	<tglx@linutronix.de>, <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150806192243.GD1342@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 6 Aug 2015 15:22:45 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> [[RFC v0 0/3] Simple wait queue support] On 05/08/2015 (Wed 15:30) Daniel Wagner wrote:
> 
> > Hi,
> > 
> > It's a while since the last attempt by Paul to get simple wait ready
> > for mainline [1]. At the last realtime workshop it was discussed how
> > the swait implementation could be made preempt aware. Peter posted an
> > untested version of it here [2].
> 
> So, from memory, here are the issues or questions that need answers
> before we can consider trying mainline IMO.
> 
> 1) naming: do we keep the swait, do we try and morph complex wait users
>    into using cwait, or some mix of the two, or ... ?

I would say keep swait for now. Convert a few major hitters to it to
test it out. After a release or two, create a cwait, and start
converting the complex waits to them. Then after a period of stability,
convert the normal wait_queues to be implemented with swait, and remove
the swait from the kernel.

> 
> 2) placement: as I think I said before, the standalone files works for
>    the -rt patches because it is the lowest maintenance solution, but
>    IMO for mainline, the simple and complex versions should be right
>    beside each other so they can be easily contrasted and compared and
>    so any changes to one will naturally also flow to the other.

I'm agnostic on this part.

> 
> 3) barrier usage:  we'd had some questions and patches in the past that
>    futz'd around with the use of barriers, and as a mainline requirement
>    we'd need someone to check, understand and document them all properly.

Sounds like a plan.

> 
> 4) poll_wait: currently it and poll_table_entry are both hard coupled
>    to wait_queue_head_t -- so any users of poll_wait are not eligible
>    for conversion to simple wait. (I just happened to notice that
>    recently.)  A quick grep shows ~500 poll_wait users.

Looks like a good candidate to test the cwait on :-)

> 
> 5) the aforementioned "don't do an unbounded number of callbacks while
>    holding the raw lock" issue.
> 
> We should solve #5 for -rt regardless; I wouldn't attempt to make a
> new "for mainline" set again w/o some consensus on #1 and #2, and I
> think it would take someone like peterz/paulmck/rostedt to do #3
> properly.  I don't know if #4 is an issue we need to worry about
> right away; probably not.  And I'm sure I'll think of some other
> issue five seconds after I hit send...
> 

5... 4... 3... 2... 1... (where's the other issue?)

-- Steve
