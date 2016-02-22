From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/4] Tracepoints for deadline scheduler
Date: Mon, 22 Feb 2016 14:08:18 -0300
Message-ID: <cover.1456157869.git.bristot@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49895 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcBVRJL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2016 12:09:11 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Deadline tasks behave differently of other tasks because deadline
task's also depend on their period, deadline and runtime.

Hence, the well known sched:sched_wakeup and sched:sched_switch
tracepoints are not always enough to precisely explain the behavior of a
deadline task with respect to the task's period, deadline and runtime
consumption.

This patch series implements tracepoints for the following deadline
scheduler points of interest:

- sched:sched_deadline_replenish: Informs the periodic runtime
replenishment of a deadline task.

- sched:sched_deadline_yield: Informs that a deadline task called
sched_yield(), and will wait for the next period.

- sched:sched_deadline_throttle: Informs that a task consumed all its
available runtime and was throttled.

- sched:sched_deadline_block: Informs that a deadline task went to sleep
waiting to be awakened by another task.

Daniel Bristot de Oliveira (3):
  sched: Move deadline container_of() helper functions into sched.h
  sched/deadline: Tracepoints for deadline scheduler
  tools lib traceevent: Implements '%' operation

Steven Rostedt (Red Hat) (1):
  tracing: Add __print_ns_to_secs() and __print_ns_without_secs()
    helpers

 include/trace/events/sched.h       | 87 ++++++++++++++++++++++++++++++++++++++
 include/trace/trace_events.h       | 25 +++++++++++
 kernel/sched/deadline.c            | 34 +++++++--------
 kernel/sched/sched.h               | 18 ++++++++
 tools/lib/traceevent/event-parse.c |  4 ++
 5 files changed, 149 insertions(+), 19 deletions(-)

-- 
2.5.0

