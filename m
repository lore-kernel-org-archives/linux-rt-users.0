From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/5] x86/apic: get rid of "warning: acpi_ioapic_lock defined but not
 used"
Date: Sun, 30 Oct 2016 12:46:38 -0400
Message-ID: <20161030164647.495924996@goodmis.org>
References: <20161030164635.444929710@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kbuild test robot <fengguang.wu@intel.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933313AbcJ3Qqw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Oct 2016 12:46:52 -0400
Content-Disposition: inline; filename=0003-x86-apic-get-rid-of-warning-acpi_ioapic_lock-defined.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.35-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

kbuild test robot reported this against the -RT tree:

|   In file included from include/linux/mutex.h:30:0,
|                    from include/linux/notifier.h:13,
|                    from include/linux/memory_hotplug.h:6,
|                    from include/linux/mmzone.h:777,
|                    from include/linux/gfp.h:5,
|                    from include/linux/slab.h:14,
|                    from include/linux/resource_ext.h:19,
|                    from include/linux/acpi.h:26,
|                    from arch/x86/kernel/acpi/boot.c:27:
|>> arch/x86/kernel/acpi/boot.c:90:21: warning: 'acpi_ioapic_lock' defined but not used [-Wunused-variable]
|    static DEFINE_MUTEX(acpi_ioapic_lock);
|                        ^
|   include/linux/mutex_rt.h:27:15: note: in definition of macro 'DEFINE_MUTEX'
|     struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
                  ^~~~~~~~~
which is also true (as in non-used) for !RT but the compiler does not
emit a warning.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/acpi/boot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 07bea80223f6..cb66b0ea2d68 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -87,7 +87,9 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
  *		->ioapic_mutex
  *			->ioapic_lock
  */
+#ifdef CONFIG_X86_IO_APIC
 static DEFINE_MUTEX(acpi_ioapic_lock);
+#endif
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
-- 
2.9.3


