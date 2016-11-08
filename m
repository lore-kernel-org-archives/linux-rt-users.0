From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.12.66-rt89
Date: Tue, 8 Nov 2016 18:00:54 -0500
Message-ID: <20161108180054.28488a8d@gandalf.local.home>
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
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:40684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932368AbcKHXA7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 18:00:59 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.12.66-rt89 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.12-rt
  Head SHA1: 6d1cea2a8bf43311f80e2fdccfec3f6544d333cd


Or to build 3.12.66-rt89 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.12.66.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.66-rt89.patch.xz



You can also build from 3.12.66-rt88 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch-3.12.66-rt88-rt89.patch.xz



Enjoy,

-- Steve


Changes from v3.12.66-rt88:

---

Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (1):
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (1):
      Linux 3.12.66-rt89

----
 Makefile             |  2 +-
 kernel/trace/trace.c | 22 +++++++++++-----------
 localversion-rt      |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)
---------------------------
diff --git a/Makefile b/Makefile
index eb81ece69d00..c8ce2ba51358 100644
--- a/Makefile
+++ b/Makefile
@@ -376,7 +376,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -fno-delete-null-pointer-checks \
 		   -std=gnu89
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b65181125705..b8154190571f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2425,17 +2425,17 @@ get_total_entries(struct trace_buffer *buf,
 
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
index 666227d921a3..d2a40223e4b7 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt88
+-rt89
