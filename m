From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.4.6-rt14
Date: Fri, 8 Apr 2016 16:49:14 +0200
Message-ID: <20160408144914.GA31028@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52042 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbcDHOtQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2016 10:49:16 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[ANNOUNCE] 4.4.6-rt14

Dear RT folks!

I'm pleased to announce the v4.4.6-rt14 patch set.
Changes since v4.4.6-rt13:

- Dan Murphy reported that zram does not compile on !RT. Now it does.

- The TWD timer is now enabled on IMX6Q configs even with !SMP.
  People with i.MX6SOLO should now see better cyclictest results with
  TWD than with the mxc-timer.

Known issues:
  - CPU hotplug got a little better but can deadlock.

The delta patch against 4.4.6-rt13 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.6-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.6-rt14

The RT patch against 4.4.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.6-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.6-rt14.tar.xz

Sebastian

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8ceda2844c4f..08bcf8fb76f2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -524,7 +524,7 @@ config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_TWD
 	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 1e4a3c685ec7..9e3e953d680e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -134,7 +134,7 @@ static inline void zram_unlock_table(struct zram_table_entry *table)
 	bit_spin_unlock(ZRAM_ACCESS, &table->value);
 }
 
-static inline void zram_meta_init_locks(struct zram_meta *meta, u64 disksize) { }
+static inline void zram_meta_init_table_locks(struct zram_meta *meta, u64 disksize) { }
 #else /* CONFIG_PREEMPT_RT_BASE */
 static inline void zram_lock_table(struct zram_table_entry *table)
 {
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb1..08b3e75841ad 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
