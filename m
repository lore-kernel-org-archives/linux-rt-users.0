From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/6] RCU: Preemptible-RCU
Date: Thu, 13 Dec 2007 21:42:19 +0100
Message-ID: <20071213204219.GF25130@elte.hu>
References: <20071213170348.GA25981@in.ibm.com> <Pine.LNX.4.58.0712131230220.3369@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Paul E McKenney <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932884AbXLMUnx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0712131230220.3369@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 13 Dec 2007, Gautham R Shenoy wrote:
> 
> >
> > Currently it is based against the latest linux-2.6-sched-devel.git
> >
> > Awaiting your feedback!
> 
> Hi Gautham,
> 
> Thanks for posting this. I believe this is the same version of preempt 
> RCU as we have in the RT patch. It seems to be very stable. I ran the 
> RT patch version of the RCU Preempt (just the Preempt RCU patches 
> without RT on latest git) on a 64way box and the results seems just as 
> good (if not slightly better) than classic RCU!  I'll rerun this patch 
> series on that box and post the results.
> 
> >From what I'm seening with this, is that it is ready for mainline. 
> >These
> patches should probably go into -mm and be ready for 2.6.25.  If Andrew
> wants to wait for my results, I'll run them tonight.
> 
> Thanks Gautham, Paul and Dipankar for all this great work!

Steve, if you went with a fine comb over the code and have done a 
thorough review, could you send me your Reviewed-by line for this 
patchset?

	Ingo
