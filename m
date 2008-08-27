From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] Series short description
Date: Wed, 27 Aug 2008 10:33:24 +0200
Message-ID: <1219826004.6462.57.camel@twins>
References: <20080825200852.23217.13842.stgit@dev.haskins.net>
	 <20080826173131.16413.17862.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, srostedt@redhat.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, npiggin@suse.de,
	gregory.haskins@gmail.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:58037 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbYH0Ido (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Aug 2008 04:33:44 -0400
In-Reply-To: <20080826173131.16413.17862.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2008-08-26 at 13:34 -0400, Gregory Haskins wrote:
> Hi Ingo,
> 
> The following repositories
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/linux-2.6-hacks.git tip/sched/devel/rtbalance 
> 
>      ftp://ftp.novell.com/dev/ghaskins/tip-rt-fixes.tar.bz2
> 
> apply to tip/sched/devel to pick up fixes for the RT scheduler. 
> 
> [
> 	Changelog:
> 	
> 	v2: 
> 	    *) predicated newidle and double_lock changes on
> 	       CONFIG_PREEMPT to address a concern by Nick Piggin
> 
> 	    *) fixed a build issue when DEBUG_PI_LIST is defined 
> 
> 	v1:
> 	    *) initial release
> ]
> 
> These patches were developed in the interest of shorting latencies in
> PREEMPT_RT, but they apply to the mainline scheduler as well, so I am
> offering them here first.
> 
> This has been tested under both 26.3-rt3 and tip/sched/devel on x86_64 for
> both CONFIG_SMP and !CONFIG_SMP.
> 
> Comments/bug-fixes welcome!

Looks good to me,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Ingo please consider.

> ---
> 
> Gregory Haskins (6):
>       sched: create "pushable_tasks" list to limit pushing to one attempt
>       plist: fix PLIST_NODE_INIT to work with debug enabled
>       sched: add sched_class->needs_post_schedule() member
>       sched: make double-lock-balance fair
>       sched: pull only one task during NEWIDLE balancing to limit critical section
>       sched: only try to push a task on wakeup if it is migratable
> 
> 
>  include/linux/init_task.h |    1 
>  include/linux/plist.h     |    9 ++-
>  include/linux/sched.h     |    2 +
>  kernel/sched.c            |   84 ++++++++++++++++++++++++---
>  kernel/sched_rt.c         |  139 ++++++++++++++++++++++++++++++++++++++-------
>  5 files changed, 202 insertions(+), 33 deletions(-)
> 
> 

