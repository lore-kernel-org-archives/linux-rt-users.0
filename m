From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.44-rt48
Date: Tue, 8 Nov 2016 18:00:27 -0500
Message-ID: <20161108180027.348ed883@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.18.44-rt48 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: f80743a0e8c29b73350e31ac4b99b6b6e6e324ba


Or to build 3.18.44-rt48 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.44.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.44-rt48.patch.xz



You can also build from 3.18.44-rt47 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.44-rt47-rt48.patch.xz



Enjoy,

-- Steve


Changes from v3.18.44-rt47:

---

Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (2):
      zsmalloc: turn that get_cpu_light() into a local_lock()
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (2):
      x86: Fix bad backport for should_resched() update
      Linux 3.18.44-rt48

----
 Makefile                       |  2 +-
 arch/x86/include/asm/preempt.h |  3 ++-
 kernel/trace/trace.c           | 22 +++++++++++-----------
 localversion-rt                |  2 +-
 mm/zsmalloc.c                  |  6 ++++--
 5 files changed, 19 insertions(+), 16 deletions(-)
---------------------------
diff --git a/Makefile b/Makefile
index 05b64e6d1456..1c4d33691068 100644
--- a/Makefile
+++ b/Makefile
@@ -401,7 +401,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -std=gnu89
 
 KBUILD_AFLAGS_KERNEL :=
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 6806369bddf5..ba4976828a18 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -111,7 +111,8 @@ static __always_inline bool should_resched(void)
 #ifdef CONFIG_PREEMPT_LAZY
 	u32 tmp;
 
-	if (!raw_cpu_read_4(__preempt_count))
+	tmp = raw_cpu_read_4(__preempt_count);
+	if (!tmp)
 		return true;
 
 	/* preempt count == 0 ? */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bee851402458..ea87215f70dc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2513,17 +2513,17 @@ get_total_entries(struct trace_buffer *buf,
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                   _--------=> CPU#              \n");
-	seq_puts(m, "#                  / _-------=> irqs-off          \n");
-	seq_puts(m, "#                 | / _------=> need-resched      \n");
-	seq_puts(m, "#                 || / _-----=> need-resched_lazy \n");
-	seq_puts(m, "#                 ||| / _----=> hardirq/softirq   \n");
-	seq_puts(m, "#                 |||| / _---=> preempt-depth     \n");
-	seq_puts(m, "#                 ||||| / _--=> preempt-lazy-depth\n");
-	seq_puts(m, "#                 |||||| / _-=> migrate-disable   \n");
-	seq_puts(m, "#                 ||||||| /     delay             \n");
-	seq_puts(m, "#  cmd     pid    |||||||| time  |   caller       \n");
-	seq_puts(m, "#     \\   /      ||||||||  \\   |   /            \n");
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
diff --git a/localversion-rt b/localversion-rt
index 8a777ac42aab..24707986c321 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt47
+-rt48
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1db2077e38f7..85028f8a5ed3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -93,6 +93,7 @@
 #include <linux/types.h>
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
+#include <linux/locallock.h>
 
 /*
  * This must be power of 2 and greater than of equal to sizeof(link_free).
@@ -318,6 +319,7 @@ MODULE_ALIAS("zpool-zsmalloc");
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_LOCAL_IRQ_LOCK(zs_map_area_lock);
 
 static int is_first_page(struct page *page)
 {
@@ -1127,7 +1129,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = &pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
+	area = &get_locked_var(zs_map_area_lock, zs_map_area);
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1173,7 +1175,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_light();
+	put_locked_var(zs_map_area_lock, zs_map_area);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
