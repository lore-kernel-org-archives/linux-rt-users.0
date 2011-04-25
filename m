From: Geunsik Lim <leemgs1@gmail.com>
Subject: [PATCH 2/4] munmap: sysctl extension for tunable parameter
Date: Mon, 25 Apr 2011 19:44:30 +0900
Message-ID: <1303728272-11408-3-git-send-email-leemgs1@gmail.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Geunsik Lim <geunsik.lim@samsung.com>

Support sysctl interface(tunalbe parameter) to find a suitable munmap
operation unit at runtime favoringly

* sysctl: An interface for examining and dynamically changing munmap opearon
          size parameters in Linux. In Linux, the sysctl is implemented as
	  a wrapper around file system routines that access contents of files
	  in the /proc

Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
Acked-by: Hyunjin Choi <hj89.choi@samsung.com>
---
 kernel/sysctl.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c0bb324..9b85041 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -56,6 +56,7 @@
 #include <linux/kprobes.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/oom.h>
+#include <linux/munmap_unit_size.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -1278,6 +1279,15 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= mmap_min_addr_handler,
 	},
 #endif
+#ifdef CONFIG_MMU
+	{
+		.procname	= "munmap_unit_size",
+		.data		= &sysctl_munmap_unit_size,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= munmap_unit_size_handler,
+	},
+#endif
 #ifdef CONFIG_NUMA
 	{
 		.procname	= "numa_zonelist_order",
-- 
1.7.3.4
