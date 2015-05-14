From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/5] hotplug: Use set_cpus_allowed_ptr() in sync_unplug_thread()
Date: Thu, 14 May 2015 10:01:41 -0400
Message-ID: <20150514140146.950946969@goodmis.org>
References: <20150514140137.396749660@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-hotplug-Use-set_cpus_allowed_ptr-in-sync_unplug_thre.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.40-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

do_set_cpus_allowed() is not safe vs ->sched_class change.

crash> bt
PID: 11676  TASK: ffff88026f979da0  CPU: 22  COMMAND: "sync_unplug/22"
 #0 [ffff880274d25bc8] machine_kexec at ffffffff8103b41c
 #1 [ffff880274d25c18] crash_kexec at ffffffff810d881a
 #2 [ffff880274d25cd8] oops_end at ffffffff81525818
 #3 [ffff880274d25cf8] do_invalid_op at ffffffff81003096
 #4 [ffff880274d25d90] invalid_op at ffffffff8152d3de
    [exception RIP: set_cpus_allowed_rt+18]
    RIP: ffffffff8109e012  RSP: ffff880274d25e48  RFLAGS: 00010202
    RAX: ffffffff8109e000  RBX: ffff88026f979da0  RCX: ffff8802770cb6e8
    RDX: 0000000000000000  RSI: ffffffff81add700  RDI: ffff88026f979da0
    RBP: ffff880274d25e78   R8: ffffffff816112e0   R9: 0000000000000001
    R10: 0000000000000001  R11: 0000000000011940  R12: ffff88026f979da0
    R13: ffff8802770cb6d0  R14: ffff880274d25fd8  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffff880274d25e60] do_set_cpus_allowed at ffffffff8108e65f
 #6 [ffff880274d25e80] sync_unplug_thread at ffffffff81058c08
 #7 [ffff880274d25ed8] kthread at ffffffff8107cad6
 #8 [ffff880274d25f50] ret_from_fork at ffffffff8152bbbc
crash> task_struct ffff88026f979da0 | grep class
  sched_class = 0xffffffff816111e0 <fair_sched_class+64>,

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6d2cab15a585..3566e74fae83 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -242,7 +242,7 @@ static int sync_unplug_thread(void *data)
 	 * we don't want any more work on this CPU.
 	 */
 	current->flags &= ~PF_NO_SETAFFINITY;
-	do_set_cpus_allowed(current, cpu_present_mask);
+	set_cpus_allowed_ptr(current, cpu_present_mask);
 	migrate_me();
 	return 0;
 }
-- 
2.1.4
