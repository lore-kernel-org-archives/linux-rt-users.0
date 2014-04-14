From: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Subject: [RFC v0] thermal: Protect schedule flag by raw spin
Date: Mon, 14 Apr 2014 16:22:27 +0200
Message-ID: <1397485347-2235-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52174 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751023AbaDNObH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Apr 2014 10:31:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

pkg_work_lock is used to serialize the access to pkg_work_scheduled.
pkg_temp_thermal_device_add() reallocates pkg_work_scheduled when
CPUs are added (When they are removed, pkg_work_scheduled wont
be updated). Since pkg_work_scheduled accessed from the interrupt
context spin_lock_irqsave() is the right thing on mainline to use.

On RT the spin lock is a mutex and therefore we should not sleep
in the irq context:

[<ffffffff816850ac>] dump_stack+0x4e/0x8f
[<ffffffff81680f7d>] __schedule_bug+0xa6/0xb4
[<ffffffff816896b4>] __schedule+0x5b4/0x700
[<ffffffff8168982a>] schedule+0x2a/0x90
[<ffffffff8168a8b5>] rt_spin_lock_slowlock+0xe5/0x2d0
[<ffffffff8168afd5>] rt_spin_lock+0x25/0x30
[<ffffffffa03a7b75>] pkg_temp_thermal_platform_thermal_notify+0x45/0x134 [x86_pkg_temp_thermal]
[<ffffffff8103d4db>] ? therm_throt_process+0x1b/0x160
[<ffffffff8103d831>] intel_thermal_interrupt+0x211/0x250
[<ffffffff8103d8c1>] smp_thermal_interrupt+0x21/0x40
[<ffffffff8169415d>] thermal_interrupt+0x6d/0x80

Again, this is a bug on mainline.

I didn't find a good way to get rid of the krealloc in
pkg_temp_thermal_device_add(). Instead using krealloc I dropped
to an open coded version so that the alloc is outside of
raw_spin_lock_irqsave().

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---

Hi,

I tested the IRQ handler part but I was not able yet to test the
CPU part. I guess this could be tested via qemu just need to figure
out how it works.

Anyway I tried to get git of pkg_work_scheduled but I have not found
an obvious way to do it. I am open to any suggested.

cheers,
daniel

 drivers/thermal/x86_pkg_temp_thermal.c | 49 ++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 7257366..7d0b0ac 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -83,7 +83,7 @@ static DEFINE_PER_CPU(struct delayed_work, pkg_temp_thermal_threshold_work);
 static u8 *pkg_work_scheduled;
 
 /* Spin lock to prevent races with pkg_work_scheduled */
-static spinlock_t pkg_work_lock;
+static DEFINE_RAW_SPINLOCK(pkg_work_lock);
 static u16 max_phy_id;
 
 /* Debug counters to show using debugfs */
@@ -325,14 +325,14 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	if (!phdev)
 		return;
 
-	spin_lock_irqsave(&pkg_work_lock, flags);
+	raw_spin_lock_irqsave(&pkg_work_lock, flags);
 	++pkg_work_cnt;
 	if (unlikely(phy_id > max_phy_id)) {
-		spin_unlock_irqrestore(&pkg_work_lock, flags);
+		raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
 		return;
 	}
 	pkg_work_scheduled[phy_id] = 0;
-	spin_unlock_irqrestore(&pkg_work_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	enable_pkg_thres_interrupt();
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
@@ -363,16 +363,16 @@ static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
 	* are in the same interrupt state. So scheduling on any one CPU in
 	* the package is enough and simply return for others.
 	*/
-	spin_lock_irqsave(&pkg_work_lock, flags);
+	raw_spin_lock_irqsave(&pkg_work_lock, flags);
 	++pkg_interrupt_cnt;
 	if (unlikely(phy_id > max_phy_id) || unlikely(!pkg_work_scheduled) ||
 			pkg_work_scheduled[phy_id]) {
 		disable_pkg_thres_interrupt();
-		spin_unlock_irqrestore(&pkg_work_lock, flags);
+		raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
 		return -EINVAL;
 	}
 	pkg_work_scheduled[phy_id] = 1;
-	spin_unlock_irqrestore(&pkg_work_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	disable_pkg_thres_interrupt();
 	schedule_delayed_work_on(cpu,
@@ -401,7 +401,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	char buffer[30];
 	int thres_count;
 	u32 eax, ebx, ecx, edx;
-	u8 *temp;
+	u8 *temp, *p;
 	unsigned long flags;
 
 	cpuid(6, &eax, &ebx, &ecx, &edx);
@@ -426,19 +426,28 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 		goto err_ret_unlock;
 	}
 
-	spin_lock_irqsave(&pkg_work_lock, flags);
-	if (topology_physical_package_id(cpu) > max_phy_id)
+	if (topology_physical_package_id(cpu) > max_phy_id) {
 		max_phy_id = topology_physical_package_id(cpu);
-	temp = krealloc(pkg_work_scheduled,
-			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
-	if (!temp) {
-		spin_unlock_irqrestore(&pkg_work_lock, flags);
-		err = -ENOMEM;
-		goto err_ret_free;
+
+		temp = kmalloc((max_phy_id+1) * sizeof(u8), GFP_KERNEL);
+		if (!temp) {
+			err = -ENOMEM;
+			goto err_ret_free;
+		}
+
+		raw_spin_lock_irqsave(&pkg_work_lock, flags);
+
+		p = pkg_work_scheduled;
+
+		memcpy(temp, pkg_work_scheduled, ksize(pkg_work_scheduled));
+		pkg_work_scheduled = temp;
+
+		pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
+
+		raw_spin_unlock_irqrestore(&pkg_work_lock, flags);
+
+		kfree(p);
 	}
-	pkg_work_scheduled = temp;
-	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
-	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
 	phy_dev_entry->phys_proc_id = topology_physical_package_id(cpu);
 	phy_dev_entry->first_cpu = cpu;
@@ -587,7 +596,7 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	spin_lock_init(&pkg_work_lock);
+	raw_spin_lock_init(&pkg_work_lock);
 	platform_thermal_package_notify =
 			pkg_temp_thermal_platform_thermal_notify;
 	platform_thermal_package_rate_control =
-- 
1.9.0

