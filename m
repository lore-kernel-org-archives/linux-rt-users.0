From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.104-rt117
Date: Tue, 8 Nov 2016 18:01:18 -0500
Message-ID: <20161108180118.352d45a7@gandalf.local.home>
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
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:40719 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751427AbcKHXBW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 18:01:22 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.10.104-rt117 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: 44ab5677794d6b76734ab682059c17cb858ea26c


Or to build 3.10.104-rt117 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.104.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.104-rt117.patch.xz



You can also build from 3.10.104-rt116 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.104-rt116-rt117.patch.xz



Enjoy,

-- Steve


Changes from v3.10.104-rt116:

---

Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (1):
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (1):
      Linux 3.10.104-rt117

----
 Makefile             |  2 +-
 kernel/trace/trace.c | 22 +++++++++++-----------
 localversion-rt      |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)
---------------------------
diff --git a/Makefile b/Makefile
index f6a2cbd438a1..b39af4b539af 100644
--- a/Makefile
+++ b/Makefile
@@ -372,7 +372,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -fno-delete-null-pointer-checks \
 		   -std=gnu89
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e16f5be456b3..4f04527ce506 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2411,17 +2411,17 @@ get_total_entries(struct trace_buffer *buf,
 
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
index 34eca4e89203..9788245dd428 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt116
+-rt117
