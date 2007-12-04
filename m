From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 20/23] Subject: SCHED - balance RT tasks no new wake up
Date: Tue, 04 Dec 2007 15:46:07 -0500
Message-ID: <20071204204606.3567.49460.stgit@novell1.haskins.net>
References: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, ghaskins@novell.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53506
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754928AbXLDVIH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 16:08:07 -0500
In-Reply-To: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Steven Rostedt <srostedt@redhat.com>

Run the RT balancing code on wake up to an RT task.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index ed031bd..ba9eadb 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1656,6 +1656,7 @@ void fastcall wake_up_new_task(struct task_struct *p, unsigned long clone_flags)
 		inc_nr_running(p, rq);
 	}
 	check_preempt_curr(rq, p);
+	wakeup_balance_rt(rq, p);
 	task_rq_unlock(rq, &flags);
 }
 
