From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/6] x86/apic: get rid of "warning: acpi_ioapic_lock defined but not
 used"
Date: Sun, 30 Oct 2016 12:45:11 -0400
Message-ID: <20161030164519.682263781@goodmis.org>
References: <20161030164507.542995196@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-x86-apic-get-rid-of-warning-acpi_ioapic_lock-defined.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.27-rt38-rc1 stable review patch.
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
index e75907601a41..a29fc4f84fc4 100644
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
