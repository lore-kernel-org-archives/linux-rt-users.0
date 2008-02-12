From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 2/2] fix cpus_allowed settings
Date: Tue, 12 Feb 2008 13:30:05 -0500
Message-ID: <20080212183005.10902.94549.stgit@novell1.haskins.net>
References: <20080212182512.10902.66459.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com
To: rostedt@goodmis.org, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:36105
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751030AbYBLTT5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2008 14:19:57 -0500
In-Reply-To: <20080212182512.10902.66459.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/kthread.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index dcfe724..b193b47 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -170,6 +170,7 @@ void kthread_bind(struct task_struct *k, unsigned int cpu)
 	wait_task_inactive(k);
 	set_task_cpu(k, cpu);
 	k->cpus_allowed = cpumask_of_cpu(cpu);
+	k->nr_cpus_allowed = 1;
 }
 EXPORT_SYMBOL(kthread_bind);
 
