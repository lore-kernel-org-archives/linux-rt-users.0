From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.1.35-rt41
Date: Tue, 8 Nov 2016 17:59:55 -0500
Message-ID: <20161108175955.313045ab@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:48753 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751427AbcKHW77 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 17:59:59 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 4.1.35-rt41 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.1-rt
  Head SHA1: a19daf348d222168ba92752adf897c657ab597c3


Or to build 4.1.35-rt41 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.35.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.35-rt41.patch.xz



You can also build from 4.1.35-rt40 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.35-rt40-rt41.patch.xz



Enjoy,

-- Steve


Changes from v4.1.35-rt40:

---

Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (3):
      zsmalloc: turn that get_cpu_light() into a local_lock()
      x86/apic: get rid of "warning: 'acpi_ioapic_lock' defined but not used"
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (1):
      Linux 4.1.35-rt41

----
 Makefile                    |  2 +-
 arch/x86/kernel/acpi/boot.c |  2 ++
 kernel/trace/trace.c        | 32 ++++++++++++++++----------------
 localversion-rt             |  2 +-
 mm/zsmalloc.c               |  6 ++++--
 5 files changed, 24 insertions(+), 20 deletions(-)
---------------------------
diff --git a/Makefile b/Makefile
index 21f657f2c4e6..384ef0e05826 100644
--- a/Makefile
+++ b/Makefile
@@ -400,7 +400,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -std=gnu89
 
 KBUILD_AFLAGS_KERNEL :=
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
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index af8b5e5469bf..9c5e5f8e61f5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2562,17 +2562,17 @@ get_total_entries(struct trace_buffer *buf,
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                   _--------=> CPU#              \n"
-		    "#                  / _-------=> irqs-off          \n"
-		    "#                 | / _------=> need-resched      \n"
-		    "#                 || / _-----=> need-resched_lazy \n"
-		    "#                 ||| / _----=> hardirq/softirq   \n"
-		    "#                 |||| / _---=> preempt-depth     \n"
-		    "#                 ||||| / _--=> preempt-lazy-depth\n"
-		    "#                 |||||| / _-=> migrate-disable   \n"
-		    "#                 ||||||| /     delay             \n"
-		    "#  cmd     pid    |||||||| time  |   caller       \n"
-		    "#     \\   /      ||||||||  \\   |   /            \n");
+	seq_puts(m, "#                  _--------=> CPU#              \n"
+		    "#                 / _-------=> irqs-off          \n"
+		    "#                | / _------=> need-resched      \n"
+		    "#                || / _-----=> need-resched_lazy \n"
+		    "#                ||| / _----=> hardirq/softirq   \n"
+		    "#                |||| / _---=> preempt-depth     \n"
+		    "#                ||||| / _--=> preempt-lazy-depth\n"
+		    "#                |||||| / _-=> migrate-disable   \n"
+		    "#                ||||||| /     delay             \n"
+		    "# cmd     pid    |||||||| time   |  caller       \n"
+		    "#     \\   /      ||||||||   \\    |  /            \n");
 }
 
 static void print_event_info(struct trace_buffer *buf, struct seq_file *m)
@@ -2601,11 +2601,11 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 		    "#                            |/  _-----=> need-resched_lazy\n"
 		    "#                            || / _---=> hardirq/softirq\n"
 		    "#                            ||| / _--=> preempt-depth\n"
-		    "#                            |||| /_--=> preempt-lazy-depth\n"
-		    "#                            |||||  _-=> migrate-disable   \n"
-		    "#                            ||||| /    delay\n"
-		    "#           TASK-PID   CPU#  ||||||    TIMESTAMP  FUNCTION\n"
-		    "#              | |       |   ||||||       |         |\n");
+		    "#                            |||| / _-=> preempt-lazy-depth\n"
+		    "#                            ||||| / _-=> migrate-disable   \n"
+		    "#                            |||||| /    delay\n"
+		    "#           TASK-PID   CPU#  |||||||   TIMESTAMP  FUNCTION\n"
+		    "#              | |       |   |||||||      |         |\n");
 }
 
 void
diff --git a/localversion-rt b/localversion-rt
index 2af6c89aee6d..629e0b4384b8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt40
+-rt41
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e819dffd142c..873d9bdb94fd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -68,6 +68,7 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
+#include <linux/locallock.h>
 
 /*
  * This must be power of 2 and greater than of equal to sizeof(link_free).
@@ -398,6 +399,7 @@ static unsigned int get_maxobj_per_zspage(int size, int pages_per_zspage)
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_LOCAL_IRQ_LOCK(zs_map_area_lock);
 
 static int is_first_page(struct page *page)
 {
@@ -1289,7 +1291,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
+	area = &get_locked_var(zs_map_area_lock, zs_map_area);
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1342,7 +1344,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_light();
+	put_locked_var(zs_map_area_lock, zs_map_area);
 	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
