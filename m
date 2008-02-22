From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH [RT] 08/14] add a loop counter based timeout mechanism
Date: Fri, 22 Feb 2008 11:19:48 -0800
Message-ID: <9810cff90802221119j23818e74g2721512a693a0a01@mail.gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221152707.4804.59177.stgit@novell1.haskins.net>
	 <200802211741.10299.ak@suse.de>
	 <20080222190814.GD11213@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andi Kleen" <ak@suse.de>, "Gregory Haskins" <ghaskins@novell.com>,
	mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kevin@hilman.org,
	cminyard@mvista.com, dsingleton@mvista.com, dwalker@mvista.com,
	npiggin@suse.de, dsaxena@plexity.net, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763666AbYBVTUA@vger.kernel.org>
In-Reply-To: <20080222190814.GD11213@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 22, 2008 at 11:08 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>  One approach would be to set the RTLOCK_DELAY parameter to something like
>  -1 for default, and to set it to the number of cycles required for about
>  10 cache misses at boot time.  This would automatically scale with CPU
>  frequency and memory latency.

Yeah, I'm not very keen on having a constant there without some
contention instrumentation to see how long the spins are. It would be
better to just let it run until either task->on_cpu is off or checking
if the "current" in no longer matches the mutex owner for the runqueue
in question. At that point, you know the thread isn't running.
Spinning on something like that is just a waste of time. It's for that
reason that doing in the spin outside of a preempt critical section
isn't really needed

bill
