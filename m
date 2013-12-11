From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/5] cpu_down: move migrate_enable() back
Date: Tue, 10 Dec 2013 19:50:47 -0500
Message-ID: <20131211005058.276003329@goodmis.org>
References: <20131211005046.115564491@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Tiejun Chen <tiejun.chen@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-cpu_down-move-migrate_enable-back.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.4.72-rt90-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tiejun Chen <tiejun.chen@windriver.com>

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

Cc: stable-rt@vger.kernel.org
Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c18c25e..4e3b7c5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -545,6 +545,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 		err = -EBUSY;
 		goto restore_cpus;
 	}
+	migrate_enable();
 
 	cpu_hotplug_begin();
 	err = cpu_unplug_begin(cpu);
@@ -597,7 +598,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 out_release:
 	cpu_unplug_done(cpu);
 out_cancel:
-	migrate_enable();
 	cpu_hotplug_done();
 	if (!err)
 		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
-- 
1.8.4.3
