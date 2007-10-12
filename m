From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/7] RT: (RFC) RT-Overload/Sched enhancements
Date: Fri, 12 Oct 2007 12:29:45 +0200
Message-ID: <1192184985.27435.17.camel@twins>
References: <20071011213916.27097.42597.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:32799 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbXJLK3w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 06:29:52 -0400
In-Reply-To: <20071011213916.27097.42597.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Gregory,

On Thu, 2007-10-11 at 17:59 -0400, Gregory Haskins wrote:
> The current series applies to 23-rt1-pre1.
> 
> This is a snapshot of the current work-in-progress for the rt-overload
> enhancements.  The primary motivation for the series to to improve the
> algorithm for distributing RT tasks to keep the highest tasks active.  The
> current system tends to blast IPIs "shotgun" style, and we aim to reduce that
> overhead where possible.  We mitigate this behavior by trying to place tasks
> on the ideal runqueue before an overload even occurs.
> 
> Note that this series is *not* currently stable.  There is at
> least one bug resulting in a hard-lock.  And the hard-lock could be masking
> other yet-to-be-discovered issues.
> 
> My primary motivation for sending it out right now is to share the latest
> series with Peter Zijlstra and Steven Rostedt.  However, in the interest of
> keeping the development open we are sending to a wider distribution.
> Comments/suggestions from anyone are, of course, welcome.  But please note
> this is not quite ready for prime-time in any capacity. 
> 
> The series includes patches from both Steven and myself, with serious
> input/guidance/discussion from Peter.

I'm wondering why we need the cpu prio management stuff. I'm thinking we
might just use any cpus_allowed cpu that has a lesser priority than the
task we're trying to migrate.

And for that, steve's rq->curr_prio field seems quite suitable.

so instead of the:
  for (3 tries)
    find lowest cpu
    try push

we do:

  cpu_hotplug_lock();
  cpus_and(mask, p->cpus_allowed, online_cpus);
  for_each_cpu_mask(i, mask) {
    if (cpu_rq(i)->curr_prio > p->prio && push_task(p, i))
      break;
  }
  cpu_hotplug_unlock();
