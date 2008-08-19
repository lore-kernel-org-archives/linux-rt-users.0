From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH RT 2/2] ftrace: fix elevated preempt_count in wakeup-tracer
Date: Tue, 19 Aug 2008 05:19:23 -0400
Message-ID: <20080819091923.21725.41087.stgit@dev.haskins.net>
References: <20080819091817.21725.81831.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: ghaskins@novell.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-108-43.dhcp.oxfr.ma.charter.com ([75.130.108.43]:44361
	"EHLO dev.haskins.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753543AbYHSJVg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 05:21:36 -0400
In-Reply-To: <20080819091817.21725.81831.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Suggested by Steve Rostedt to fix an observed "+1" in the preempt-count

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/trace/trace_sched_wakeup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index c3a15bd..ae523fd 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -70,7 +70,9 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip)
 	if (task_cpu(wakeup_task) != cpu)
 		goto unlock;
 
+	preempt_enable_no_resched_notrace();
 	trace_function(tr, data, ip, parent_ip, flags);
+	preempt_disable_notrace();
 
  unlock:
 	__raw_spin_unlock(&wakeup_lock);

