From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] RT: scheduler fixes and rt_overload enhancements
Date: Tue, 09 Oct 2007 17:00:29 +0200
Message-ID: <1191942029.6848.15.camel@twins>
References: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
	pmorreale@novell.com, sdietrich@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756146AbXJIPBA@vger.kernel.org>
In-Reply-To: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-10-09 at 10:25 -0400, Gregory Haskins wrote:
> Hi All,
> 
> The first two patches are from Mike and Steven on LKML, which the rest of my
> series is dependent on.  Patch #4 is a resend from earlier.
> 
> Series Summary:
> 
> 1) Send IPI on overload regardless of whether prev is an RT task
> 2) Set the NEEDS_RESCHED flag on reception of RESCHED_IPI
> 3) Fix a mistargeted IPI on overload
> 4) Track which CPUS are in overload for efficiency
> 5) Track which CPUs are eligible for rebalancing for efficiency
> 
> These have been built and boot-tested on a 4-core Intel system.

Ok, I'm not liking these.

I really hate setting TIF_NEED_RESCHED from the IPI handler. Also, I
don't see how doing a resched pulls tasks to begin with.

How about keeping a per rq variable that indicates the highest priority
of runnable tasks. And on forced preemption look for a target rq to send
your last highest task to.

There is no need to broadcast rebalance, that will only serialise on the
local rq lock again. So pick a target rq, and stick with that.

Also, I think you meant to use cpus_and() with the rto and allowed
masks.
