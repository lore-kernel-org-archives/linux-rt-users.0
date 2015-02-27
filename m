From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 2/2] mce: don't try to wake thread before it exists.
Date: Fri, 27 Feb 2015 15:20:38 +0100
Message-ID: <1425046838-4868-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:53475 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753430AbbB0OUs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Feb 2015 09:20:48 -0500
In-Reply-To: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Paul Gortmaker <paul.gortmaker@windriver.com>

If a broken machine with issues raises an MCE irq event real
early in the boot, it can try and wake the -rt specific handler
thread (mce_notify_helper) before it exists.  (It is created
through a device_initcall that happens later in the boot.)  When
this happens, we see the irq, which calls the wake with a null
pointer, which then panics the machine at boot.

The race between the irq event and thread init is as follows:

mce_notify_irq();
  --> mce_notify_work();
        --> wake_up_process(mce_notify_helper);

device_initcall_sync(mcheck_init_device);
  --> mce_notify_work_init();
        --> mce_notify_helper = kthread_run(mce_notify_helper_thread, ...);

So, clearly if the IRQ event happens before the device_initcall,
the mce_notify_helper pointer (at global file scope and hence BSS)
will still be NULL, resulting in the following panic at boot:

  CPU: Physical Processor ID: 0
  CPU: Processor Core ID: 0
  ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
  ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
  mce: CPU supports 22 MCE banks
  CPU0: Thermal monitoring enabled (TM1)
  Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
  Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0
  tlb_flushall_shift: 6
  Freeing SMP alternatives: 36k freed
  ACPI: Core revision 20130328
  BUG: unable to handle kernel NULL pointer dereference at           (null)
  IP: [<ffffffff8107730d>] wake_up_process+0xd/0x40
  PGD 0
  Oops: 0000 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.40-rt40_preempt-rt #1
  Hardware name: Insyde Grantley/Type2 - Board Product Name1, BIOS 05.04.07 04/21/2014
  task: ffffffff81e14440 ti: ffffffff81e00000 task.ti: ffffffff81e00000
  RIP: 0010:[<ffffffff8107730d>]  [<ffffffff8107730d>] wake_up_process+0xd/0x40
  RSP: 0000:ffff88107fc03f68  EFLAGS: 00010086
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000007ffefbff
  RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffff88107fc03f70 R08: 0000000000000002 R09: 0000000000000003
  R10: 0000000000000000 R11: 0000000000000001 R12: ffff88103f03d100
  R13: ffff880ff4e0c000 R14: ffff88107fc16f00 R15: ffff880ff4e0c000
  FS:  0000000000000000(0000) GS:ffff88107fc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000000001e0f000 CR4: 00000000001406f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000

  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Stack:
   ffff88107fc0ccf0 ffff88107fc03f80 ffffffff8101f900 ffff88107fc03f98
   ffffffff8102169d ffff88107fc0fab0 ffff88107fc03fa8 ffffffff81022051
   ffffffff81e01d48 ffffffff819a8a9a ffffffff81e01bf8 <EOI>  ffffffff81e01d48
  Call Trace:
   <IRQ>
   [<ffffffff8101f900>] mce_notify_irq+0x30/0x40
   [<ffffffff8102169d>] intel_threshold_interrupt+0xbd/0xe0
   [<ffffffff81022051>] smp_threshold_interrupt+0x21/0x40
   [<ffffffff819a8a9a>] threshold_interrupt+0x6a/0x70
   <EOI>
   [<ffffffff8199c57c>] ? __slab_alloc.isra.48+0x39e/0x60c
   [<ffffffff814369d5>] ? acpi_ps_alloc_op+0x9a/0xa1
   [<ffffffff811534a8>] ? kmem_cache_free+0xb8/0x2b0
   [<ffffffff81152be4>] kmem_cache_alloc+0x234/0x2e0
   [<ffffffff814369d5>] ? acpi_ps_alloc_op+0x9a/0xa1
   [<ffffffff814369d5>] acpi_ps_alloc_op+0x9a/0xa1
   [<ffffffff8143523f>] acpi_ps_get_next_arg+0xfe/0x3d3
   [<ffffffff814357a4>] acpi_ps_parse_loop+0x290/0x560
   [<ffffffff814364bc>] acpi_ps_parse_aml+0x98/0x28c
   [<ffffffff8143242c>] acpi_ns_one_complete_parse+0x104/0x124
   [<ffffffff8143247f>] acpi_ns_parse_table+0x33/0x38
   [<ffffffff81431e56>] acpi_ns_load_table+0x4a/0x8c
   [<ffffffff81439d6e>] acpi_load_tables+0xa2/0x176
   [<ffffffff81f4dbf3>] acpi_early_init+0x70/0x100
   [<ffffffff81f1c4e9>] ? check_bugs+0xe/0x2d
   [<ffffffff81f14df2>] start_kernel+0x387/0x3b5
   [<ffffffff81f14874>] ? repair_env_string+0x5c/0x5c
   [<ffffffff81f145ad>] x86_64_start_reservations+0x2a/0x2c
   [<ffffffff81f1467b>] x86_64_start_kernel+0xcc/0xcf
  Code: 8b 52 18 e9 9e fc ff ff 48 89 45 c0 e8 cd df 92 00 48 8b 45 c0 eb e5 0f 1f 80 00 00 00 00 e8 fb 04 93 00 55 48 89 e5 53 48 89 fb <48> 8b 07 a8 0c 75 12 48 89 df 31 d2 be 03 00 00 00 e8 ad fb ff
  RIP  [<ffffffff8107730d>] wake_up_process+0xd/0x40
   RSP <ffff88107fc03f68>
  CR2: 0000000000000000
  ---[ end trace 0000000000000001 ]---
  Kernel panic - not syncing: Fatal exception in interrupt

