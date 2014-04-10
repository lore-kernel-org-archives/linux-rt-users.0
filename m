From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH RT] rwsem: The return of multi-reader PI rwsems
Date: Thu, 10 Apr 2014 17:03:36 +0200
Message-ID: <5346B2C8.6000207@linutronix.de>
References: <20140409151922.5fa5d999@gandalf.local.home> <20140410094430.56ca9ee1@sluggy.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
To: Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140410094430.56ca9ee1@sluggy.gateway.2wire.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/10/2014 04:44 PM, Clark Williams wrote:
> The means of each group of five test runs are:
> 
> vanilla.log:  1210117 rt.log:  17210953 (14.2 x slower than
> vanilla) rt-fixes.log:  10062027 (8.3 x slower than vanilla) 
> rt-multi.log:  3179582  (2.x x slower than vanilla)
> 
> 
> As expected, vanilla kicked RT's butt when hammering on the 
> mmap_sem. But somewhat unexpectedly, your fixups helped quite a
> bit and the multi+fixups got RT back into being almost
> respectable.
> 
> Obviously these are just preliminary results on one piece of h/w
> but it looks promising.

Is it easy to look at the latency when you have multiple readers and
and a high prio writer which has to boost all those readers away
instead just one?
Or is this something that should not happen for a high prio RT task
because it has all memory already allocated?

> 
> Clark

Sebastian
