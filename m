From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH V2 0/3] Tracepoints for deadline scheduler
Date: Mon, 28 Mar 2016 13:50:48 -0300
Message-ID: <cover.1459182044.git.bristot@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbcC1QvJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Mar 2016 12:51:09 -0400
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

Changes since v1:
  Cleanup in the sched:sched_deadline_yield tracepoint
  Fix compilantion warning on Intel 32 bits

Daniel Bristot de Oliveira (2):
  sched: Move deadline container_of() helper functions into sched.h
  sched/deadline: Tracepoints for deadline scheduler

Steven Rostedt (Red Hat) (1):
  tracing: Add __print_ns_to_secs() and __print_ns_without_secs()
    helpers

 include/trace/events/sched.h | 88 ++++++++++++++++++++++++++++++++++++++++++++
 include/trace/trace_events.h | 25 +++++++++++++
 kernel/sched/deadline.c      | 26 ++++---------
 kernel/sched/sched.h         | 18 +++++++++
 4 files changed, 139 insertions(+), 18 deletions(-)

-- 
2.5.0

