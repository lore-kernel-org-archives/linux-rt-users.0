From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] Compile error with allmodconfig and CONFIG_PREEMPT_RT_FULL=y
Date: Mon, 14 Nov 2011 02:44:43 +0100
Message-ID: <1321235083-21756-2-git-send-email-jkacur@redhat.com>
References: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

ERROR: "in_serving_softirq" [net/sched/cls_cgroup.ko] undefined!

The above can be fixed by exporting in_serving_softirq

Signed-off-by: John Kacur <jkacur@redhat.com>

The above patch was originally for 3.0.9-rt25
But I also needed to cherry-pick it for 3.2-rc1-rt1
---
 kernel/softirq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 3db1d6f..5452432 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -447,6 +447,7 @@ int in_serving_softirq(void)
 	preempt_enable();
 	return res;
 }
+EXPORT_SYMBOL(in_serving_softirq);
 
 /*
  * Called with bh and local interrupts disabled. For full RT cpu must
-- 
1.7.2.3
