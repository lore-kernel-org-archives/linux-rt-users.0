From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 13/40] tracing: Make traceprobe parsing code reusable
Date: Tue,  5 Sep 2017 16:57:25 -0500
Message-ID: <10800d7d090426b46ad29ba7064ca67106d02759.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

traceprobe_probes_write() and traceprobe_command() actually contain
nothing that ties them to kprobes - the code is generically useful for
similar types of parsing elsewhere, so separate it out and move it to
trace.c/trace.h.

Other than moving it, the only change is in naming:
traceprobe_probes_write() becomes trace_parse_run_command() and
traceprobe_command() becomes trace_run_command().

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c        | 86 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h        |  7 ++++
 kernel/trace/trace_kprobe.c | 18 +++++-----
 kernel/trace/trace_probe.c  | 86 ---------------------------------------------
 kernel/trace/trace_probe.h  |  7 ----
 kernel/trace/trace_uprobe.c |  2 +-
 6 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 719e4c1..b03813b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8295,6 +8295,92 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 }
 EXPORT_SYMBOL_GPL(ftrace_dump);
 
+int trace_run_command(const char *buf, int (*createfn)(int, char **))
+{
+	char **argv;
+	int argc, ret;
+
+	argc = 0;
+	ret = 0;
+	argv = argv_split(GFP_KERNEL, buf, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	if (argc)
+		ret = createfn(argc, argv);
+
+	argv_free(argv);
+
+	return ret;
+}
+
+#define WRITE_BUFSIZE  4096
+
+ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos,
+				int (*createfn)(int, char **))
+{
+	char *kbuf, *buf, *tmp;
+	int ret = 0;
+	size_t done = 0;
+	size_t size;
+
+	kbuf = kmalloc(WRITE_BUFSIZE, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	while (done < count) {
+		size = count - done;
+
+		if (size >= WRITE_BUFSIZE)
+			size = WRITE_BUFSIZE - 1;
+
+		if (copy_from_user(kbuf, buffer + done, size)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		kbuf[size] = '\0';
+		buf = kbuf;
+		do {
+			tmp = strchr(buf, '\n');
+			if (tmp) {
+				*tmp = '\0';
+				size = tmp - buf + 1;
+			} else {
+				size = strlen(buf);
+				if (done + size < count) {
+					if (buf != kbuf)
+						break;
+					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
+					pr_warn("Line length is too long: Should be less than %d\n",
+						WRITE_BUFSIZE - 2);
+					ret = -EINVAL;
+					goto out;
+				}
+			}
+			done += size;
+
+			/* Remove comments */
+			tmp = strchr(buf, '#');
+
+			if (tmp)
+				*tmp = '\0';
+
+			ret = trace_run_command(buf, createfn);
+			if (ret)
+				goto out;
+			buf += size;
+
+		} while (done < count);
+	}
+	ret = done;
+
+out:
+	kfree(kbuf);
+
+	return ret;
+}
+
 __init static int tracer_alloc_buffers(void)
 {
 	int ring_buf_size;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2ce3bde..2fed4ed 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1756,6 +1756,13 @@ extern int trace_event_enable_disable(struct trace_event_file *file,
 int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
 
+#define MAX_EVENT_NAME_LEN	64
+
+extern int trace_run_command(const char *buf, int (*createfn)(int, char**));
+extern ssize_t trace_parse_run_command(struct file *file,
+		const char __user *buffer, size_t count, loff_t *ppos,
+		int (*createfn)(int, char**));
+
 /*
  * Normal trace_printk() and friends allocates special buffers
  * to do the manipulation, as well as saves the print formats
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c9b5aa1..996902a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -907,8 +907,8 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return traceprobe_probes_write(file, buffer, count, ppos,
-			create_trace_kprobe);
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_trace_kprobe);
 }
 
 static const struct file_operations kprobe_events_ops = {
@@ -1433,9 +1433,9 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	pr_info("Testing kprobe tracing: ");
 
-	ret = traceprobe_command("p:testprobe kprobe_trace_selftest_target "
-				  "$stack $stack0 +0($stack)",
-				  create_trace_kprobe);
+	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target "
+				"$stack $stack0 +0($stack)",
+				create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function entry.\n");
 		warn++;
@@ -1455,8 +1455,8 @@ static __init int kprobe_trace_self_tests_init(void)
 		}
 	}
 
-	ret = traceprobe_command("r:testprobe2 kprobe_trace_selftest_target "
-				  "$retval", create_trace_kprobe);
+	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target "
+				"$retval", create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function return.\n");
 		warn++;
@@ -1526,13 +1526,13 @@ static __init int kprobe_trace_self_tests_init(void)
 			disable_trace_kprobe(tk, file);
 	}
 
-	ret = traceprobe_command("-:testprobe", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe", create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
-	ret = traceprobe_command("-:testprobe2", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe2", create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 52478f0..d593573 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -623,92 +623,6 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 	kfree(arg->comm);
 }
 
-int traceprobe_command(const char *buf, int (*createfn)(int, char **))
-{
-	char **argv;
-	int argc, ret;
-
-	argc = 0;
-	ret = 0;
-	argv = argv_split(GFP_KERNEL, buf, &argc);
-	if (!argv)
-		return -ENOMEM;
-
-	if (argc)
-		ret = createfn(argc, argv);
-
-	argv_free(argv);
-
-	return ret;
-}
-
-#define WRITE_BUFSIZE  4096
-
-ssize_t traceprobe_probes_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos,
-				int (*createfn)(int, char **))
-{
-	char *kbuf, *buf, *tmp;
-	int ret = 0;
-	size_t done = 0;
-	size_t size;
-
-	kbuf = kmalloc(WRITE_BUFSIZE, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
-	while (done < count) {
-		size = count - done;
-
-		if (size >= WRITE_BUFSIZE)
-			size = WRITE_BUFSIZE - 1;
-
-		if (copy_from_user(kbuf, buffer + done, size)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		kbuf[size] = '\0';
-		buf = kbuf;
-		do {
-			tmp = strchr(buf, '\n');
-			if (tmp) {
-				*tmp = '\0';
-				size = tmp - buf + 1;
-			} else {
-				size = strlen(buf);
-				if (done + size < count) {
-					if (buf != kbuf)
-						break;
-					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
-					pr_warn("Line length is too long: Should be less than %d\n",
-						WRITE_BUFSIZE - 2);
-					ret = -EINVAL;
-					goto out;
-				}
-			}
-			done += size;
-
-			/* Remove comments */
-			tmp = strchr(buf, '#');
-
-			if (tmp)
-				*tmp = '\0';
-
-			ret = traceprobe_command(buf, createfn);
-			if (ret)
-				goto out;
-			buf += size;
-
-		} while (done < count);
-	}
-	ret = done;
-
-out:
-	kfree(kbuf);
-
-	return ret;
-}
-
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 			   bool is_return)
 {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 903273c..fb66e3e 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -42,7 +42,6 @@
 
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		63
-#define MAX_EVENT_NAME_LEN	64
 #define MAX_STRING_SIZE		PATH_MAX
 
 /* Reserved field names */
@@ -356,12 +355,6 @@ extern int traceprobe_conflict_field_name(const char *name,
 
 extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
 
-extern ssize_t traceprobe_probes_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *ppos,
-		int (*createfn)(int, char**));
-
-extern int traceprobe_command(const char *buf, int (*createfn)(int, char**));
-
 /* Sum up total data length for dynamic arraies (strings) */
 static nokprobe_inline int
 __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a7581fe..402120b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -651,7 +651,7 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return traceprobe_probes_write(file, buffer, count, ppos, create_trace_uprobe);
+	return trace_parse_run_command(file, buffer, count, ppos, create_trace_uprobe);
 }
 
 static const struct file_operations uprobe_events_ops = {
-- 
1.9.3
