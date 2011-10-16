From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH -rt 1/5] hotplug: sync_unplug: No '\n' in task name
Date: Sun, 16 Oct 2011 18:56:43 +0800
Message-ID: <1318762607-2261-2-git-send-email-yong.zhang0@gmail.com>
References: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com>
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Otherwise the output will look a little odd.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 kernel/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5f2382a..83fb084 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -139,7 +139,7 @@ static int cpu_unplug_begin(unsigned int cpu)
 	struct task_struct *tsk;
 
 	init_completion(&hp->synced);
-	tsk = kthread_create(sync_unplug_thread, hp, "sync_unplug/%d\n", cpu);
+	tsk = kthread_create(sync_unplug_thread, hp, "sync_unplug/%d", cpu);
 	if (IS_ERR(tsk))
 		return (PTR_ERR(tsk));
 	kthread_bind(tsk, cpu);
-- 
1.7.1
