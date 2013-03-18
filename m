From: Tejun Heo <tj@kernel.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 09:46:10 -0700
Message-ID: <20130318164610.GB21516@mtj.dyndns.org>
References: <1363617383.25967.152.camel@gandalf.local.home>
 <20130318160652.GA20133@mtj.dyndns.org>
 <1363623799.25967.172.camel@gandalf.local.home>
 <20130318162718.GB20133@mtj.dyndns.org>
 <1363624883.25967.184.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363624883.25967.184.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 18, 2013 at 12:41:23PM -0400, Steven Rostedt wrote:
> But, I'm worried about the loops that are done while holding this lock.
> Just looking at is_chained_work() that does for_each_busy_worker(), how
> big can that list be? If it's bound by # of CPUs then that may be fine,
> but if it can be as big as the # of workers assigned, with no real
> limit, then its not fine, because that creates an unbound (non
> deterministic) latency.

In most paths, gcwq->lock shouldn't be held for too long but yes there
are cold paths which just do things without thinking about latency
issues.  is_chained_work() can definitely take pretty long time (note
that it got reimplemented in the current devel branch and the loop is
gone).

-- 
tejun
