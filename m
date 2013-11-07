From: Tiejun Chen <tiejun.chen@windriver.com>
Subject: [v1][PATCH] cpu_down: move migrate_enable() back
Date: Thu, 7 Nov 2013 10:06:07 +0800
Message-ID: <1383789967-5885-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <stable-rt@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:38238 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3KGCHI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 21:07:08 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit 08c1ab68, "hotplug-use-migrate-disable.patch", intends to
use migrate_enable()/migrate_disable() to replace that combination
of preempt_enable() and preempt_disable(), but actually in
!CONFIG_PREEMPT_RT_FULL case, migrate_enable()/migrate_disable()
are still equal to preempt_enable()/preempt_disable(). So that
followed cpu_hotplug_begin()/cpu_unplug_begin(cpu) would go schedule()
to trigger schedule_debug() like this:

_cpu_down()
	|
	+ migrate_disable() = preempt_disable()
	|
	+ cpu_hotplug_begin() or cpu_unplug_begin()
		|
		+ schedule()
			|
			+ __schedule()
				|
				+ preempt_disable();
				|
				+ __schedule_bug() is true!

So we should move migrate_enable() as the original scheme.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 kernel/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 98f2ea3..da6e128 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -594,6 +594,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 		err = -EBUSY;
 		goto restore_cpus;
 	}
+	migrate_enable();
 
 	cpu_hotplug_begin();
 	err = cpu_unplug_begin(cpu);
@@ -647,7 +648,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 out_release:
 	cpu_unplug_done(cpu);
 out_cancel:
-	migrate_enable();
 	cpu_hotplug_done();
 	if (!err)
 		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
-- 
1.7.9.5