Evidently the hardware has issues, but we can handle this more
gracefully by ignoring the events that happen before the
device_initcall has registered the mce handler thread.

We use WARN_ON_ONCE to ensure it is still noticed, and also to
implicitly ratelimit it, in case the race window is wide enough
to spam the console with too many instances of the warning.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[wagi: Replaced WARN_ON_ONCE with a 'creative' defer logic]
Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 77afc3f..c7f35ae 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1385,7 +1385,17 @@ static void __mce_notify_work(struct swork_event *event)
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * mce_notify_work_init() can race with mce_notify_irq() on bootup. To
+ * avoid lossing events, let's define a simple state machine which defers
+ * the notifaction when mce_notify_work_init() is not finished yet.
+ */
+#define NOTIFY_WORK_INIT	0
+#define NOTIFY_WORK_DEFER	1
+#define NOTIFY_WORK_READY	2
+
 static struct swork_event notify_work;
+static atomic_t notify_work_state = ATOMIC_INIT(NOTIFY_WORK_INIT);
 
 static int mce_notify_work_init(void)
 {
@@ -1396,12 +1406,35 @@ static int mce_notify_work_init(void)
 		return err;
 
 	INIT_SWORK(&notify_work, __mce_notify_work);
+
+	if (atomic_cmpxchg(&notify_work_state,
+				NOTIFY_WORK_DEFER,
+				NOTIFY_WORK_READY) == NOTIFY_WORK_DEFER)
+		swork_queue(&notify_work);
+
 	return 0;
 }
 
 static void mce_notify_work(void)
 {
-	swork_queue(&notify_work);
+	if (atomic_read(&notify_work_state) == NOTIFY_WORK_READY) {
+		swork_queue(&notify_work);
+		return;
+	}
+
+	/*
+	 * Because we race with mce_notify_work_init() we are either
+	 * in INIT or READY state at this point.
+	 *
+	 * Defer the work by changing to DEFER state and let
+	 * mce_notify_work_init() handle the event. In case the we
+	 * reached READY state in the meantime, just place the work
+	 * item into the queue.
+	 */
+	if (atomic_cmpxchg(&notify_work_state,
+				NOTIFY_WORK_INIT,
+				NOTIFY_WORK_DEFER) == NOTIFY_WORK_READY)
+		swork_queue(&notify_work);
 }
 #else
 static void mce_notify_work(void)
-- 
2.1.0

