From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: fix cpupri hotplug support
Date: Wed, 04 Jun 2008 16:42:28 +0200
Message-ID: <1212590548.23439.17.camel@twins>
References: <20080604032200.4821.87502.stgit@novell1.haskins.net>
	 <1212580796.23439.10.camel@twins>  <48466E65.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46682 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbYFDOnv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Jun 2008 10:43:51 -0400
In-Reply-To: <48466E65.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2008-06-04 at 08:28 -0600, Gregory Haskins wrote:

> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index bb71371..9c5b8c9 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -970,6 +970,8 @@ struct sched_class {
> >>  
> >>  	void (*join_domain)(struct rq *rq);
> >>  	void (*leave_domain)(struct rq *rq);
> >> +	void (*online)(struct rq *rq);
> >> +	void (*offline)(struct rq *rq);
> > 
> > Rather unfortunate to add yet another two callbacks, can't this be done
> > with a creative use of leave/join?
> 
> Yeah, I was debating how to do this.  In fact, as you can see the
> implementation of join/online and leave/offline is identical.  I wasnt
> sure if putting a join/leave in the hotplug code made sense, so I
> added a new callback that maps to the same logic.  Perhaps what I
> should have done was to s/join/online and s/leave/offline and fixed
> the root-domain code to use the online/offline variant.  I like this
> better so I will put out a v2 patch in a few minutes.
> 

> I think you are misinterpreting that part.  leave/join is fully
> functional and intact.  I just merged the two implementations to call
> one function (see the sched_class assignment below)
> 
> > 
> >> @@ -1278,8 +1284,10 @@ const struct sched_class rt_sched_class = {
> >>  	.load_balance		= load_balance_rt,
> >>  	.move_one_task		= move_one_task_rt,
> >>  	.set_cpus_allowed       = set_cpus_allowed_rt,
> >> -	.join_domain            = join_domain_rt,
> >> -	.leave_domain           = leave_domain_rt,
> >> +	.join_domain            = rq_online_rt,
> >> +	.leave_domain           = rq_offline_rt,
> >> +	.online                 = rq_online_rt,
> >> +	.offline                = rq_offline_rt,
> >>  	.pre_schedule		= pre_schedule_rt,
> >>  	.post_schedule		= post_schedule_rt,
> >>  	.task_wake_up		= task_wake_up_rt,

Ah, right - I missed that.

Right - I was just looking to get the cpu-down path to do one ->leave()
extra (aside from leave/join the def_root_domain) so it's basically
unattached - which makes sense for a downed cpu.

Conversely the cpu-up should start with an extra ->join() attaching the
downed cpu again.

I'm thinking doing it that way saves us the extra callbacks. We can do
those if and when the leave/offline behaviour actually divert.


