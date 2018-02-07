From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 04/20 v2] tracing/x86: Add arch_get_func_args() function
Date: Wed, 07 Feb 2018 15:24:06 -0500
Message-ID: <20180207202815.165691124@goodmis.org>
References: <20180207202402.253089656@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-tracing-x86-Add-arch_get_func_args-function.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add function to get the function arguments from pt_regs.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6f263e..5e845c8cf89d 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -46,6 +46,34 @@ int ftrace_arch_code_modify_post_process(void)
 	return 0;
 }
 
+int arch_get_func_args(struct pt_regs *regs,
+		       int start, int end, long *args)
+{
+#ifdef CONFIG_X86_64
+# define MAX_ARGS 6
+# define INIT_REGS				\
+	{	regs->di, regs->si, regs->dx,	\
+		regs->cx, regs->r8, regs->r9	\
+	}
+#else
+# define MAX_ARGS 3
+# define INIT_REGS				\
+	{	regs->ax, regs->dx, regs->cx	}
+#endif
+	if (!regs)
+		return MAX_ARGS;
+
+	{
+		long pt_args[] = INIT_REGS;
+		int i;
+
+		for (i = start; i <= end && i < MAX_ARGS; i++)
+			args[i - start] = pt_args[i];
+
+		return i - start;
+	}
+}
+
 union ftrace_code_union {
 	char code[MCOUNT_INSN_SIZE];
 	struct {
-- 
2.15.1
